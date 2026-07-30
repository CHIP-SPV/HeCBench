__device__
double norm2(int i, int j, const double *c1, const double *c2)
{
  double dist, diff; /* Temp variables for simpler computations */
  int k; /* Index for iterating over dimensions */

  /* Initialise distance */
  dist = 0.0;

  for (k = 0; k < n_d; k++)
  {
    /*
     * Compute the distance between the k-th component of the i-th point
     * of the 1st curve and the k-th component of the j-th point of the
     * 2nd curve.
     *
     * Notice the 1-offset added for better readability (as in [1]).
     */
    diff = *(c1 + (i - 1)*n_d + k) - *(c2 + (j - 1)*n_d + k);
    /* Increment the accumulator variable with the squared distance */
    dist += diff*diff;
  }

  /* Compute the square root for the 2-norm */
  dist = sqrt(dist);

  return dist;
}

/*
 * Iterative bottom-up evaluation of the discrete Frechet distance DP
 * (algorithm from [1]).  The thread fills the prefix rectangle
 * [1..i] x [1..j] of `ca` in row-major order:
 *
 *   ca[p][q] = max(norm(p, q), min(ca[p-1][q], ca[p-1][q-1], ca[p][q-1]))
 *
 * Every thread computes identical values from identical inputs, so
 * concurrent stores to the same cell always carry the same value, and a
 * thread only ever reads cells it has already written itself.
 *
 * This replaces the original memoized recursion: device-side recursion
 * is not legal in OpenCL/SPIR-V and crashes Intel IGC.
 */
__device__
double iterative_norm2(int i, int j, int n_2, double *ca,
                       const double *c1, const double *c2)
{
  for (int p = 1; p <= i; p++)
  {
    for (int q = 1; q <= j; q++)
    {
      /* Distance between the p-th point of the 1st curve and the
       * q-th point of the 2nd curve (1-offset as in [1]) */
      double d = norm2(p, q, c1, c2);
      double v;

      if ((p == 1) && (q == 1))
      {
        v = d;
      }
      else if (q == 1)
      {
        v = fmax(ca[(p - 2)*n_2], d);
      }
      else if (p == 1)
      {
        v = fmax(ca[q - 2], d);
      }
      else
      {
        v = fmax(fmin(fmin(ca[(p - 2)*n_2 + (q - 1)],
                           ca[(p - 2)*n_2 + (q - 2)]),
                           ca[(p - 1)*n_2 + (q - 2)]), d);
      }

      ca[(p - 1)*n_2 + (q - 1)] = v;
    }
  }

  return ca[(i - 1)*n_2 + (j - 1)];
}

__global__ void distance_norm2 (
  int n_1, int n_2,
  double *__restrict__ ca,
  const double *__restrict__ c1,
  const double *__restrict__ c2)
{
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  int j = blockDim.y * blockIdx.y + threadIdx.y;
  if (j >= 1 && j <= n_2 && i >= 1 && i <= n_1)
    iterative_norm2(i, j, n_2, ca, c1, c2);
}
