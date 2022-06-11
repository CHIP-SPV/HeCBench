/*
GFC code: A GPU-based compressor for arrays of double-precision
floating-point values.

Copyright (c) 2011-2020, Texas State University. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

   * Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.
   * Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in the
     documentation and/or other materials provided with the distribution.
   * Neither the name of Texas State University nor the names of its
     contributors may be used to endorse or promote products derived from
     this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL TEXAS STATE UNIVERSITY BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Authors: Molly A. O'Neil and Martin Burtscher

URL: The latest version of this code is available at
https://userweb.cs.txstate.edu/~burtscher/research/GFC/.

Publication: This work is described in detail in the following paper.
Molly A. O'Neil and Martin Burtscher. Floating-Point Data Compression at 75
Gb/s on a GPU. Proceedings of the Fourth Workshop on General Purpose Processing
Using GPUs, pp. 7:1-7:7. March 2011.
*/

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <chrono>
#include <cuda.h>
#include "kernels.h"

static void CheckTest(const char *msg)
{
  cudaError_t e;
  cudaDeviceSynchronize();
  if (cudaSuccess != (e = cudaGetLastError())) {
    fprintf(stderr, "%s: %d\n", msg, e);
    fprintf(stderr, "%s\n", cudaGetErrorString(e));
  }
}

/************************************************************************************/

