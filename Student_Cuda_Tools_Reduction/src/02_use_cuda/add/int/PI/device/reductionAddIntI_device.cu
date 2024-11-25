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


__global__ void KAddIntProtocoleI(int* ptrSumGM)
    {
    // TODO ReductionAddIntI

    // Reception tabSM
    // ReductionIntraThread
    // ReductionAdd

    // __syncthreads(); // des threads de meme block!// Question : utile? ou?
    extern __shared__ int tabSM[];
    reductionIntraThread(tabSM);
    __syncthreads();
    ReductionAdd::reduce(tabSM, ptrSumGM);
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/**
 * 1 partout en tabSM
 */
__device__ void reductionIntraThread(int* tabSM)
    {
    // TODO ReductionAddIntI
    const int TID_loc = Thread2D::tidLocal();
    tabSM[TID_loc] = 1;

    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

