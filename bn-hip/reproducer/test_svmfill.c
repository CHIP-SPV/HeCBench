// Test: does clEnqueueSVMMemFill work on this device?
#include <CL/cl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    cl_platform_id plat;
    cl_device_id dev;
    cl_int err;

    err = clGetPlatformIDs(1, &plat, NULL);
    err = clGetDeviceIDs(plat, CL_DEVICE_TYPE_GPU, 1, &dev, NULL);

    char name[256];
    clGetDeviceInfo(dev, CL_DEVICE_NAME, sizeof(name), name, NULL);
    printf("Device: %s\n", name);

    cl_device_svm_capabilities svm_caps;
    clGetDeviceInfo(dev, CL_DEVICE_SVM_CAPABILITIES, sizeof(svm_caps), &svm_caps, NULL);
    printf("SVM caps: 0x%lx\n", (unsigned long)svm_caps);
    printf("  Fine-grain system: %s\n", (svm_caps & CL_DEVICE_SVM_FINE_GRAIN_SYSTEM) ? "yes" : "no");
    printf("  Fine-grain buffer: %s\n", (svm_caps & CL_DEVICE_SVM_FINE_GRAIN_BUFFER) ? "yes" : "no");
    printf("  Coarse-grain: %s\n", (svm_caps & CL_DEVICE_SVM_COARSE_GRAIN_BUFFER) ? "yes" : "no");

    cl_context ctx = clCreateContext(NULL, 1, &dev, NULL, NULL, &err);
    cl_command_queue q = clCreateCommandQueue(ctx, dev, 0, &err);

    // Allocate 1MB via clSVMAlloc
    size_t sz = 1024 * 1024;
    void *ptr = clSVMAlloc(ctx, CL_MEM_READ_WRITE, sz, 0);
    if (!ptr) { printf("FAIL: clSVMAlloc returned NULL\n"); return 1; }
    printf("clSVMAlloc OK: %p (%zu bytes)\n", ptr, sz);

    // Fill with pattern
    char pattern = 0x42;
    err = clEnqueueSVMMemFill(q, ptr, &pattern, 1, sz, 0, NULL, NULL);
    printf("clEnqueueSVMMemFill (1MB, pattern=1): %s (err=%d)\n",
           err == CL_SUCCESS ? "OK" : "FAIL", err);

    if (err == CL_SUCCESS) {
        err = clFinish(q);
        printf("clFinish: %s\n", err == CL_SUCCESS ? "OK" : "FAIL");

        // Verify
        err = clEnqueueSVMMap(q, CL_TRUE, CL_MAP_READ, ptr, sz, 0, NULL, NULL);
        if (err == CL_SUCCESS) {
            char *bytes = (char *)ptr;
            int ok = 1;
            for (size_t i = 0; i < sz; i++) if (bytes[i] != 0x42) { ok = 0; break; }
            printf("Verify: %s\n", ok ? "PASS" : "FAIL");
            clEnqueueSVMUnmap(q, ptr, 0, NULL, NULL);
        }
    }

    // Test larger allocation similar to bn-hip (27MB)
    size_t big = 45 * 149986 * 4;
    void *big_ptr = clSVMAlloc(ctx, CL_MEM_READ_WRITE, big, 0);
    printf("clSVMAlloc large (%zu bytes = %.1f MB): %s\n",
           big, (double)big / (1024*1024), big_ptr ? "OK" : "FAIL");
    if (big_ptr) {
        char zero = 0;
        err = clEnqueueSVMMemFill(q, big_ptr, &zero, 1, big, 0, NULL, NULL);
        printf("clEnqueueSVMMemFill (%.1f MB): %s (err=%d)\n",
               (double)big / (1024*1024),
               err == CL_SUCCESS ? "OK" : "FAIL", err);
        clSVMFree(ctx, big_ptr);
    }

    clSVMFree(ctx, ptr);
    clReleaseCommandQueue(q);
    clReleaseContext(ctx);
    return 0;
}
