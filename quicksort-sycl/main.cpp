/*
   Copyright (c) 2014-2019, Intel Corporation
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions
   are met:
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above
 copyright notice, this list of conditions and the following
 disclaimer in the documentation and/or other materials provided
 with the distribution.
 * Neither the name of Intel Corporation nor the names of its
 contributors may be used to endorse or promote products
 derived from this software without specific prior written
 permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 */

// QuicksortMain.cpp : Defines the entry point for the console application.
//

#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <limits.h>
#include <math.h>
#include <iostream>
#include <algorithm>
#include <iterator>
#include <random>
#include <vector>
#include <map>
#include <sycl/sycl.hpp>

#define RUN_CPU_SORTS
//#define GET_DETAILED_PERFORMANCE

// Types:
typedef unsigned int uint;
#ifdef min
#undef min
#endif
#ifdef max
#undef max
#endif

/// return a timestamp with sub-second precision
/** QueryPerformanceCounter and clock_gettime have an undefined starting point (null/zero)
 *  and can wrap around, i.e. be nulled again. **/
double seconds() {
  struct timespec now;
  clock_gettime(CLOCK_MONOTONIC, &now);
  return now.tv_sec + now.tv_nsec / 1000000000.0;
}


bool parseArgs(int argc, char** argv, unsigned int* test_iterations, unsigned int* widthReSz, unsigned int* heightReSz)
{
  const char sUsageString[512] = "Usage: Quicksort [num test iterations] [SurfWidth(^2 only)] [SurfHeight(^2 only)]";

  if (argc != 4)
  {
    printf(sUsageString);
    return false;
  }
  else
  {
    *test_iterations  = atoi (argv[1]);
    *widthReSz  = atoi (argv[2]);
    *heightReSz  = atoi (argv[3]);
    return true;
  }
}


#include "Quicksort.h"
#include "QuicksortKernels.h"

template <class T>
T* partition(T* left, T* right, T pivot) {
  // move pivot to the end
  T temp = *right;
  *right = pivot;
  *left = temp;

  T* store = left;

  for(T* p = left; p != right; p++) {
    if (*p < pivot) {
      temp = *store;
      *store = *p;
      *p = temp;
      store++;
    }
  }

  temp = *store;
  *store = pivot;
  *right = temp;

  return store;
}

  template <class T>
void quicksort(T* data, int left, int right)
{
  T* store = partition(data + left, data + right, data[left]);
  int nright = store-data;
  int nleft = nright+1;

  if (left < nright) {
    if (nright - left > 32) {
      quicksort(data, left, nright);
    } else
      std::sort(data + left, data + nright + 1);
  }

  if (nleft < right) {
    if (right - nleft > 32)  {
      quicksort(data, nleft, right);
    } else {
      std::sort(data + nleft, data + right + 1);
    }
  }
}

template <class T>
void gqsort(sycl::queue &q, T *db, T *dnb, std::vector<block_record<T>> &blocks,
            std::vector<parent_record> &parents,
            std::vector<work_record<T>> &news, bool reset) {

  news.resize(blocks.size()*2);

#ifdef GET_DETAILED_PERFORMANCE
  static double absoluteTotal = 0.0;
  static uint count = 0;

  if (reset) {
    absoluteTotal = 0.0;
    count = 0;
  }

  double beginClock, endClock;
  beginClock = seconds();
#endif

  block_record<T> *blocksb;
  parent_record *parentsb;
  work_record<T> *newsb;
  blocksb = (block_record<T> *)sycl::malloc_device(
            sizeof(block_record<T>) * blocks.size(), q);
  q.memcpy(blocksb, blocks.data(), sizeof(block_record<T>) * blocks.size());

  parentsb = sycl::malloc_device<parent_record>(parents.size(), q);
  q.memcpy(parentsb, parents.data(), sizeof(parent_record) * parents.size());

  newsb = (work_record<T> *)sycl::malloc_device(sizeof(work_record<T>) * news.size(), q);
  q.memcpy(newsb, news.data(), sizeof(work_record<T>) * news.size());

  q.submit([&](sycl::handler &cgh) {
    sycl::local_accessor<uint, 1> lt_acc(
        sycl::range<1>(GQSORT_LOCAL_WORKGROUP_SIZE+1), cgh);
    sycl::local_accessor<uint, 1> gt_acc(
        sycl::range<1>(GQSORT_LOCAL_WORKGROUP_SIZE+1), cgh);
    sycl::local_accessor<uint, 0> ltsum_acc(cgh);
    sycl::local_accessor<uint, 0> gtsum_acc(cgh);
    sycl::local_accessor<uint, 0> lbeg_acc(cgh);
    sycl::local_accessor<uint, 0> gbeg_acc(cgh);

    cgh.parallel_for(
      sycl::nd_range<1>(GQSORT_LOCAL_WORKGROUP_SIZE * blocks.size(),
        GQSORT_LOCAL_WORKGROUP_SIZE), [=] (sycl::nd_item<1> item) {
          gqsort_kernel(db, dnb, blocksb, parentsb, newsb, item,
                        lt_acc.get_pointer(), gt_acc.get_pointer(),
                        ltsum_acc, gtsum_acc, lbeg_acc,
                        gbeg_acc);
        });
  });

  q.memcpy(news.data(), newsb, sizeof(work_record<T>) * news.size()).wait();

  sycl::free(blocksb, q);
  sycl::free(parentsb, q);
  sycl::free(newsb, q);

#ifdef GET_DETAILED_PERFORMANCE
  endClock = seconds();
  double totalTime = endClock - beginClock;
  absoluteTotal += totalTime;
  std::cout << ++count << ": gqsort time " << absoluteTotal * 1000 << " ms" << std::endl;
#endif

#ifdef DEBUG
  printf("\noutput news\n");
  for (int i = 0; i < news.size(); i++) {
    printf("%u %u %u %u\n", news[i].start, news[i].end, news[i].pivot, news[i].direction);
  }
#endif
}

