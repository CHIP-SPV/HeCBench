include ../../common/make.config


ifdef OUTPUT
	override OUTPUT = -DOUTPUT
endif

default: dwt2d

dwt2d: common.h  components.cpp  components.h  dwt.cpp  dwt.h  main.cpp
	$(CXX) $(CXX_FLAGS) -o main components.cpp main.cpp $(OCL_CPPFLAGS) $(OCL_LDFLAGS)

clean:
	rm -rf *.o main
	rm *.bmp.dwt.*

