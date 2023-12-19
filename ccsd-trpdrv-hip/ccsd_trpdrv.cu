void ccsd_tengy_gpu(const float * __restrict__ f1n,    const float * __restrict__ f1t,
                    const float * __restrict__ f2n,    const float * __restrict__ f2t,
                    const float * __restrict__ f3n,    const float * __restrict__ f3t,
                    const float * __restrict__ f4n,    const float * __restrict__ f4t,
                    const float * __restrict__ dintc1, const float * __restrict__ dintx1, const float * __restrict__ t1v1,
                    const float * __restrict__ dintc2, const float * __restrict__ dintx2, const float * __restrict__ t1v2,
                    const float * __restrict__ eorb,   const float eaijk,
                    float * __restrict__ emp4i, float * __restrict__ emp5i,
                    float * __restrict__ emp4k, float * __restrict__ emp5k,
                    const int ncor, const int nocc, const int nvir);

void ccsd_trpdrv(float * __restrict__ f1n, float * __restrict__ f1t,
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
                 float * __restrict__ dintc2, float * __restrict__ dintx2, float * __restrict__ t1v2)
{
    float emp4 = *emp4_;
    float emp5 = *emp5_;

    float emp4i = 0.0;
    float emp5i = 0.0;
    float emp4k = 0.0;
    float emp5k = 0.0;

    const int ncor = *ncor_;
    const int nocc = *nocc_;
    const int nvir = *nvir_;

    /* convert from Fortran to C offset convention... */
    const int k   = *k_ - 1;
    //const int klo = *klo_ - 1;
    const int a   = *a_ - 1;
    const int i   = *i_ - 1;
    const int j   = *j_ - 1;

    const float eaijk = eorb[a] - (eorb[ncor+i] + eorb[ncor+j] + eorb[ncor+k]);

    ccsd_tengy_gpu(f1n, f1t, f2n, f2t, f3n, f3t, f4n, f4t,
                   dintc1, dintx1, t1v1, dintc2, dintx2, t1v2,
                   eorb, eaijk, &emp4i, &emp5i, &emp4k, &emp5k,
                   ncor, nocc, nvir);

    emp4 += emp4i;
    emp5 += emp5i;

    if (*i_ != *k_) {
        emp4 += emp4k;
        emp5 += emp5k;
    }

    *emp4_ = emp4;
    *emp5_ = emp5;

    return;
}
