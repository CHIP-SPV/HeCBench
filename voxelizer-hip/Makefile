#===============================================================================
# User Options
#===============================================================================

# Compiler can be set below, or via environment variable
CC        = hipcc
OPTIMIZE  = yes
DEBUG     = no
GPU       = yes
LAUNCHER  =

#===============================================================================
# Program name & source code list
#===============================================================================
# path to where GLM is installed
GLM_PATH=$(HOME)/glm

# path to where Trimesh is installed; cloned + built on first use (pinned
# commit; the library target only — gluit needs GL headers and is unused).
Trimesh_PATH=../voxelizer-cuda/trimesh2
TRIMESH_COMMIT=76bc89310b45279ff3c40415a6f6d5789479b42f

$(Trimesh_PATH)/lib.Linux64/libtrimesh.a:
	test -d $(Trimesh_PATH) || git clone https://github.com/Forceflow/trimesh2 $(Trimesh_PATH)
	cd $(Trimesh_PATH) && git checkout -q $(TRIMESH_COMMIT)
	$(MAKE) -C $(Trimesh_PATH)/libsrc linux64

program = main

source = main.cu voxelize.cu voxelize_solid.cu util_io.cpp cpu_voxelizer.cpp

obj = main.o voxelize.o voxelize_solid.o util_io.o cpu_voxelizer.o

#===============================================================================
# Sets Flags
#===============================================================================

# Standard Flags
# glm_hip.h is force-included so GLM (system 0.9.9.8) gets
# __device__ __host__ qualifiers under HIP; see comments in that file.
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 \
          -include ./glm_hip.h \
          -I$(Trimesh_PATH)/include \
          -I$(GLM_PATH)/include

# Linker Flags
# libgluit.a is not linked: the voxelizer uses no GUI code and gluit
# requires GLU development headers that may not be installed.
# libgomp: libtrimesh.a is built with gcc -fopenmp.  Linked by absolute
# path because with -lgomp / -l:libgomp.so.1 the linker resolves the
# LLVM toolchain's libgomp.so.1 -> libomp.so alias (SONAME libomp.so),
# which is not on the default runtime library path.
GOMP = /usr/lib/x86_64-linux-gnu/libgomp.so.1
LDFLAGS = $(Trimesh_PATH)/lib.Linux64/libtrimesh.a $(GOMP)

# Debug Flags
ifeq ($(DEBUG),yes)
  CFLAGS += -g -DDEBUG
  LDFLAGS += -g
endif

# Optimization Flags
ifeq ($(OPTIMIZE),yes)
  CFLAGS += -O3
endif

# The example supports CPU-only mode
ifeq ($(GPU),yes)
  CFLAGS +=-DUSE_GPU
endif
#===============================================================================
# Targets to Build
#===============================================================================

# objects need the trimesh2 headers (clone) and the link needs the lib
$(obj): | $(Trimesh_PATH)/lib.Linux64/libtrimesh.a

$(program): $(obj) Makefile $(Trimesh_PATH)/lib.Linux64/libtrimesh.a
	$(CC) $(CFLAGS) $(obj) -o $@ $(LDFLAGS)

%.o: %.cu Makefile
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.cpp Makefile
	$(CC) -x hip $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj) *binvox*

run: $(program)
	$(LAUNCHER) ./$(program) -s 256 -f sphere.obj

smoke: $(program)
	$(LAUNCHER) ./$(program) -s 64 -f sphere.obj
