#define NODE_N 45
#define STATE_N 2
#define DATA_N 600

int D_C(int n, int a){
  int i,res=1,atmp=a;
  for(i=0;i<atmp;i++){ res*=n; n--; }
  for(i=0;i<atmp;i++){ res/=a; a--; }
  return res;
}
void D_findComb(int* comb, int l, int n){
  const int len = 4;
  if (l == 0){ for (int i=0;i<len;i++) comb[i]=-1; return; }
  int sum=0,k=1;
  while (sum<l) sum += D_C(n,k++);
  l -= sum - D_C(n,--k);
  int low=0,pos=0;
  while (k>1){
    sum=0; int s=1;
    while (sum<l) sum += D_C(n-s++,k-1);
    l -= sum - D_C(n-(--s),--k);
    low += s; comb[pos++]=low; n-=s;
  }
  comb[pos]=low+l;
  for (int i=pos+1;i<4;i++) comb[i]=-1;
}
void Dincr(int *bit,int n){
  while(n<=NODE_N){ bit[n]++; if(bit[n]>=2){bit[n]=0;n++;} else break; }
}
void DincrS(int *bit,int n){
  bit[n]++; if(bit[n]>=STATE_N){ bit[n]=0; Dincr(bit,n+1); }
}
bool D_getState(int parN,int *sta,int time){
  int i,j=1; for(i=0;i<parN;i++) j*=STATE_N; j--;
  if(time>j) return false;
  if(time>=1) DincrS(sta,0);
  return true;
}
__attribute__((intel_reqd_sub_group_size(16)))
__kernel void genScoreKernel(const int sizepernode,
                             __global float *D_localscore,
                             __global const int *D_data,
                             __global const float *D_LG){
  int id=get_group_id(0)*256+get_local_id(0);
  int node,index; bool flag;
  int parent[5]={0}; int pre[NODE_N]={0}; int state[5]={0};
  int i,j,parN=0,tmp,t; int t1=0,t2=0; float ls=0; int Nij[STATE_N]={0};
  if(id<sizepernode){
    D_findComb(parent,id,NODE_N-1);
    for(i=0;i<4;i++) if(parent[i]>0) parN++;
    for(node=0;node<NODE_N;node++){
      j=1; for(i=0;i<NODE_N;i++) if(i!=node) pre[j++]=i;
      for(tmp=0;tmp<parN;tmp++) state[tmp]=0;
      index=sizepernode*node+id;
      t=0;
      while(D_getState(parN,state,t++)){
        ls=0; for(tmp=0;tmp<STATE_N;tmp++) Nij[tmp]=0;
        for(t1=0;t1<DATA_N;t1++){
          flag=true;
          for(t2=0;t2<parN;t2++){
            if(D_data[t1*NODE_N+pre[parent[t2]]]!=state[t2]){ flag=false; break; }
          }
          if(!flag) continue;
          Nij[D_data[t1*NODE_N+node]]++;
        }
        tmp=STATE_N-1;
        for(t1=0;t1<STATE_N;t1++){ ls+=D_LG[Nij[t1]]; tmp+=Nij[t1]; }
        ls-=D_LG[tmp]; ls+=D_LG[STATE_N-1];
        D_localscore[index]+=ls;
      }
    }
  }
}
