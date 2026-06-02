#include <sycl/sycl.hpp>

double norm1(int i, int j, const double *c1, const double *c2)
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
    /* Increment the accumulator variable with the absolute distance */
    dist += fabs(diff);
  }

  return dist;
}

// Iterative DP fill (replaces recursive_norm1 to remove SYCL-illegal recursion).
// Single thread fills the entire ca[i][j] table in row-major order; the cell
// dependencies (i-1,j), (i,j-1), (i-1,j-1) are all behind in the iteration
// order so a serial sweep is correct.
void distance_norm1 (
  sycl::nd_item<2> &item,
  int n_1, int n_2,
  double *__restrict ca,
  const double *__restrict c1,
  const double *__restrict c2)
{
  if (item.get_global_id(0) != 0 || item.get_global_id(1) != 0) return;
  for (int i = 1; i <= n_1; i++) {
    for (int j = 1; j <= n_2; j++) {
      double *ca_ij = ca + (i - 1)*n_2 + (j - 1);
      if (i == 1 && j == 1) {
        *ca_ij = norm1(1, 1, c1, c2);
      } else if (i > 1 && j == 1) {
        *ca_ij = sycl::fmax(*(ca + (i-2)*n_2 + 0), norm1(i, 1, c1, c2));
      } else if (i == 1 && j > 1) {
        *ca_ij = sycl::fmax(*(ca + 0*n_2 + (j-2)), norm1(1, j, c1, c2));
      } else {
        double a = *(ca + (i-2)*n_2 + (j-1));   // (i-1, j)
        double b = *(ca + (i-2)*n_2 + (j-2));   // (i-1, j-1)
        double c = *(ca + (i-1)*n_2 + (j-2));   // (i,   j-1)
        *ca_ij = sycl::fmax(sycl::fmin(sycl::fmin(a, b), c), norm1(i, j, c1, c2));
      }
    }
  }
}

