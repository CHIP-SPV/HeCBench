#define CL_TARGET_OPENCL_VERSION 300
#include <CL/cl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#ifndef CL_KERNEL_SPILL_MEM_SIZE_INTEL
#define CL_KERNEL_SPILL_MEM_SIZE_INTEL 0x4109
#endif
static const char* es(cl_int e){switch(e){case CL_SUCCESS:return"CL_SUCCESS";
  case CL_OUT_OF_RESOURCES:return"CL_OUT_OF_RESOURCES";case CL_OUT_OF_HOST_MEMORY:return"CL_OUT_OF_HOST_MEMORY";
  case CL_MEM_OBJECT_ALLOCATION_FAILURE:return"CL_MEM_OBJECT_ALLOCATION_FAILURE";
  default:{static char b[40];sprintf(b,"cl_err %d",e);return b;}}}
int main(int argc,char**argv){
  setvbuf(stdout,0,_IONBF,0);
  const char*spv=argc>1?argv[1]:"genscore_O0.spv";
  const int NODE_N=45,DATA_N=600;
  const int sizepernode=149986;
  size_t loc_n=(size_t)NODE_N*sizepernode;        // D_localscore floats
  size_t data_n=(size_t)NODE_N*DATA_N;            // D_data ints
  size_t lg_n=DATA_N+2;                           // D_LG floats
  FILE*f=fopen(spv,"rb");if(!f){printf("no spv %s\n",spv);return 2;}
  fseek(f,0,SEEK_END);long sz=ftell(f);fseek(f,0,SEEK_SET);
  unsigned char*il=malloc(sz);fread(il,1,sz,f);fclose(f);
  cl_uint np;clGetPlatformIDs(0,0,&np);cl_platform_id*ps=malloc(np*sizeof(*ps));clGetPlatformIDs(np,ps,0);
  cl_device_id dev=0;cl_platform_id plat=0;
  for(cl_uint i=0;i<np;i++){char nm[128];clGetPlatformInfo(ps[i],CL_PLATFORM_NAME,sizeof nm,nm,0);
    cl_device_id d;cl_uint nd=0;
    if(clGetDeviceIDs(ps[i],CL_DEVICE_TYPE_GPU,1,&d,&nd)==CL_SUCCESS&&nd){
      char dn[128];clGetDeviceInfo(d,CL_DEVICE_NAME,sizeof dn,dn,0);
      if(strstr(nm,"Graphics")&&strstr(dn,"Arc")){plat=ps[i];dev=d;printf("OpenCL: %s / %s\n",nm,dn);break;}}}
  if(!dev){printf("no Arc OCL GPU\n");return 2;}
  cl_int e;cl_context c=clCreateContext(0,1,&dev,0,0,&e);
  cl_command_queue q=clCreateCommandQueueWithProperties(c,dev,0,&e);
  cl_program p=clCreateProgramWithIL(c,il,sz,&e);printf("createProgramWithIL: %s\n",es(e));
  e=clBuildProgram(p,1,&dev,"",0,0);printf("buildProgram: %s\n",es(e));
  if(e){size_t l;clGetProgramBuildInfo(p,dev,CL_PROGRAM_BUILD_LOG,0,0,&l);char*lg=malloc(l);
    clGetProgramBuildInfo(p,dev,CL_PROGRAM_BUILD_LOG,l,lg,0);printf("%s\n",lg);return 1;}
  const char*kn=argc>2?argv[2]:"genScoreKernel";cl_kernel k=clCreateKernel(p,kn,&e);printf("kernel=%s create=%s\n",kn,es(e));
  cl_ulong spill=0,priv=0;
  clGetKernelWorkGroupInfo(k,dev,CL_KERNEL_SPILL_MEM_SIZE_INTEL,sizeof spill,&spill,0);
  clGetKernelWorkGroupInfo(k,dev,CL_KERNEL_PRIVATE_MEM_SIZE,sizeof priv,&priv,0);
  printf("SPILL_MEM_SIZE_INTEL=%lu B/WI   PRIVATE_MEM_SIZE=%lu B/WI\n",(unsigned long)spill,(unsigned long)priv);
  cl_mem dloc=clCreateBuffer(c,CL_MEM_READ_WRITE,loc_n*4,0,&e);
  cl_mem ddata=clCreateBuffer(c,CL_MEM_READ_ONLY,data_n*4,0,&e);
  cl_mem dlg=clCreateBuffer(c,CL_MEM_READ_ONLY,lg_n*4,0,&e);
  // init: localscore=0; data in {0,1}; lg arbitrary
  float*z=calloc(loc_n,4);clEnqueueWriteBuffer(q,dloc,CL_TRUE,0,loc_n*4,z,0,0,0);free(z);
  int*dat=malloc(data_n*4);for(size_t i=0;i<data_n;i++)dat[i]=i&1;clEnqueueWriteBuffer(q,ddata,CL_TRUE,0,data_n*4,dat,0,0,0);free(dat);
  float*lg=malloc(lg_n*4);for(size_t i=0;i<lg_n;i++)lg[i]=0.001f*(i+1);clEnqueueWriteBuffer(q,dlg,CL_TRUE,0,lg_n*4,lg,0,0,0);free(lg);
  clSetKernelArg(k,0,sizeof(int),&sizepernode);
  clSetKernelArg(k,1,sizeof(cl_mem),&dloc);
  clSetKernelArg(k,2,sizeof(cl_mem),&ddata);
  clSetKernelArg(k,3,sizeof(cl_mem),&dlg);
  size_t local=256, global=((sizepernode+255)/256)*256;
  printf("launch genScoreKernel: global=%zu local=%zu (sizepernode=%d)\n",global,local,sizepernode);
  struct timespec t0,t1;clock_gettime(CLOCK_MONOTONIC,&t0);
  e=clEnqueueNDRangeKernel(q,k,1,0,&global,&local,0,0,0);
  printf("enqueue: %s\n",es(e));
  cl_int ef=clFinish(q);clock_gettime(CLOCK_MONOTONIC,&t1);
  double s=(t1.tv_sec-t0.tv_sec)+(t1.tv_nsec-t0.tv_nsec)/1e9;
  printf("clFinish: %s   wall=%.2fs\n",es(ef),s);
  int ok=(e==CL_SUCCESS&&ef==CL_SUCCESS);
  printf("RESULT: %s\n",ok?"PASS":"FAIL");
  return ok?0:1;
}