static void Compress(int blocks, int warpsperblock, int repeat, int dimensionality)
{
  cudaGetLastError();  // reset error value

  // allocate CPU buffers
  ull *cbuf = (ull *)malloc(sizeof(ull) * MAX); // uncompressed data
  if (cbuf == NULL) {
    fprintf(stderr, "cannot allocate cbuf\n");
  }
  char *dbuf = (char *)malloc(sizeof(char) * ((MAX+1)/2*17)); // compressed data
  if (dbuf == NULL) {
    fprintf(stderr, "cannot allocate dbuf\n");
  }
  int *cut = (int *)malloc(sizeof(int) * blocks * warpsperblock); // chunk boundaries
  if (cut == NULL) {
    fprintf(stderr, "cannot allocate cut\n");
  }
  int *off = (int *)malloc(sizeof(int) * blocks * warpsperblock); // offset table
  if (off == NULL) {
    fprintf(stderr, "cannot allocate off\n");
  }

  // read in trace to cbuf
  int doubles = fread(cbuf, 8, MAX, stdin);

  // calculate required padding for last chunk
  int padding = ((doubles + WARPSIZE - 1) & -WARPSIZE) - doubles;
  doubles += padding;

  // determine chunk assignments per warp
  int per = (doubles + blocks * warpsperblock - 1) / (blocks * warpsperblock);
  if (per < WARPSIZE) per = WARPSIZE;
  per = (per + WARPSIZE - 1) & -WARPSIZE;
  int curr = 0, before = 0, d = 0;
  for (int i = 0; i < blocks * warpsperblock; i++) {
    curr += per;
    cut[i] = min(curr, doubles);
    if (cut[i] - before > 0) {
      d = cut[i] - before;
    }
    before = cut[i];
  }

  // set the pad values to ensure correct prediction
  if (d <= WARPSIZE) {
    for (int i = doubles - padding; i < doubles; i++) {
      cbuf[i] = 0;
    }
  } else {
    for (int i = doubles - padding; i < doubles; i++) {
      cbuf[i] = cbuf[(i & -WARPSIZE) - (dimensionality - i % dimensionality)];
    }
  }

  // allocate GPU buffers
  ull *cbufl; // uncompressed data
  char *dbufl; // compressed data
  int *cutl; // chunk boundaries
  int *offl; // offset table

  if (cudaSuccess != cudaMalloc((void **)&cbufl, sizeof(ull) * doubles))
    fprintf(stderr, "could not allocate cbufd\n");

  if (cudaSuccess != cudaMalloc((void **)&dbufl, sizeof(char) * ((doubles+1)/2*17)))
    fprintf(stderr, "could not allocate dbufd\n");

  if (cudaSuccess != cudaMalloc((void **)&cutl, sizeof(int) * blocks * warpsperblock))
    fprintf(stderr, "could not allocate cutd\n");

  if (cudaSuccess != cudaMalloc((void **)&offl, sizeof(int) * blocks * warpsperblock))
    fprintf(stderr, "could not allocate offd\n");

  // copy CPU buffer contents to GPU
  if (cudaSuccess != cudaMemcpy(cbufl, cbuf, sizeof(ull) * doubles, cudaMemcpyHostToDevice))
    fprintf(stderr, "copying of cbuf to device failed\n");

  if (cudaSuccess != cudaMemcpy(cutl, cut, sizeof(int) * blocks * warpsperblock, cudaMemcpyHostToDevice))
    fprintf(stderr, "copying of cut to device failed\n");

  cudaDeviceSynchronize();
  auto start = std::chrono::steady_clock::now();

  for (int i = 0; i < repeat; i++)
    CompressionKernel<<<blocks, WARPSIZE*warpsperblock>>>(
      dimensionality, cbufl, dbufl, cutl, offl);
  CheckTest("compression kernel launch failed"); // cudaDeviceSynchronize();

  auto end = std::chrono::steady_clock::now();
  auto time = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
  fprintf(stderr, "Average compression kernel execution time %f (s)\n", (time * 1e-9f) / repeat);

  // transfer offsets back to CPU
  if(cudaSuccess != cudaMemcpy(off, offl, sizeof(int) * blocks * warpsperblock, cudaMemcpyDeviceToHost))
    fprintf(stderr, "copying of off from device failed\n");

  // output header
  int num;
  int doublecnt = doubles-padding;
  num = fwrite(&blocks, 1, 1, stdout);
  assert(1 == num);
  num = fwrite(&warpsperblock, 1, 1, stdout);
  assert(1 == num);
  num = fwrite(&dimensionality, 1, 1, stdout);
  assert(1 == num);
  num = fwrite(&doublecnt, 4, 1, stdout);
  assert(1 == num);
  // output offset table
  for(int i = 0; i < blocks * warpsperblock; i++) {
    int start = 0;
    if(i > 0) start = cut[i-1];
    off[i] -= ((start+1)/2*17);
    num = fwrite(&off[i], 4, 1, stdout); // chunk's compressed size in bytes
    assert(1 == num);
  }
  // output compressed data by chunk
  for(int i = 0; i < blocks * warpsperblock; i++) {
    int offset, start = 0;
    if(i > 0) start = cut[i-1];
    offset = ((start+1)/2*17);
    // transfer compressed data back to CPU by chunk
    if (cudaSuccess != cudaMemcpy(dbuf + offset, dbufl + offset, sizeof(char) * off[i], cudaMemcpyDeviceToHost))
      fprintf(stderr, "copying of dbuf from device failed\n");
    num = fwrite(&dbuf[offset], 1, off[i], stdout);
    assert(off[i] == num);
  }

  free(cbuf);
  free(dbuf);
  free(cut);
  free(off);

  if (cudaSuccess != cudaFree(cbufl))
    fprintf(stderr, "could not deallocate cbufd\n");
  if (cudaSuccess != cudaFree(dbufl))
    fprintf(stderr, "could not deallocate dbufd\n");
  if (cudaSuccess != cudaFree(cutl))
    fprintf(stderr, "could not deallocate cutd\n");
  if (cudaSuccess != cudaFree(offl))
    fprintf(stderr, "could not deallocate offd\n");
}

/************************************************************************************/

