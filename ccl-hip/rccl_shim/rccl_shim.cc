/*
 * Single-process RCCL shim implementation. See rccl/rccl.h for scope.
 */

#include <rccl/rccl.h>

#include <stdio.h>
#include <string.h>

struct ncclComm {
  int rank;
  int nranks;
  int device;
};

static size_t dtypeSize(ncclDataType_t t) {
  switch (t) {
    case ncclInt8:
    case ncclUint8:   return 1;
    case ncclFloat16: return 2;
    case ncclInt32:
    case ncclUint32:
    case ncclFloat32: return 4;
    case ncclInt64:
    case ncclUint64:
    case ncclFloat64: return 8;
    default:          return 0;
  }
}

extern "C" {

ncclResult_t ncclGetUniqueId(ncclUniqueId* uniqueId) {
  if (!uniqueId) return ncclInvalidArgument;
  memset(uniqueId->internal, 0, NCCL_UNIQUE_ID_BYTES);
  return ncclSuccess;
}

ncclResult_t ncclCommInitRank(ncclComm_t* comm, int nranks, ncclUniqueId,
                              int rank) {
  if (!comm || nranks < 1 || rank < 0 || rank >= nranks)
    return ncclInvalidArgument;
  if (nranks != 1) {
    fprintf(stderr,
            "rccl_shim: only single-rank communicators are supported "
            "(requested nranks=%d); launch with a single rank\n",
            nranks);
    return ncclInvalidUsage;
  }
  ncclComm* c = new ncclComm;
  c->rank = rank;
  c->nranks = nranks;
  if (hipGetDevice(&c->device) != hipSuccess) {
    delete c;
    return ncclUnhandledCudaError;
  }
  *comm = c;
  return ncclSuccess;
}

ncclResult_t ncclAllReduce(const void* sendbuff, void* recvbuff, size_t count,
                           ncclDataType_t datatype, ncclRedOp_t op,
                           ncclComm_t comm, hipStream_t stream) {
  if (!comm) return ncclInvalidArgument;
  if (count == 0) return ncclSuccess;
  if (!sendbuff || !recvbuff) return ncclInvalidArgument;
  size_t es = dtypeSize(datatype);
  if (es == 0 || op < ncclSum || op >= ncclNumOps) return ncclInvalidArgument;
  /* nranks == 1: any reduction over one contribution is the identity. */
  if (sendbuff == recvbuff) return ncclSuccess; /* in-place */
  if (hipMemcpyAsync(recvbuff, sendbuff, count * es, hipMemcpyDeviceToDevice,
                     stream) != hipSuccess)
    return ncclUnhandledCudaError;
  return ncclSuccess;
}

ncclResult_t ncclCommFinalize(ncclComm_t comm) {
  if (!comm) return ncclInvalidArgument;
  /* Flush any outstanding shim operations on the comm's device. */
  if (hipDeviceSynchronize() != hipSuccess) return ncclUnhandledCudaError;
  return ncclSuccess;
}

ncclResult_t ncclCommDestroy(ncclComm_t comm) {
  if (!comm) return ncclInvalidArgument;
  delete comm;
  return ncclSuccess;
}

const char* ncclGetErrorString(ncclResult_t result) {
  switch (result) {
    case ncclSuccess:            return "no error";
    case ncclUnhandledCudaError: return "unhandled hip error";
    case ncclSystemError:        return "unhandled system error";
    case ncclInternalError:      return "internal error";
    case ncclInvalidArgument:    return "invalid argument";
    case ncclInvalidUsage:       return "invalid usage";
    case ncclRemoteError:        return "remote process error";
    case ncclInProgress:         return "operation in progress";
    default:                     return "unknown result code";
  }
}

} /* extern "C" */
