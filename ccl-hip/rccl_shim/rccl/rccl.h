#ifndef RCCL_SHIM_RCCL_H_
#define RCCL_SHIM_RCCL_H_

/*
 * Minimal single-process RCCL shim (no librccl/libnccl exists for chipStar).
 * Implements only the subset used by this benchmark, for communicators with
 * nranks == 1: a reduction over a single contribution is the identity, which
 * the shim realizes as a real device-to-device copy so the benchmark's result
 * check still exercises actual data movement.
 */

#include <hip/hip_runtime.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct ncclComm* ncclComm_t;

#define NCCL_UNIQUE_ID_BYTES 128
typedef struct { char internal[NCCL_UNIQUE_ID_BYTES]; } ncclUniqueId;

typedef enum {
  ncclSuccess            = 0,
  ncclUnhandledCudaError = 1,
  ncclSystemError        = 2,
  ncclInternalError      = 3,
  ncclInvalidArgument    = 4,
  ncclInvalidUsage       = 5,
  ncclRemoteError        = 6,
  ncclInProgress         = 7,
  ncclNumResults         = 8
} ncclResult_t;

typedef enum {
  ncclInt8    = 0, ncclChar = 0,
  ncclUint8   = 1,
  ncclInt32   = 2, ncclInt  = 2,
  ncclUint32  = 3,
  ncclInt64   = 4,
  ncclUint64  = 5,
  ncclFloat16 = 6, ncclHalf = 6,
  ncclFloat32 = 7, ncclFloat = 7,
  ncclFloat64 = 8, ncclDouble = 8,
  ncclNumTypes = 9
} ncclDataType_t;

typedef enum {
  ncclSum  = 0,
  ncclProd = 1,
  ncclMax  = 2,
  ncclMin  = 3,
  ncclAvg  = 4,
  ncclNumOps = 5
} ncclRedOp_t;

ncclResult_t ncclGetUniqueId(ncclUniqueId* uniqueId);
ncclResult_t ncclCommInitRank(ncclComm_t* comm, int nranks, ncclUniqueId commId,
                              int rank);
ncclResult_t ncclAllReduce(const void* sendbuff, void* recvbuff, size_t count,
                           ncclDataType_t datatype, ncclRedOp_t op,
                           ncclComm_t comm, hipStream_t stream);
ncclResult_t ncclCommFinalize(ncclComm_t comm);
ncclResult_t ncclCommDestroy(ncclComm_t comm);
const char* ncclGetErrorString(ncclResult_t result);

#ifdef __cplusplus
}
#endif

#endif /* RCCL_SHIM_RCCL_H_ */