static void Decompress(int blocks, int warpsperblock,
                       int repeat, int dimensionality, int doubles)
{
  cudaGetLastError();  // reset error value

#ifdef DEBUG
  printf("[Decompress] allocate CPU buffers\n");
#endif
  char *dbuf = (char *)malloc(sizeof(char) * ((MAX+1)/2*17)); // compressed data, divided by chunk
  if (dbuf == NULL) { 
    fprintf(stderr, "cannot allocate dbuf\n");
  }
  ull *fbuf = (ull *)malloc(sizeof(ull) * MAX); // decompressed data
  if (fbuf == NULL) { 
    fprintf(stderr, "cannot allocate fbuf\n");
  }
  int *cut = (int *)malloc(sizeof(int) * blocks * warpsperblock); // chunk boundaries
  if (cut == NULL) { 
    fprintf(stderr, "cannot allocate cut\n");
  }
  int *off = (int *)malloc(sizeof(int) * blocks * warpsperblock); // offset table
  if(off == NULL) {
    fprintf(stderr, "cannot allocate off\n");
  }

#ifdef DEBUG
  printf("[Decompress] read in offset table\n");
#endif
  for(int i = 0; i < blocks * warpsperblock; i++) {
    int num = fread(&off[i], 4, 1, stdin);
    assert(1 == num);
  }

#ifdef DEBUG
  printf("[Decompress] calculate required padding for last chunk\n");
#endif
  int padding = ((doubles + WARPSIZE - 1) & -WARPSIZE) - doubles;
  doubles += padding;

#ifdef DEBUG
  printf("[Decompress] determine chunk assignments per warp\n");
#endif
  int per = (doubles + blocks * warpsperblock - 1) / (blocks * warpsperblock); 
  if (per < WARPSIZE) per = WARPSIZE;
  per = (per + WARPSIZE - 1) & -WARPSIZE;
  int curr = 0;
  for (int i = 0; i < blocks * warpsperblock; i++) {
    curr += per;
    cut[i] = min(curr, doubles);
  }

#ifdef DEBUG
  printf("[Decompress] allocate GPU buffers\n");
#endif
  char *dbufl; // compressed data
  ull *fbufl; // uncompressed data
  int *cutl; // chunk boundaries
  if (cudaSuccess != cudaMalloc((void **)&dbufl, sizeof(char) * ((doubles+1)/2*17)))
    fprintf(stderr, "could not allocate dbufd\n");

  if (cudaSuccess != cudaMalloc((void **)&fbufl, sizeof(ull) * doubles))
    fprintf(stderr, "could not allocate fbufd\n");

  if (cudaSuccess != cudaMalloc((void **)&cutl, sizeof(int) * blocks * warpsperblock))
    fprintf(stderr, "could not allocate cutd\n");

#ifdef DEBUG
  printf("[Decompress] read in input data and divide into chunks\n");
#endif
  for(int i = 0; i < blocks * warpsperblock; i++) {
    int num, chbeg, start = 0;
    if (i > 0) start = cut[i-1];
    chbeg = ((start+1)/2*17);
    // read in this chunk of data (based on offsets)
    num = fread(&dbuf[chbeg], 1, off[i], stdin);
    assert(off[i] == num);
    // transfer the chunk to the GPU
    if (cudaSuccess != cudaMemcpy(dbufl + chbeg, dbuf + chbeg, sizeof(char) * off[i], cudaMemcpyHostToDevice)) 
      fprintf(stderr, "copying of dbuf to device failed\n");
  }
  // copy CPU cut buffer contents to GPU
  if (cudaSuccess != cudaMemcpy(cutl, cut, sizeof(int) * blocks * warpsperblock, cudaMemcpyHostToDevice))
    fprintf(stderr, "copying of cut to device failed\n");

#ifdef DEBUG
  printf("[Decompress] run the kernel for 100 iterations\n");
#endif

  cudaDeviceSynchronize();
  auto start = std::chrono::steady_clock::now();

  for (int i = 0; i < repeat; i++)
    DecompressionKernel<<<blocks, WARPSIZE*warpsperblock>>>(
      dimensionality, dbufl, fbufl, cutl);
  CheckTest("decompression kernel launch failed");

  auto end = std::chrono::steady_clock::now();
  auto time = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
  fprintf(stderr, "Average decompression kernel execution time %f (s)\n", (time * 1e-9f) / repeat);

  // transfer result back to CPU
  if (cudaSuccess != cudaMemcpy(fbuf, fbufl, sizeof(ull) * doubles, cudaMemcpyDeviceToHost))
    fprintf(stderr, "copying of fbuf from device failed\n");

#ifdef DEBUG
  printf("[Decompress] output decompressed data\n");
#endif
  int num = fwrite(fbuf, 8, doubles-padding, stdout);
  assert(num == doubles-padding);

  free(dbuf);
  free(fbuf);
  free(cut);

  if(cudaSuccess != cudaFree(dbufl))
    fprintf(stderr, "could not deallocate dbufd\n");

  if(cudaSuccess != cudaFree(fbufl))
    fprintf(stderr, "could not deallocate dbufd\n");

  if(cudaSuccess != cudaFree(cutl))
    fprintf(stderr, "could not deallocate cutd\n");
}

