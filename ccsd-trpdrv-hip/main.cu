#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/* Do not allow the test to allocate more than MAX_MEM gigabytes. */
#ifndef MAX_MEM
#define MAX_MEM 4
#endif

#define MIN(x,y) (x<y ? x : y)
#define MAX(x,y) (x>y ? x : y)

void ccsd_trpdrv(
    float * __restrict__ f1n, float * __restrict__ f1t,
    float * __restrict__ f2n, float * __restrict__ f2t,
    float * __restrict__ f3n, float * __restrict__ f3t,
    float * __restrict__ f4n, float * __restrict__ f4t,
    float * __restrict__ eorb,
    int    * __restrict__ ncor_, int * __restrict__ nocc_, int * __restrict__ nvir_,
    float * __restrict__ emp4_, float * __restrict__ emp5_,
    int    * __restrict__ a_, int * __restrict__ i_, int * __restrict__ j_, int * __restrict__ k_, int * __restrict__ klo_,
    float * __restrict__ tij, float * __restrict__ tkj, float * __restrict__ tia, float * __restrict__ tka,
    float * __restrict__ xia, float * __restrict__ xka, float * __restrict__ jia, float * __restrict__ jka,
    float * __restrict__ kia, float * __restrict__ kka, float * __restrict__ jij, float * __restrict__ jkj,
    float * __restrict__ kij, float * __restrict__ kkj,
    float * __restrict__ dintc1, float * __restrict__ dintx1, float * __restrict__ t1v1,
    float * __restrict__ dintc2, float * __restrict__ dintx2, float * __restrict__ t1v2);

float * make_array(int n)
{
  float * a = (float*) malloc(n*sizeof(float));
  for (int i=0; i<n; i++) {
    a[i] = drand48();
  }
  return a;
}

