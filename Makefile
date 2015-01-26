CSRC = main.c
COBJ=$(CSRC:.c=.o)
CPPSRC = libtricubic/libtricubic.cpp libtricubic/tricubic_utils.cpp globals.cpp trianglemesh.cpp geometry.cpp mc.cpp bruteforce.cpp \
		field_2d.cpp field_3d.cpp fields.cpp conductor.cpp particle.cpp neutron.cpp electron.cpp proton.cpp ndist.cpp source.cpp \
		alglib-3.9.0/cpp/src/alglibinternal.cpp alglib-3.9.0/cpp/src/dataanalysis.cpp alglib-3.9.0/cpp/src/integration.cpp alglib-3.9.0/cpp/src/optimization.cpp alglib-3.9.0/cpp/src/statistics.cpp alglib-3.9.0/cpp/src/alglibmisc.cpp alglib-3.9.0/cpp/src/diffequations.cpp alglib-3.9.0/cpp/src/interpolation.cpp alglib-3.9.0/cpp/src/solvers.cpp alglib-3.9.0/cpp/src/ap.cpp alglib-3.9.0/cpp/src/fasttransforms.cpp alglib-3.9.0/cpp/src/linalg.cpp alglib-3.9.0/cpp/src/specialfunctions.cpp
CPPOBJ = $(CPPSRC:.cpp=.o)

CGAL_INCLUDE= #-I$(HOME)/CGAL-4.5/include # point gcc's -I option to CGAL include directory if you have compiled CGAL manually without installing it
CGAL_LIB= #-L$(HOME)/CGAL-4.5/lib # point gcc's -L option to CGAL lib directory if you have compiled CGAL manually without installing it
CGAL_SHAREDLIB= #-Wl,-rpath=$(HOME)/CGAL-4.5/lib # point gcc's -Wl,-rpath= option to CGAL shared library if you have compiled CGAL manually without installing it

MUPARSER_INCLUDE= #-I$(HOME)/muparser_v2_2_4/include/ # point gcc's -I option to muparser include directory if you have compiled muparser manually without installing it
MUPARSER_LIB= #-L$(HOME)/muparser_v2_2_4/lib/ # point gcc's -L option to muparser lib directory if you have compiled muparser manually without installing it
MUPARSER_SHAREDLIB= #-Wl,-rpath=$(HOME)/muparser_v2_2_4/lib/ # point gcc's -Wl,-rpath= option to muparser shared library if you have compiled muparser manually without installing it

CC=g++
CFLAGS=-O2 -frounding-math -Wall $(CGAL_INCLUDE) $(CGAL_SHAREDLIB) $(MUPARSER_INCLUDE) $(MUPARSER_SHAREDLIB) #-O2: optimize, -Wno-*: suppress warnings from external libraries
LDFLAGS=-lrt -lboost_system $(CGAL_LIB) -lCGAL $(MUPARSER_LIB) -lmuparser
RM=rm
EXE=PENTrack

.PHONY: all
all: $(COBJ) $(CPPOBJ)
	$(CC) -o $(EXE) $(COBJ) $(CPPOBJ) $(CFLAGS) $(LDFLAGS)
	
%.o:%.cpp
	$(CC) -c -o $@ $< $(CFLAGS)

%.o:%.c
	$(CC) -c -o $@ $< $(CFLAGS)

.PHONY: clean
clean:
	$(RM) $(EXE) $(COBJ) $(CPPOBJ)
