CC=gcc
CFLAGS=-O3 -lm -std=c99

OPT_EXE=Cordic_Optimized
OPT_OBJ=cordic_optimized.o 

NORM_EXE=Cordic
NORM_OBJ=cordic.o

opt:$(OPT_EXE)
$(OPT_EXE):$(OPT_OBJ)
	$(CC) $^ -o $@
	rm -rf $(OPT_OBJ)

norm:$(NORM_EXE)
$(NORM_EXE):$(NORM_OBJ)
	$(CC) $^ -o $@
	rm -rf $(NORM_OBJ)

clean:
	rm -rf $(OPT_EXE) $(OPT_OBJ) $(NORM_EXE) $(NORM_OBJ)
