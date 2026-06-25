#include <time.h>
#define CL_TARGET_OPENCL_VERSION 300
#include <CL/cl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef CL_KERNEL_SPILL_MEM_SIZE_INTEL
#define CL_KERNEL_SPILL_MEM_SIZE_INTEL 0x4109
#endif

static const char* err2str(cl_int e){
  switch(e){
    case CL_SUCCESS: return "CL_SUCCESS";
    case CL_OUT_OF_RESOURCES: return "CL_OUT_OF_RESOURCES";
    case CL_OUT_OF_HOST_MEMORY: return "CL_OUT_OF_HOST_MEMORY";
    case CL_MEM_OBJECT_ALLOCATION_FAILURE: return "CL_MEM_OBJECT_ALLOCATION_FAILURE";
    case CL_INVALID_KERNEL_ARGS: return "CL_INVALID_KERNEL_ARGS";
    default: { static char b[32]; sprintf(b,"cl_err %d",e); return b; }
  }
}

int main(int argc, char**argv){
  setvbuf(stdout,0,_IONBF,0);
  size_t gsize = argc>1 ? strtoul(argv[1],0,10) : (1u<<20);  // global work items
  int rounds   = argc>2 ? atoi(argv[2]) : 64;

  // Read SPIR-V
  FILE*f=fopen("scratchhog.spv","rb"); fseek(f,0,SEEK_END); long sz=ftell(f); fseek(f,0,SEEK_SET);
  unsigned char*il=malloc(sz); fread(il,1,sz,f); fclose(f);

  // Pick the Intel NEO (compute-runtime) GPU platform: name "Intel(R) OpenCL Graphics"
  cl_uint np; clGetPlatformIDs(0,0,&np);
  cl_platform_id*plats=malloc(np*sizeof(*plats)); clGetPlatformIDs(np,plats,0);
  cl_platform_id plat=0; cl_device_id dev=0;
  for(cl_uint i=0;i<np;i++){
    char nm[128]; clGetPlatformInfo(plats[i],CL_PLATFORM_NAME,sizeof nm,nm,0);
    cl_device_id d; cl_uint nd=0;
    if(clGetDeviceIDs(plats[i],CL_DEVICE_TYPE_GPU,1,&d,&nd)==CL_SUCCESS && nd){
      char dn[128]; clGetDeviceInfo(d,CL_DEVICE_NAME,sizeof dn,dn,0);
      if(strstr(nm,"Graphics") && strstr(dn,"Arc")){ plat=plats[i]; dev=d; 
        printf("OpenCL platform: %s\n  device: %s\n", nm, dn); break; }
    }
  }
  if(!dev){ printf("no Intel Arc OpenCL GPU found\n"); return 2; }

  cl_int e;
  cl_context ctx=clCreateContext(0,1,&dev,0,0,&e);
  cl_command_queue q=clCreateCommandQueueWithProperties(ctx,dev,0,&e);
  cl_program prog=clCreateProgramWithIL(ctx,il,sz,&e);
  printf("clCreateProgramWithIL: %s\n", err2str(e));
  e=clBuildProgram(prog,1,&dev,"",0,0);
  printf("clBuildProgram: %s\n", err2str(e));
  if(e!=CL_SUCCESS){ size_t l; clGetProgramBuildInfo(prog,dev,CL_PROGRAM_BUILD_LOG,0,0,&l);
    char*log=malloc(l); clGetProgramBuildInfo(prog,dev,CL_PROGRAM_BUILD_LOG,l,log,0);
    printf("build log:\n%s\n",log); return 1; }
  cl_kernel k=clCreateKernel(prog,"scratchhog",&e);

  // Report per-work-item scratch/private memory that IGC allocated
  cl_ulong spill=0, priv=0;
  clGetKernelWorkGroupInfo(k,dev,CL_KERNEL_SPILL_MEM_SIZE_INTEL,sizeof spill,&spill,0);
  clGetKernelWorkGroupInfo(k,dev,CL_KERNEL_PRIVATE_MEM_SIZE,sizeof priv,&priv,0);
  printf("CL_KERNEL_SPILL_MEM_SIZE_INTEL = %lu B/work-item\n",(unsigned long)spill);
  printf("CL_KERNEL_PRIVATE_MEM_SIZE     = %lu B/work-item\n",(unsigned long)priv);

  cl_mem out=clCreateBuffer(ctx,CL_MEM_WRITE_ONLY,gsize*sizeof(int),0,&e);
  clSetKernelArg(k,0,sizeof(cl_mem),&out);
  clSetKernelArg(k,1,sizeof(int),&rounds);
  size_t local=256;
  printf("enqueue: global=%zu local=%zu rounds=%d\n",gsize,local,rounds);
  e=clEnqueueNDRangeKernel(q,k,1,0,&gsize,&local,0,0,0);
  printf("clEnqueueNDRangeKernel: %s\n", err2str(e));
  struct timespec _t0,_t1; clock_gettime(CLOCK_MONOTONIC,&_t0); cl_int ef=clFinish(q); clock_gettime(CLOCK_MONOTONIC,&_t1); double _s=(_t1.tv_sec-_t0.tv_sec)+(_t1.tv_nsec-_t0.tv_nsec)/1e9; printf("kernel wall=%.2fs\n",_s);
  printf("clFinish: %s\n", err2str(ef));

  int ok = (e==CL_SUCCESS && ef==CL_SUCCESS);
  printf("RESULT: %s\n", ok? "PASS (OpenCL ran the high-scratch kernel)" :
                              "FAIL (OpenCL rejected the high-scratch kernel)");
  return ok?0:1;
}
