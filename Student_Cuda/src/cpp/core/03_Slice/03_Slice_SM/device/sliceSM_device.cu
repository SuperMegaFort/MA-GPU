#include "Thread2D.cu.h"
#include "Thread1D.cu.h"
#include "ReductionAdd.cu.h"

#include "cudas.h"

#include <stdio.h>

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

static __device__ void reductionIntraThread(float* tabSM,int nbSlice);
static __device__ float f(float x);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

__global__ void sliceSM(int nbSlice , float* ptrPiHatGM)
    {
    // TODO SliceSM
    extern __shared__ float tabSM[];
    reductionIntraThread(tabSM, nbSlice);

    __syncthreads();
    ReductionAdd::reduce(tabSM, ptrPiHatGM);

    // Reception tabSM
    // ReductionIntraThread
    // Reduction de tabSM (use tools ReductionAdd)

    // __syncthreads(); necessaire? ou?
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/**
 * remplit la sm
 */
__device__ void reductionIntraThread(float* tabSM , int nbSlice)
    {
    // TODO SliceSM
	const int TID = Thread2D::tid();
        const int TID_LOCAL = Thread2D::tidLocal();
        const int NB_THREAD = Thread2D::nbThread();
        const float DX = 1 / (float)nbSlice;



        int s = TID;
        float sum = 0;
        float xs;

        while (s < nbSlice)
            {
            xs = s * DX;
            sum += f(xs);
            s += NB_THREAD;
            }

        tabSM[TID_LOCAL] = sum * DX;



    // Warning: Il faut employer TID et TID_LOCAL
    }

__device__ float f(float x)
    {
    // TODO SliceSM
    return 4.f / (1.f + x * x);
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

