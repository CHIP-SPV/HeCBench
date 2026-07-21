#ifndef TC_H
#define TC_H

// Scaffolding for the tc-hip (triangle counting) benchmark.
//
// tc.cu provides the full GPU pipeline plus the host driver
// allParamTestGPURun<T>(Param) and the launch wrapper kernelCall<T>(...).
// tc.cu #include "tc.h" and depends on the declarations below:
//   - struct Param { std::string fileName; unsigned int blocks; };
//   - globalParam::blockSizeParam / threadPerIntersectionParam (iterated over)
//   - readGraph<T>(fileName, offsetVector, indexVector, vertexCount, edgeCount)
//   - allParamTestGPURun<T>(Param)  (defined + instantiated in tc.cu)
//
// The CSR is read from an ECL binary-CSR file (adapted from mis-cuda/graph.h
// readECLgraph): int nodes, int edges, int nindex[nodes+1], int nlist[edges],
// optional int eweight[edges].  offsetVector/indexVector are freed with delete[]
// in tc.cu, so they MUST be allocated with new[].

#include <string>
#include <fstream>
#include <chrono>
#include <cmath>
#include <cstdlib>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>

struct Param {
  std::string fileName;
  unsigned int blocks;
};

namespace globalParam {
  // Block sizes MUST be a subset of {32,64,96,128,192,256} (kernelCall switch);
  // threads-per-intersection MUST be powers of two that divide the block size
  // (the driver computes log2(tpi) and blockSize/tpi).  Kept small for a fast
  // smoke -- a single (blockSize, tpi) configuration.
  inline constexpr unsigned int blockSizeParam[]            = {128};
  inline constexpr unsigned int threadPerIntersectionParam[] = {8};
}

// Read an ECL binary-CSR graph into new[]-allocated CSR arrays.
// Adjacency lists are sorted ascending (required by the merge-path intersection
// kernel).  Returns true on success.
template <typename T>
bool readGraph(const std::string& fileName,
               T*& offsetVector, T*& indexVector,
               T& vertexCount, T& edgeCount)
{
  FILE* f = fopen(fileName.c_str(), "rb");
  if (f == nullptr) {
    fprintf(stderr, "ERROR: could not open file %s\n", fileName.c_str());
    return false;
  }

  int nodes = 0, edges = 0;
  if (fread(&nodes, sizeof(int), 1, f) != 1) {
    fprintf(stderr, "ERROR: failed to read node count\n"); fclose(f); return false;
  }
  if (fread(&edges, sizeof(int), 1, f) != 1) {
    fprintf(stderr, "ERROR: failed to read edge count\n"); fclose(f); return false;
  }
  if ((nodes < 1) || (edges < 0)) {
    fprintf(stderr, "ERROR: node or edge count too low\n"); fclose(f); return false;
  }

  int* nindex = (int*)malloc((nodes + 1) * sizeof(int));
  int* nlist  = (int*)malloc((edges > 0 ? edges : 1) * sizeof(int));
  if ((nindex == nullptr) || (nlist == nullptr)) {
    fprintf(stderr, "ERROR: host allocation failed\n");
    free(nindex); free(nlist); fclose(f); return false;
  }

  if ((int)fread(nindex, sizeof(int), nodes + 1, f) != nodes + 1) {
    fprintf(stderr, "ERROR: failed to read neighbor index list\n");
    free(nindex); free(nlist); fclose(f); return false;
  }
  if (edges > 0 && (int)fread(nlist, sizeof(int), edges, f) != edges) {
    fprintf(stderr, "ERROR: failed to read neighbor list\n");
    free(nindex); free(nlist); fclose(f); return false;
  }
  // eweight (if present) is ignored.
  fclose(f);

  offsetVector = new T[nodes + 1];
  indexVector  = new T[edges > 0 ? edges : 1];
  for (int i = 0; i <= nodes; i++) offsetVector[i] = (T)nindex[i];
  for (int i = 0; i < edges; i++)  indexVector[i]  = (T)nlist[i];

  // The intersection kernel requires each adjacency list to be sorted ascending.
  for (int v = 0; v < nodes; v++)
    std::sort(indexVector + (size_t)offsetVector[v],
              indexVector + (size_t)offsetVector[v + 1]);

  vertexCount = (T)nodes;
  edgeCount   = (T)edges;

  free(nindex);
  free(nlist);
  return true;
}

// Defined and explicitly instantiated (int, long) in tc.cu -- declare only.
template <typename T> void allParamTestGPURun(Param param);

#endif // TC_H
