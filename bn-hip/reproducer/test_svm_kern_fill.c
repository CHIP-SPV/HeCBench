// Test: SVM alloc → kernel using SVM → clEnqueueSVMMemFill (same pattern as bn-hip)
#define CL_TARGET_OPENCL_VERSION 200
#include <CL/cl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Kernel that reads/writes SVM memory (coarse-grain)
const char *KernelSrc =
    "__kernel void compute(__global float *D_localscore, __global int *D_data, "
    "    __global float *D_LG, int sizepernode, int NODE_N, int DATA_N) {"
    "  int id = get_global_id(0);"
    "  if (id >= sizepernode) return;"
    "  for (int node = 0; node < NODE_N; node++) {"
    "    float acc = 0.0f;"
    "    for (int t1 = 0; t1 < DATA_N; t1++) {"
    "      acc += D_LG[D_data[t1*NODE_N+node] & 1];"
    "    }"
    "    D_localscore[node * sizepernode + id] += acc;"
    "  }"
    "}";

int main() {
    cl_platform_id plat;
    cl_device_id dev;
    cl_int err;
    clGetPlatformIDs(1, &plat, NULL);
    clGetDeviceIDs(plat, CL_DEVICE_TYPE_GPU, 1, &dev, NULL);

    char name[256];
    clGetDeviceInfo(dev, CL_DEVICE_NAME, sizeof(name), name, NULL);
    printf("Device: %s\n", name);

    cl_device_svm_capabilities svm_caps;
    clGetDeviceInfo(dev, CL_DEVICE_SVM_CAPABILITIES, sizeof(svm_caps), &svm_caps, NULL);
    printf("SVM coarse-grain: %s\n", (svm_caps & CL_DEVICE_SVM_COARSE_GRAIN_BUFFER) ? "yes" : "no");

    cl_context ctx = clCreateContext(NULL, 1, &dev, NULL, NULL, &err);
    cl_command_queue q = clCreateCommandQueue(ctx, dev, 0, &err);

    cl_program prog = clCreateProgramWithSource(ctx, 1, &KernelSrc, NULL, &err);
    err = clBuildProgram(prog, 1, &dev, NULL, NULL, NULL);
    if (err != CL_SUCCESS) {
        size_t log_size; clGetProgramBuildInfo(prog, dev, CL_PROGRAM_BUILD_LOG, 0, NULL, &log_size);
        char *log = malloc(log_size); clGetProgramBuildInfo(prog, dev, CL_PROGRAM_BUILD_LOG, log_size, log, NULL);
        printf("Build failed: %d\n%s\n", err, log); free(log); return 1;
    }
    cl_kernel k = clCreateKernel(prog, "compute", &err);

    // Same sizes as bn-hip
    const int NODE_N = 45, DATA_N = 600, sizepernode = 149986;
    size_t localscore_sz = (size_t)NODE_N * sizepernode * sizeof(float);
    size_t data_sz = (size_t)NODE_N * DATA_N * sizeof(int);
    size_t LG_sz = (DATA_N + 2) * sizeof(float);

    // Allocate all as SVM
    void *D_localscore = clSVMAlloc(ctx, CL_MEM_READ_WRITE, localscore_sz, 0);
    void *D_data       = clSVMAlloc(ctx, CL_MEM_READ_WRITE, data_sz, 0);
    void *D_LG         = clSVMAlloc(ctx, CL_MEM_READ_WRITE, LG_sz, 0);
    printf("Allocations: D_localscore=%p D_data=%p D_LG=%p\n", D_localscore, D_data, D_LG);
    if (!D_localscore || !D_data || !D_LG) { printf("FAIL: SVM alloc\n"); return 1; }

    // memset D_localscore to 0 (same as bn-hip line 90)
    char zero = 0;
    err = clEnqueueSVMMemFill(q, D_localscore, &zero, 1, localscore_sz, 0, NULL, NULL);
    printf("Initial SVM fill D_localscore (%.1f MB): %s (err=%d)\n",
           (double)localscore_sz/(1024*1024), err==CL_SUCCESS?"OK":"FAIL", err);

    // Launch kernel (like genScoreKernel)
    clSetKernelArgSVMPointer(k, 0, D_localscore);
    clSetKernelArgSVMPointer(k, 1, D_data);
    clSetKernelArgSVMPointer(k, 2, D_LG);
    clSetKernelArg(k, 3, sizeof(int), &sizepernode);
    clSetKernelArg(k, 4, sizeof(int), &NODE_N);
    clSetKernelArg(k, 5, sizeof(int), &DATA_N);

    size_t gsize = ((size_t)sizepernode / 256 + 1) * 256;
    size_t lsize = 256;
    err = clEnqueueNDRangeKernel(q, k, 1, NULL, &gsize, &lsize, 0, NULL, NULL);
    printf("clEnqueueNDRangeKernel: %s (err=%d)\n", err==CL_SUCCESS?"OK":"FAIL", err);

    err = clFinish(q);
    printf("clFinish after kernel: %s (err=%d)\n", err==CL_SUCCESS?"OK":"FAIL", err);

    // Now fill small SVM buffers (like findBestGraph does)
    size_t D_resP_sz = (size_t)(sizepernode / 256 + 1) * 4 * sizeof(int);
    void *D_resP = clSVMAlloc(ctx, CL_MEM_READ_WRITE, D_resP_sz, 0);
    size_t blocknum = sizepernode / 256 + 1;
    
    err = clEnqueueSVMMemFill(q, D_resP, &zero, 1, blocknum * 4 * sizeof(int), 0, NULL, NULL);
    printf("clEnqueueSVMMemFill D_resP after kernel (%zu bytes): %s (err=%d)\n",
           blocknum * 4 * sizeof(int), err==CL_SUCCESS?"OK":"FAIL", err);

    clSVMFree(ctx, D_localscore);
    clSVMFree(ctx, D_data);
    clSVMFree(ctx, D_LG);
    if (D_resP) clSVMFree(ctx, D_resP);
    clReleaseKernel(k);
    clReleaseProgram(prog);
    clReleaseCommandQueue(q);
    clReleaseContext(ctx);
    return 0;
}
