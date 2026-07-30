// Test: does clEnqueueSVMMemFill work after a kernel on the same queue?
#define CL_TARGET_OPENCL_VERSION 200
#include <CL/cl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char *KernelSrc =
    "__kernel void fill(__global float *out, int n) {"
    "  int id = get_global_id(0);"
    "  if (id < n) out[id] = (float)id;"
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

    cl_context ctx = clCreateContext(NULL, 1, &dev, NULL, NULL, &err);
    cl_command_queue q = clCreateCommandQueue(ctx, dev, 0, &err);

    // Build a simple kernel
    cl_program prog = clCreateProgramWithSource(ctx, 1, &KernelSrc, NULL, &err);
    err = clBuildProgram(prog, 1, &dev, NULL, NULL, NULL);
    if (err != CL_SUCCESS) { printf("Build failed: %d\n", err); return 1; }
    cl_kernel k = clCreateKernel(prog, "fill", &err);

    // Allocate output buffer via SVM (coarse-grain)
    size_t n = 149986 * 45;  // same as D_localscore in bn-hip
    size_t sz = n * sizeof(float);
    void *svm_ptr = clSVMAlloc(ctx, CL_MEM_READ_WRITE, sz, 0);
    printf("clSVMAlloc (%.1f MB): %s\n", (double)sz / (1024*1024), svm_ptr ? "OK" : "FAIL");
    if (!svm_ptr) return 1;

    // Create a separate device buffer for the kernel output (to avoid SVM in kernel)
    cl_mem buf = clCreateBuffer(ctx, CL_MEM_READ_WRITE, sz, NULL, &err);
    
    // Launch kernel
    clSetKernelArg(k, 0, sizeof(buf), &buf);
    int ni = (int)n;
    clSetKernelArg(k, 1, sizeof(int), &ni);
    size_t gsize = n, lsize = 256;
    err = clEnqueueNDRangeKernel(q, k, 1, NULL, &gsize, &lsize, 0, NULL, NULL);
    printf("clEnqueueNDRangeKernel: %s (err=%d)\n", err==CL_SUCCESS?"OK":"FAIL", err);
    
    err = clFinish(q);
    printf("clFinish after kernel: %s (err=%d)\n", err==CL_SUCCESS?"OK":"FAIL", err);
    
    // Now try clEnqueueSVMMemFill on the SVM pointer
    char pattern = 0;
    err = clEnqueueSVMMemFill(q, svm_ptr, &pattern, 1, sz, 0, NULL, NULL);
    printf("clEnqueueSVMMemFill after kernel (%.1f MB): %s (err=%d)\n",
           (double)sz / (1024*1024), err==CL_SUCCESS?"OK":"FAIL", err);

    if (err == CL_SUCCESS) {
        err = clFinish(q);
        printf("clFinish after SVM fill: %s (err=%d)\n", err==CL_SUCCESS?"OK":"FAIL", err);
    }

    // Also try smaller SVM allocs like D_resP and D_Score
    size_t small = 587 * 4 * sizeof(int);
    void *small_ptr = clSVMAlloc(ctx, CL_MEM_READ_WRITE, small, 0);
    err = clEnqueueSVMMemFill(q, small_ptr, &pattern, 1, small, 0, NULL, NULL);
    printf("clEnqueueSVMMemFill small (%zu bytes): %s (err=%d)\n",
           small, err==CL_SUCCESS?"OK":"FAIL", err);

    clSVMFree(ctx, svm_ptr);
    clSVMFree(ctx, small_ptr);
    clReleaseMemObject(buf);
    clReleaseKernel(k);
    clReleaseProgram(prog);
    clReleaseCommandQueue(q);
    clReleaseContext(ctx);
    return 0;
}