/************************************************************************************/

static void VerifySystemParameters()
{
  assert(1 == sizeof(char));
  assert(4 == sizeof(int));
  assert(8 == sizeof(ull));

  int val = 1;
  assert(1 == *((char *)&val));
   
  if ((WARPSIZE <= 0) || ((WARPSIZE & (WARPSIZE-1)) != 0)) {
    fprintf(stderr, "Warp size must be greater than zero and a power of two\n");
    exit(-1);
  }
}

/************************************************************************************/

int main(int argc, char *argv[])
{
  fprintf(stderr, "GPU FP Compressor v2.2\n");
  fprintf(stderr, "Copyright 2011-2020 Texas State University\n");

  VerifySystemParameters();

  int blocks, warpsperblock, dimensionality;
  int repeat;

  cudaFuncSetCacheConfig(CompressionKernel, cudaFuncCachePreferL1);
  cudaFuncSetCacheConfig(DecompressionKernel, cudaFuncCachePreferL1);

  if((4 == argc) || (5 == argc)) { /* compress */
    char dummy;
    blocks = atoi(argv[1]);
    assert((0 < blocks) && (blocks < 256));

    warpsperblock = atoi(argv[2]);
    assert((0 < warpsperblock) && (warpsperblock < 256));

    repeat = atoi(argv[3]);

    if(4 == argc) {
      dimensionality = 1;
    } else {
      dimensionality = atoi(argv[4]);
    }
    assert((0 < dimensionality) && (dimensionality <= WARPSIZE));

    Compress(blocks, warpsperblock, repeat, dimensionality);
    assert(0 == fread(&dummy, 1, 1, stdin));
  }
  else if(2 == argc) { /* decompress */

    repeat = atoi(argv[1]);

    int num, doubles;
    num = fread(&blocks, 1, 1, stdin);
    assert(1 == num);
    blocks &= 255;
    num = fread(&warpsperblock, 1, 1, stdin);
    assert(1 == num);
    warpsperblock &= 255;
    num = fread(&dimensionality, 1, 1, stdin);
    assert(1 == num);
    dimensionality &= 255;
    num = fread(&doubles, 4, 1, stdin);
    assert(1 == num);

#ifdef DEBUG
    printf("blocks=%d warps/block=%d repeat=%d dim=%d doubles=%d\n",
           blocks, warpsperblock, repeat, dimensionality, doubles);
#endif
    Decompress(blocks, warpsperblock, repeat, dimensionality, doubles);
  }
  else {
    fprintf(stderr, "usage:\n");
    fprintf(stderr, "compress: %s blocks warps/block (dimensionality) < file.in > file.gfc\n", argv[0]);
    fprintf(stderr, "decompress: %s < file.gfc > file.out\n", argv[0]);
  }

  return 0;
}
