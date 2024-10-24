#pragma once

#include "cuda_fp16.h"

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

class VectorTools
    {

	/*--------------------------------------*\
	|*		Methodes		*|
	 \*-------------------------------------*/

    public:

	/*--------------------------------------*\
	|*		Vector			*|
	 \*-------------------------------------*/

	static int n();

	static int* createV1(int n);
	static int* createV2(int n);

	static void print(int* ptrV , int n);

	static bool isAddVector_Ok(int* ptrV1 , int* ptrV2 , int* ptrW , int n);

	/*--------------------------------------*\
	|*		MM			*|
	 \*-------------------------------------*/

	static int* create(int n);
	static void free(int* ptrV);
	static bool isDMA();

    private:

	/*--------------------------------------*\
	|*		n warmup		*|
	 \*-------------------------------------*/

	static int nWarmup_3_slices();
	static int nWarmup_4_slices();
	static int nWarmup_5_slices();

	/*--------------------------------------*\
	|*		n generique		*|
	 \*-------------------------------------*/

	static int nGenerique1();
	static int nGenerique2();

	static void check_nGenerique1(int n);

    };

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
