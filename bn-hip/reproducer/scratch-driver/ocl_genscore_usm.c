#define CL_TARGET_OPENCL_VERSION 300
#include <CL/cl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#ifndef CL_KERNEL_SPILL_MEM_SIZE_INTEL
#define CL_KERNEL_SPILL_MEM_SIZE_INTEL 0x4109
#endif
#define CL_KERNEL_EXEC_INFO_INDIRECT_DEVICE_ACCESS_INTEL 0x4242
#define CL_KERNEL_EXEC_INFO_INDIRECT_HOST_ACCESS_INTEL   0x4243
#define CL_KERNEL_EXEC_INFO_INDIRECT_SHARED_ACCESS_INTEL 0x4244
typedef void*(*pfn_alloc)(cl_context,cl_device_id,const cl_ulong*,size_t,cl_uint,cl_int*);
typedef cl_int(*pfn_free)(cl_context,void*);
typedef cl_int(*pfn_setarg)(cl_kernel,cl_uint,const void*);
typedef cl_int(*pfn_memcpy)(cl_command_queue,cl_bool,void*,const void*,size_t,cl_uint,const cl_event*,cl_event*);
static const char* es(cl_int e){switch(e){case CL_SUCCESS:return"CL_SUCCESS";
  case CL_OUT_OF_RESOURCES:return"CL_OUT_OF_RESOURCES";case CL_OUT_OF_HOST_MEMORY:return"CL_OUT_OF_HOST_MEMORY";
  default:{static char b[40];sprintf(b,"cl_err %d",e);return b;}}}
