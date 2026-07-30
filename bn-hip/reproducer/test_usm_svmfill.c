// Test: does clEnqueueSVMMemFill work on Intel USM device memory?
#define CL_TARGET_OPENCL_VERSION 300
#include <CL/cl.h>
#include <CL/cl_ext.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    cl_platform_id plat;
    cl_device_id dev;
    cl_int err;

    clGetPlatformIDs(1, &plat, NULL);
    clGetDeviceIDs(plat, CL_DEVICE_TYPE_GPU, 1, &dev, NULL);

    char name[256], exts[4096];
    clGetDeviceInfo(dev, CL_DEVICE_NAME, sizeof(name), name, NULL);
    clGetDeviceInfo(dev, CL_DEVICE_EXTENSIONS, sizeof(exts), exts, NULL);
    printf("Device: %s\n", name);
    printf("Has cl_intel_unified_shared_memory: %s\n",
           strstr(exts, "cl_intel_unified_shared_memory") ? "yes" : "no");

    cl_context ctx = clCreateContext(NULL, 1, &dev, NULL, NULL, &err);
    const cl_queue_properties props[] = {0};
    cl_command_queue q = clCreateCommandQueueWithProperties(ctx, dev, props, &err);

    // Get Intel USM functions
    clDeviceMemAllocINTEL_fn clDeviceMemAllocINTEL =
        (clDeviceMemAllocINTEL_fn)clGetExtensionFunctionAddressForPlatform(
            plat, "clDeviceMemAllocINTEL");
    clMemFreeINTEL_fn clMemFreeINTEL =
        (clMemFreeINTEL_fn)clGetExtensionFunctionAddressForPlatform(
            plat, "clMemFreeINTEL");
    clEnqueueMemFillINTEL_fn clEnqueueMemFillINTEL =
        (clEnqueueMemFillINTEL_fn)clGetExtensionFunctionAddressForPlatform(
            plat, "clEnqueueMemFillINTEL");

    if (!clDeviceMemAllocINTEL) { printf("Intel USM not available\n"); return 1; }

    size_t big = 45 * 149986 * 4;  // same as bn-hip
    cl_int err2;
    void *ptr = clDeviceMemAllocINTEL(ctx, dev, NULL, big, 0, &err2);
    printf("clDeviceMemAllocINTEL (%.1f MB): %s (ptr=%p, err=%d)\n",
           (double)big / (1024*1024), (ptr && err2==CL_SUCCESS) ? "OK" : "FAIL", ptr, err2);

    if (ptr) {
        // Try clEnqueueSVMMemFill (what chipStar does)
        char zero = 0;
        err = clEnqueueSVMMemFill(q, ptr, &zero, 1, big, 0, NULL, NULL);
        printf("clEnqueueSVMMemFill on USM device ptr: %s (err=%d)\n",
               err == CL_SUCCESS ? "OK" : "FAIL", err);

        if (clEnqueueMemFillINTEL) {
            // Try the correct API
            err = clEnqueueMemFillINTEL(q, ptr, &zero, 1, big, 0, NULL, NULL);
            printf("clEnqueueMemFillINTEL (correct API): %s (err=%d)\n",
                   err == CL_SUCCESS ? "OK" : "FAIL", err);
        }

        clMemFreeINTEL(ctx, ptr);
    }

    clReleaseCommandQueue(q);
    clReleaseContext(ctx);
    return 0;
}