template <class T>
void lqsort(sycl::queue &q, T *db, T *dnb, std::vector<work_record<T>> &done) {

#ifdef GET_DETAILED_PERFORMANCE
  double beginClock, endClock;
  beginClock = seconds();
#endif
  work_record<T>* doneb;
  //std::cout << "done size is " << done.size() << std::endl;

  doneb = (work_record<T> *)sycl::malloc_device(
          sizeof(work_record<T>) * done.size(), q);
  q.memcpy(doneb, done.data(), sizeof(work_record<T>) * done.size());

  q.submit([&](sycl::handler &cgh) {
    sycl::local_accessor<workstack_record, 1> workstack_acc(
        sycl::range<1>(QUICKSORT_BLOCK_SIZE/SORT_THRESHOLD), cgh);
    sycl::local_accessor<int, 0> workstack_pointer_acc(cgh);
    sycl::local_accessor<T, 1> mys_acc(
        sycl::range<1>(QUICKSORT_BLOCK_SIZE), cgh);
    sycl::local_accessor<T, 1> mysn_acc(
        sycl::range<1>(QUICKSORT_BLOCK_SIZE), cgh);
    sycl::local_accessor<T, 1> temp_acc(
        sycl::range<1>(SORT_THRESHOLD), cgh);
    sycl::local_accessor<uint, 0> ltsum_acc(cgh);
    sycl::local_accessor<uint, 0> gtsum_acc(cgh);
    sycl::local_accessor<uint, 1> lt_acc(
        sycl::range<1>(LQSORT_LOCAL_WORKGROUP_SIZE+1), cgh);
    sycl::local_accessor<uint, 1> gt_acc(
        sycl::range<1>(LQSORT_LOCAL_WORKGROUP_SIZE+1), cgh);

    cgh.parallel_for(
      sycl::nd_range<1>(LQSORT_LOCAL_WORKGROUP_SIZE * done.size(),
        LQSORT_LOCAL_WORKGROUP_SIZE), [=] (sycl::nd_item<1> item) {
          lqsort_kernel(
              db, dnb, doneb, item, workstack_acc.get_pointer(),
              workstack_pointer_acc, mys_acc.get_pointer(),
              mysn_acc.get_pointer(), temp_acc.get_pointer(),
              ltsum_acc, gtsum_acc,
              lt_acc.get_pointer(), gt_acc.get_pointer());
        });
  }).wait();

  // Lets do phase 2 pass
  sycl::free(doneb, q);

#ifdef GET_DETAILED_PERFORMANCE
  endClock = seconds();
  double totalTime = endClock - beginClock;
  std::cout << "lqsort time " << totalTime * 1000 << " ms" << std::endl;
#endif
}

size_t optp(size_t s, double k, size_t m) {
  return (size_t)pow(2, floor(log(s * k + m) / log(2.0) + 0.5));
}

