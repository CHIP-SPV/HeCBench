include ../../common/make.config

EXE = main

$(EXE): nw.cpp
	$(CXX) ${KERNEL_DIM} $(CXX_FLAGS) $(OCL_CPPFLAGS) -o $(EXE) nw.cpp $(OCL_LDFLAGS)

clean:
	rm -f $(EXE)
