# Example *nix/mac makefile (trivial)

all: check

build:
	ifort checkhwm14.f90 hwm14.f90 -o check.opt.exe	
#	ifort -O0 checkhwm14.f90 hwm14.f90 -o check.nopt.exe	
#	gfortran checkhwm14.f90 hwm14.f90 -o check.gcc.exe	

check: build
	./check.opt.exe > Check/result.txt
	diff Check/result.txt Check/ifort.opt.txt 

clean:
	rm *.mod *.exe *.o Check/result.txt