int main(int argc,char**argv){
  setvbuf(stdout,0,_IONBF,0);
  const char*spv=argc>1?argv[1]:"processed_0.spv";
  const char*kn=argc>2?argv[2]:"_Z14genScoreKerneliPfPKiPKf";
  const int NODE_N=45,DATA_N=600,sizepernode=149986;
  size_t loc_n=(size_t)NODE_N*sizepernode,data_n=(size_t)NODE_N*DATA_N,lg_n=DATA_N+2;
  FILE*f=fopen(spv,"rb");if(!f){printf("no spv\n");return 2;}
  fseek(f,0,SEEK_END);long sz=ftell(f);fseek(f,0,SEEK_SET);unsigned char*il=malloc(sz);fread(il,1,sz,f);fclose(f);
  cl_uint np;clGetPlatformIDs(0,0,&np);cl_platform_id*ps=malloc(np*sizeof(*ps));clGetPlatformIDs(np,ps,0);
  cl_device_id dev=0;cl_platform_id plat=0;
  for(cl_uint i=0;i<np;i++){char nm[128];clGetPlatformInfo(ps[i],CL_PLATFORM_NAME,sizeof nm,nm,0);
    cl_device_id d;cl_uint nd=0;if(clGetDeviceIDs(ps[i],CL_DEVICE_TYPE_GPU,1,&d,&nd)==CL_SUCCESS&&nd){
      char dn[128];clGetDeviceInfo(d,CL_DEVICE_NAME,sizeof dn,dn,0);
      if(strstr(nm,"Graphics")&&strstr(dn,"Arc")){plat=ps[i];dev=d;printf("OpenCL(USM): %s / %s\n",nm,dn);break;}}}
  if(!dev)return 2;
  cl_int e;cl_context c=clCreateContext(0,1,&dev,0,0,&e);
  cl_command_queue q=clCreateCommandQueueWithProperties(c,dev,0,&e);
  pfn_alloc devAlloc=(pfn_alloc)clGetExtensionFunctionAddressForPlatform(plat,"clDeviceMemAllocINTEL");
  pfn_free  memFree =(pfn_free) clGetExtensionFunctionAddressForPlatform(plat,"clMemFreeINTEL");
  pfn_setarg setArg =(pfn_setarg)clGetExtensionFunctionAddressForPlatform(plat,"clSetKernelArgMemPointerINTEL");
  pfn_memcpy memcpyI=(pfn_memcpy)clGetExtensionFunctionAddressForPlatform(plat,"clEnqueueMemcpyINTEL");
  printf("USM fns: alloc=%p free=%p setarg=%p memcpy=%p\n",(void*)devAlloc,(void*)memFree,(void*)setArg,(void*)memcpyI);
  if(!devAlloc||!setArg){printf("no USM ext\n");return 2;}
  cl_program p=clCreateProgramWithIL(c,il,sz,&e);
  e=clBuildProgram(p,1,&dev,"",0,0);printf("build: %s\n",es(e));
  if(e){size_t l;clGetProgramBuildInfo(p,dev,CL_PROGRAM_BUILD_LOG,0,0,&l);char*lg=malloc(l);clGetProgramBuildInfo(p,dev,CL_PROGRAM_BUILD_LOG,l,lg,0);printf("%s\n",lg);return 1;}
  cl_kernel k=clCreateKernel(p,kn,&e);printf("kernel %s: %s\n",kn,es(e));
  cl_ulong priv=0;clGetKernelWorkGroupInfo(k,dev,CL_KERNEL_PRIVATE_MEM_SIZE,sizeof priv,&priv,0);
  printf("PRIVATE_MEM_SIZE=%lu B/WI\n",(unsigned long)priv);
  // USM device allocations (like chipStar IntelUSM)
  void*dloc=devAlloc(c,dev,0,loc_n*4,0,&e);
  void*ddata=devAlloc(c,dev,0,data_n*4,0,&e);
  void*dlg=devAlloc(c,dev,0,lg_n*4,0,&e);
  printf("USM allocs: %p %p %p\n",dloc,ddata,dlg);
  // init via memcpyINTEL
  float*z=calloc(loc_n,4);memcpyI(q,CL_TRUE,dloc,z,loc_n*4,0,0,0);free(z);
  int*dat=malloc(data_n*4);for(size_t i=0;i<data_n;i++)dat[i]=i&1;memcpyI(q,CL_TRUE,ddata,dat,data_n*4,0,0,0);free(dat);
  float*lg=malloc(lg_n*4);for(size_t i=0;i<lg_n;i++)lg[i]=0.001f*(i+1);memcpyI(q,CL_TRUE,dlg,lg,lg_n*4,0,0,0);free(lg);
  clSetKernelArg(k,0,sizeof(int),&sizepernode);
  setArg(k,1,dloc); setArg(k,2,ddata); setArg(k,3,dlg);
  // indirect access flags (chipStar sets these for USM)
  cl_bool t=CL_TRUE;
  clSetKernelExecInfo(k,CL_KERNEL_EXEC_INFO_INDIRECT_DEVICE_ACCESS_INTEL,sizeof t,&t);
  clSetKernelExecInfo(k,CL_KERNEL_EXEC_INFO_INDIRECT_HOST_ACCESS_INTEL,sizeof t,&t);
  clSetKernelExecInfo(k,CL_KERNEL_EXEC_INFO_INDIRECT_SHARED_ACCESS_INTEL,sizeof t,&t);
  size_t local=256,global=((sizepernode+255)/256)*256; int ITER=argc>3?atoi(argv[3]):20;
  printf("launch: global=%zu local=%zu\n",global,local);
  // get memFillINTEL for the per-iteration SVM/USM fill (like chipStar's hipMemset path)
  typedef cl_int(*pfn_fill)(cl_command_queue,void*,const void*,size_t,size_t,cl_uint,const cl_event*,cl_event*);
  pfn_fill memFill=(pfn_fill)clGetExtensionFunctionAddressForPlatform(plat,"clEnqueueMemFillINTEL");
  int pat=0;
  printf("=== looping %d iterations: memfill + genScoreKernel + finish (USM, chipStar SPIR-V) ===\n",ITER);
  for(int it=0;it<ITER;it++){
    cl_int fe=memFill?memFill(q,dloc,&pat,sizeof(pat),4096,0,0,0):0;       // small fill, like hipMemset
    cl_int ee=clEnqueueNDRangeKernel(q,k,1,0,&global,&local,0,0,0);
    cl_int ff=clFinish(q);
    if(fe||ee||ff){ printf("iter %d FAILED: fill=%s enqueue=%s finish=%s\n",it,es(fe),es(ee),es(ff)); return 1; }
    printf("iter %d: OK\n",it);
  }
  printf("RESULT: PASS (pure OpenCL survived %d iterations)\n",ITER);
  return 0;
}