template <class T> void GPUQSort(sycl::queue &q, size_t size, T *d, T *dn) {

  const size_t buffer_size = (sizeof(T)*size/64 + 1) * 64;

  // allocate buffers
  T *db, *dnb;
  db = (T *)sycl::malloc_device(buffer_size, q);
  q.memcpy(db, d, buffer_size);

  dnb = (T *)sycl::malloc_device(buffer_size, q);
  q.memcpy(dnb, dn, buffer_size);

  const size_t MAXSEQ = optp(size, 0.00009516, 203);
  const size_t MAX_SIZE = 12*std::max(MAXSEQ, (size_t)QUICKSORT_BLOCK_SIZE);
  //std::cout << "MAXSEQ = " << MAXSEQ << std::endl;
  uint startpivot = median_host(d[0], d[size/2], d[size-1]);
  std::vector<work_record<T>> work, done, news;
  work.reserve(MAX_SIZE);
  done.reserve(MAX_SIZE);
  news.reserve(MAX_SIZE);
  std::vector<parent_record> parent_records;
  parent_records.reserve(MAX_SIZE);
  std::vector<block_record<T>> blocks;
  blocks.reserve(MAX_SIZE);

  work.push_back(work_record<T>(0, size, startpivot, 1));

  bool reset = true;

  while(!work.empty() /*&& work.size() + done.size() < MAXSEQ*/) {
    size_t blocksize = 0;

    for(auto it = work.begin(); it != work.end(); ++it) {
      blocksize += std::max((it->end - it->start)/MAXSEQ, (size_t)1);
    }
    for(auto it = work.begin(); it != work.end(); ++it) {
      uint start = it->start;
      uint end   = it->end;
      uint pivot = it->pivot;
      uint direction = it->direction;
      uint blockcount = (end - start + blocksize - 1)/blocksize;
      parent_record prnt(start, end, start, end, blockcount-1);
      parent_records.push_back(prnt);

      for(uint i = 0; i < blockcount - 1; i++) {
        uint bstart = start + blocksize*i;
        block_record<T> br(bstart, bstart+blocksize, pivot, direction, parent_records.size()-1);
        blocks.push_back(br);
      }
      block_record<T> br(start + blocksize*(blockcount - 1), end, pivot, direction, parent_records.size()-1);
      blocks.push_back(br);
    }
    //std::cout << " blocks = " << blocks.size() << " parent records = " << parent_records.size() << " news = " << news.size() << std::endl;

    gqsort<T>(q, db, dnb, blocks, parent_records, news, reset);

    reset = false;
    work.clear();
    parent_records.clear();
    blocks.clear();
    for(auto it = news.begin(); it != news.end(); ++it) {
      if (it->direction != EMPTY_RECORD) {
        if (it->end - it->start <= QUICKSORT_BLOCK_SIZE /*size/MAXSEQ*/) {
          if (it->end - it->start > 0)
            done.push_back(*it);
        } else {
          work.push_back(*it);
        }
      }
    }
    news.clear();
  }
  for(auto it = work.begin(); it != work.end(); ++it) {
    if (it->end - it->start > 0)
      done.push_back(*it);
  }

  if (done.size() > 0)
    lqsort<T>(q, db, dnb, done);

  q.memcpy(d, db, buffer_size).wait();
  sycl::free(db, q);
  sycl::free(dnb, q);
}

