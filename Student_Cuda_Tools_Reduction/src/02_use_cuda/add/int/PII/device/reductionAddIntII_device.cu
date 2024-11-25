#include "Thread1D.cu.h"
#include "cudas.h"

#include "ReductionAdd.cu.h"

#include <stdio.h>

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

static __device__ void reductionIntraThread(int* tabSM);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/


__global__ void KAddIntProtocoleII(int* ptrSumGM)
    {
    // TODO ReductionAddIntII
    extern __shared__ int tabSM[];
    reductionIntraThread(tabSM);
    __syncthreads();

    ReductionAdd::reduce(tabSM, ptrSumGM);
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/**
 * TID partout en tabSM
 */
__device__ void reductionIntraThread(int* tabSM)
    {
    // TODO ReductionAddIntII
    const int TID_loc = Thread2D::tidLocal();
    const int TID = Thread2D::tid();

    tabSM[TID_loc] = TID;
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

