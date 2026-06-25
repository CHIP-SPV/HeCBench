#define CL_TARGET_OPENCL_VERSION 300
#include <CL/cl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
static const char* es(cl_int e){switch(e){case CL_SUCCESS:return"CL_SUCCESS";
  case CL_OUT_OF_RESOURCES:return"CL_OUT_OF_RESOURCES";default:{static char b[40];sprintf(b,"cl_err %d",e);return b;}}}
int main(int argc,char**argv){
  setvbuf(stdout,0,_IONBF,0);
  const char*spv=argc>1?argv[1]:"chipstar_genscore_O0.spv";
  int iters=argc>2?atoi(argv[2]):50;
  const int NODE_N=45,sizepernode=149986,taskperthr=1,node=0,total=256,blocknum=2;
  size_t loc_n=(size_t)NODE_N*sizepernode;
  FILE*f=fopen(spv,"rb");fseek(f,0,SEEK_END);long sz=ftell(f);fseek(f,0,SEEK_SET);
  unsigned char*il=malloc(sz);fread(il,1,sz,f);fclose(f);
  cl_uint np;clGetPlatformIDs(0,0,&np);cl_platform_id*ps=malloc(np*sizeof(*ps));clGetPlatformIDs(np,ps,0);
  cl_device_id dev=0;cl_platform_id plat=0;
  for(cl_uint i=0;i<np;i++){char nm[128];clGetPlatformInfo(ps[i],CL_PLATFORM_NAME,sizeof nm,nm,0);
    cl_device_id d;cl_uint nd=0;if(clGetDeviceIDs(ps[i],CL_DEVICE_TYPE_GPU,1,&d,&nd)==CL_SUCCESS&&nd){
      char dn[128];clGetDeviceInfo(d,CL_DEVICE_NAME,sizeof dn,dn,0);
      if(strstr(nm,"Graphics")&&strstr(dn,"Arc")){plat=ps[i];dev=d;printf("%s / %s\n",nm,dn);break;}}}
  if(!dev)return 2;
  cl_int e;cl_context c=clCreateContext(0,1,&dev,0,0,&e);
  cl_command_queue q=clCreateCommandQueueWithProperties(c,dev,0,&e);
  cl_program p=clCreateProgramWithIL(c,il,sz,&e);
  e=clBuildProgram(p,1,&dev,"",0,0);printf("build: %s\n",es(e));
  if(e){size_t l;clGetProgramBuildInfo(p,dev,CL_PROGRAM_BUILD_LOG,0,0,&l);char*lg=malloc(l);clGetProgramBuildInfo(p,dev,CL_PROGRAM_BUILD_LOG,l,lg,0);printf("%s\n",lg);return 1;}
  cl_kernel k=clCreateKernel(p,"_Z13computeKerneliiPKfPKbiiPfPi",&e);printf("computeKernel create: %s\n",es(e));
  if(e)return 1;
  cl_mem dloc=clCreateBuffer(c,CL_MEM_READ_WRITE,loc_n*4,0,&e);
  cl_mem dpar=clCreateBuffer(c,CL_MEM_READ_ONLY,NODE_N,0,&e);          // bool[NODE_N]
  cl_mem dscore=clCreateBuffer(c,CL_MEM_READ_WRITE,blocknum*4,0,&e);
  cl_mem dresp=clCreateBuffer(c,CL_MEM_READ_WRITE,blocknum*4*4,0,&e);
  float*z=calloc(loc_n,4);clEnqueueWriteBuffer(q,dloc,CL_TRUE,0,loc_n*4,z,0,0,0);free(z);
  unsigned char par[64]={0}; for(int i=0;i<8;i++)par[i]=1;              // posN -> 9
  clEnqueueWriteBuffer(q,dpar,CL_TRUE,0,NODE_N,par,0,0,0);
  clSetKernelArg(k,0,sizeof(int),&taskperthr);
  clSetKernelArg(k,1,sizeof(int),&sizepernode);
  clSetKernelArg(k,2,sizeof(cl_mem),&dloc);
  clSetKernelArg(k,3,sizeof(cl_mem),&dpar);
  clSetKernelArg(k,4,sizeof(int),&node);
  clSetKernelArg(k,5,sizeof(int),&total);
  clSetKernelArg(k,6,sizeof(cl_mem),&dscore);
  clSetKernelArg(k,7,sizeof(cl_mem),&dresp);
  clSetKernelArg(k,8,256*sizeof(float),0);    // dynamic local mem (lsinblock)
  size_t local=256,global=(size_t)blocknum*256;
  printf("=== %d iters of computeKernel(blocknum=%d,total=%d,node=%d) ===\n",iters,blocknum,total,node);
  for(int it=0;it<iters;it++){
    cl_int ee=clEnqueueNDRangeKernel(q,k,1,0,&global,&local,0,0,0);
    cl_int ff=clFinish(q);
    if(ee||ff){printf("iter %d FAILED: enqueue=%s finish=%s\n",it,es(ee),es(ff));return 1;}
  }
  printf("RESULT: PASS (computeKernel survived %d iters in pure OpenCL)\n",iters);
  return 0;
}
