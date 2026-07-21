#include <hip/hip_runtime.h>
#include "tc.h"

// CPU reference triangle count.
//
// It reproduces EXACTLY the quantity the GPU driver sums into `sumTriangles`:
// for every directed edge (src, dest) with src != dest and both endpoints of
// degree >= 2, add |adj(src) intersect adj(dest)| (the number of common
// neighbours).  For an undirected graph this counts every triangle once per
// directed edge, i.e. sumTriangles == 6 * (number of distinct triangles).
template <typename T>
long long cpuReferenceSum(const T* off, const T* ind, T nv)
{
  long long total = 0;
  for (T src = 0; src < nv; src++) {
    T srcBeg = off[src], srcEnd = off[src + 1];
    T srcLen = srcEnd - srcBeg;
    for (T e = srcBeg; e < srcEnd; e++) {
      T dest    = ind[e];
      T destBeg = off[dest], destEnd = off[dest + 1];
      T destLen = destEnd - destBeg;
      if (src == dest || destLen < 2 || srcLen < 2) continue;

      // sorted-list intersection of adj(src) and adj(dest)
      T i = srcBeg, j = destBeg;
      while (i < srcEnd && j < destEnd) {
        T a = ind[i], b = ind[j];
        if (a == b) { total++; i++; j++; }
        else if (a < b) i++;
        else j++;
      }
    }
  }
  return total;
}

// Read the GPU's summed triangle count out of the TSV the driver writes to
// (fileName + ".o." + blocks).  Returns the sumTriangles column (last field)
// of the first data row, or -1 on failure.  Also cross-checks that every data
// row reports the same value.
static long long readGpuSumFromTSV(const std::string& outName, bool& consistent)
{
  consistent = true;
  std::ifstream in(outName);
  if (!in) return -1;
  std::string line;
  if (!std::getline(in, line)) return -1;  // header
  long long first = -1;
  while (std::getline(in, line)) {
    if (line.empty()) continue;
    size_t pos = line.find_last_of('\t');
    if (pos == std::string::npos) continue;
    long long v = atoll(line.c_str() + pos + 1);
    if (first < 0) first = v;
    else if (v != first) consistent = false;
  }
  return first;
}

int main(int argc, char** argv)
{
  if (argc < 2) {
    printf("usage: %s <graph.egr> [blocks]\n", argv[0]);
    return 1;
  }

  Param param;
  param.fileName = argv[1];
  param.blocks   = (argc >= 3) ? (unsigned int)atoi(argv[2]) : 100u;

  // Run the GPU triangle-counting pipeline (writes a TSV, prints nothing).
  allParamTestGPURun<int>(param);

  // Recover the GPU's summed result from the TSV it produced.
  std::string outName = param.fileName + std::string(".o.") +
                        std::to_string(param.blocks);
  bool consistent = true;
  long long gpuSum = readGpuSumFromTSV(outName, consistent);

  // Independent CPU reference over the same CSR.
  int *off = nullptr, *ind = nullptr, nv = 0, ne = 0;
  if (!readGraph<int>(param.fileName, off, ind, nv, ne)) {
    printf("FAIL: could not read graph for CPU reference\n");
    return 1;
  }
  long long cpuSum = cpuReferenceSum<int>(off, ind, nv);
  delete[] off;
  delete[] ind;

  printf("input: %s\n", param.fileName.c_str());
  printf("vertices: %d  edges: %d  blocks: %u\n", nv, ne, param.blocks);
  printf("GPU sumTriangles (6x, per directed edge): %lld\n", gpuSum);
  printf("CPU sumTriangles (6x, per directed edge): %lld\n", cpuSum);
  if (cpuSum >= 0 && cpuSum % 6 == 0)
    printf("distinct triangles: %lld\n", cpuSum / 6);
  if (!consistent)
    printf("WARNING: GPU TSV rows disagree on sumTriangles\n");

  bool match = (gpuSum >= 0) && (gpuSum == cpuSum) && consistent;
  printf("%s\n", match ? "PASS" : "FAIL");
  return match ? 0 : 1;
}