int main(int argc, char* argv[])
{
  int ncor, nocc, nvir;
  int maxiter = 100;
  int nkpass = 1;

  if (argc<3) {
    printf("Usage: ./test_cbody nocc nvir [maxiter] [nkpass]\n");
    return argc;
  } else {
    ncor = 0;
    nocc = atoi(argv[1]);
    nvir = atoi(argv[2]);
    if (argc>3) {
      maxiter = atoi(argv[3]);
      /* if negative, treat as "infinite" */
      if (maxiter<0) maxiter = 1<<30;
    }
    if (argc>4) {
      nkpass = atoi(argv[4]);
    }
  }

  if (nocc<1 || nvir<1) {
    printf("Arguments must be non-negative!\n");
    return 1;
  }

  printf("Test driver for cbody with nocc=%d, nvir=%d, maxiter=%d, nkpass=%d\n", nocc, nvir, maxiter, nkpass);

  const int nbf = ncor + nocc + nvir;
  const int lnvv = nvir * nvir;
  const int lnov = nocc * nvir;
  const int kchunk = (nocc - 1)/nkpass + 1;

  const float memory = (nbf+8.0*lnvv+
      lnvv+kchunk*lnvv+lnov*nocc+kchunk*lnov+lnov*nocc+kchunk*lnov+lnvv+
      kchunk*lnvv+lnvv+kchunk*lnvv+lnov*nocc+kchunk*lnov+lnov*nocc+
      kchunk*lnov+lnov+nvir*kchunk+nvir*nocc+
      6.0*lnvv)*sizeof(float);
  printf("This test requires %f GB of memory.\n", 1.0e-9*memory);

  if (1.0e-9*memory > MAX_MEM) {
    printf("You need to increase MAX_MEM (%d)\n", MAX_MEM);
    printf("or set nkpass (%d) to a larger number.\n", nkpass);
    return MAX_MEM;
  }

  srand48(2);
  float * eorb = make_array(nbf);
  float * f1n = make_array(lnvv);
  float * f2n = make_array(lnvv);
  float * f3n = make_array(lnvv);
  float * f4n = make_array(lnvv);
  float * f1t = make_array(lnvv);
  float * f2t = make_array(lnvv);
  float * f3t = make_array(lnvv);
  float * f4t = make_array(lnvv);
  float * Tij = make_array(lnvv);
  float * Tkj = make_array(kchunk*lnvv);
  float * Tia = make_array(lnov*nocc);
  float * Tka = make_array(kchunk*lnov);
  float * Xia = make_array(lnov*nocc);
  float * Xka = make_array(kchunk*lnov);
  float * Jia = make_array(lnvv);
  float * Jka = make_array(kchunk*lnvv);
  float * Kia = make_array(lnvv);
  float * Kka = make_array(kchunk*lnvv);
  float * Jij = make_array(lnov*nocc);
  float * Jkj = make_array(kchunk*lnov);
  float * Kij = make_array(lnov*nocc);
  float * Kkj = make_array(kchunk*lnov);
  float * Dja = make_array(lnov);
  float * Djka = make_array(nvir*kchunk);
  float * Djia = make_array(nvir*nocc);
  float * dintc1 = make_array(lnvv);
  float * dintc2 = make_array(lnvv);
  float * dintx1 = make_array(lnvv);
  float * dintx2 = make_array(lnvv);
  float * t1v1 = make_array(lnvv);
  float * t1v2 = make_array(lnvv);

  int ntimers = MIN(maxiter,nocc*nocc*nocc*nocc);
  float * timers = (float*) calloc(ntimers,sizeof(float));

  float emp4=0.0, emp5=0.0;

  int iter = 0;

  for (int klo=1; klo<=nocc; klo+=kchunk) {
    const int khi = MIN(nocc, klo+kchunk-1);
    int a=1;
    for (int j=1; j<=nocc; j++) {
      for (int i=1; i<=nocc; i++) {
        for (int k=klo; k<=MIN(khi,i); k++) {
          clock_t t0 = clock();
          ccsd_trpdrv(f1n, f1t, f2n, f2t, f3n, f3t, f4n, f4t, eorb,
              &ncor, &nocc, &nvir, &emp4, &emp5, &a, &i, &j, &k, &klo,
              Tij, Tkj, Tia, Tka, Xia, Xka, Jia, Jka, Kia, Kka, Jij, Jkj, Kij, Kkj,
              dintc1, dintx1, t1v1, dintc2, dintx2, t1v2);
          timers[iter] = (float)(clock()-t0) / CLOCKS_PER_SEC;

          iter++;
          if (iter==maxiter) {
            printf("Stopping after %d iterations...\n", iter);
            goto maxed_out;
          }

          /* prevent NAN for large maxiter... */
          if (emp4 >  1000.0) emp4 -= 1000.0;
          if (emp4 < -1000.0) emp4 += 1000.0;
          if (emp5 >  1000.0) emp5 -= 1000.0;
          if (emp5 < -1000.0) emp5 += 1000.0;
        }
      }
    }
  }

maxed_out:
  float tsum =  0.0;
  float tmax = -1.0e10;
  float tmin =  1.0e10;
  for (int i=0; i<iter; i++) {
    tsum += timers[i];
    tmax  = MAX(tmax,timers[i]);
    tmin  = MIN(tmin,timers[i]);
  }
  float tavg = tsum / iter;
  printf("TIMING: min=%lf, max=%lf, avg=%lf\n", tmin, tmax, tavg);

  float dgemm_flops = ((8.0*nvir)*nvir)*(nvir+nocc);
  float dgemm_mops  = 8.0*(4.0*nvir*nvir + 2.0*nvir*nocc);

  /* The inner loop of tengy touches 86 f[1234][nt] elements and 8 other arrays...
   * We will just assume flops=mops even though flops>mops */
  float tengy_ops = ((1.0*nvir)*nvir)*(86+8);

  printf("OPS: dgemm_flops=%10.3e dgemm_mops=%10.3e tengy_ops=%10.3e\n",
         dgemm_flops, dgemm_mops, tengy_ops);

  printf("PERF: GF/s=%10.3e GB/s=%10.3e\n",
         1.0e-9*(dgemm_flops+tengy_ops)/tavg, 8.0e-9*(dgemm_mops+tengy_ops)/tavg);

  printf("These are meaningless but should not vary for a particular input:\n");
  printf("emp4=%f emp5=%f\n", emp4, emp5);
  printf("Finished\n");

  free(eorb);
  free(f1n );
  free(f2n );
  free(f3n );
  free(f4n );
  free(f1t );
  free(f2t );
  free(f3t );
  free(f4t );
  free(Tij );
  free(Tkj );
  free(Tia );
  free(Tka );
  free(Xia );
  free(Xka );
  free(Jia );
  free(Jka );
  free(Kia );
  free(Kka );
  free(Jij );
  free(Jkj );
  free(Kij );
  free(Kkj );
  free(Dja );
  free(Djka);
  free(Djia);
  free(dintc1);
  free(dintc2);
  free(dintx1);
  free(dintx2);
  free(t1v1  );
  free(t1v2  );

  return 0;
}