template <class T>
int test(uint arraySize, unsigned int  NUM_ITERATIONS,
         const std::string& type_name)
{
  double totalTime, quickSortTime, stdSortTime;
  double beginClock, endClock;
  uint num_failures = 0;

  printf("\n\n\n--------------------------------------------------------------------\n");
  printf("Allocating array size of %d (data type: %s)\n", arraySize, type_name.c_str());
  T* pArray = (T*)aligned_alloc (4096, ((arraySize*sizeof(T))/64 + 1)*64);
  T* pArrayCopy = (T*)aligned_alloc (4096, ((arraySize*sizeof(T))/64 + 1)*64);
  std::generate(pArray, pArray + arraySize, [](){static T i = 0; return ++i; });
  std::shuffle(pArray, pArray + arraySize, std::mt19937(19937));

#ifdef RUN_CPU_SORTS
  std::cout << "Sorting the regular way..." << std::endl;
  std::copy(pArray, pArray + arraySize, pArrayCopy);

  beginClock = seconds();
  std::sort(pArrayCopy, pArrayCopy + arraySize);
  endClock = seconds();
  totalTime = endClock - beginClock;
  std::cout << "Time to sort: " << totalTime * 1000 << " ms" << std::endl;
  stdSortTime = totalTime;

  std::cout << "quicksort on the cpu: " << std::endl;
  std::copy(pArray, pArray + arraySize, pArrayCopy);

  beginClock = seconds();
  quicksort(pArrayCopy, 0, arraySize-1);
  endClock = seconds();
  totalTime = endClock - beginClock;
  std::cout << "Time to sort: " << totalTime * 1000 << " ms" << std::endl;
  quickSortTime = totalTime;
#ifdef TRUST_BUT_VERIFY
  {
    std::vector<uint> verify(arraySize);
    std::copy(pArray, pArray + arraySize, verify.begin());

    std::cout << "verifying: ";
    std::sort(verify.begin(), verify.end());
    bool correct = std::equal(verify.begin(), verify.end(), pArrayCopy);
    unsigned int num_discrepancies = 0;
    if (!correct) {
      for(size_t i = 0; i < arraySize; i++) {
        if (verify[i] != pArrayCopy[i]) {
          //std:: cout << "discrepancy at " << i << " " << pArrayCopy[i] << " expected " << verify[i] << std::endl;
          num_discrepancies++;
        }
      }
    }
    std::cout << std::boolalpha << correct << std::endl;
    if (!correct) {
      std::cout << "num_discrepancies: " << num_discrepancies << std::endl;
      ++num_failures;
    }
  }
#endif
#endif // RUN_CPU_SORTS

  std::cout << "Sorting with GPU quicksort: " << std::endl;
  std::vector<uint> original(arraySize);
  std::copy(pArray, pArray + arraySize, original.begin());

#ifdef USE_GPU
  sycl::queue q(sycl::gpu_selector_v, sycl::property::queue::in_order());
#else
  sycl::queue q(sycl::cpu_selector_v, sycl::property::queue::in_order());
#endif

  std::vector<double> times;
  times.resize(NUM_ITERATIONS);
  double AverageTime = 0.0;
  for(uint k = 0; k < NUM_ITERATIONS; k++) {
    std::copy(original.begin(), original.end(), pArray);
    std::vector<uint> seqs;
    std::vector<uint> verify(arraySize);
    std::copy(pArray, pArray + arraySize, verify.begin());

    beginClock = seconds();
    GPUQSort(q, arraySize, pArray, pArrayCopy);
    endClock = seconds();
    totalTime = endClock - beginClock;
    std::cout << "Time to GPU sort: " << totalTime * 1000 << " ms" << std::endl;
    times[k] = totalTime;
    AverageTime += totalTime;
#ifdef TRUST_BUT_VERIFY
    std::cout << "verifying: ";
    std::sort(verify.begin(), verify.end());
    bool correct = std::equal(verify.begin(), verify.end(), pArray);
    unsigned int num_discrepancies = 0;
    if (!correct) {
      for(size_t i = 0; i < arraySize; i++) {
        if (verify[i] != pArray[i]) {
          std:: cout << "discrepancy at " << i << " " << pArray[i] << " expected " << verify[i] << std::endl;
          num_discrepancies++;
        }
      }
    }
    std::cout << std::boolalpha << correct << std::endl;
    if (!correct) {
      std::cout << "num_discrepancies: " << num_discrepancies << std::endl;
      num_failures ++;
    }
#endif
  }
  std::cout << " Number of failures: " << num_failures << " out of " << NUM_ITERATIONS << std::endl;
  if (num_failures > 0) exit(1);

  AverageTime = AverageTime/NUM_ITERATIONS;
  std::cout << "Average Time: " << AverageTime * 1000 << " ms" << std::endl;
  double stdDev = 0.0, minTime = 1000000.0, maxTime = 0.0;
  for(uint k = 0; k < NUM_ITERATIONS; k++)
  {
    stdDev += (AverageTime - times[k])*(AverageTime - times[k]);
    minTime = std::min(minTime, times[k]);
    maxTime = std::max(maxTime, times[k]);
  }

  if (NUM_ITERATIONS > 1) {
    stdDev = sqrt(stdDev/(NUM_ITERATIONS - 1));
    std::cout << "Standard Deviation: " << stdDev * 1000 << std::endl;
    std::cout << "%error (3*stdDev)/Average: " << 3*stdDev / AverageTime * 100 << "%" << std::endl;
    std::cout << "min time: " << minTime * 1000 << " ms" << std::endl;
    std::cout << "max time: " << maxTime * 1000 << " ms" << std::endl;
  }

#ifdef RUN_CPU_SORTS
  std::cout << "Average speedup over CPU quicksort: " << quickSortTime/AverageTime << std::endl;
  std::cout << "Average speedup over CPU std::sort: " << stdSortTime/AverageTime << std::endl;
#endif // RUN_CPU_SORTS

  printf("-------done--------------------------------------------------------\n");
  free(pArray);
  free(pArrayCopy);

  return 0;
}


int main(int argc, char** argv)
{
  unsigned int  NUM_ITERATIONS;
  uint      heightReSz, widthReSz;

  bool success = parseArgs (argc, argv, &NUM_ITERATIONS, &widthReSz, &heightReSz);
  if (!success) return -1;
  uint arraySize = widthReSz*heightReSz;
  test<uint>(arraySize, NUM_ITERATIONS, "uint");
  test<float>(arraySize, NUM_ITERATIONS, "float");
  test<double>(arraySize, NUM_ITERATIONS, "double");
  return 0;
}
