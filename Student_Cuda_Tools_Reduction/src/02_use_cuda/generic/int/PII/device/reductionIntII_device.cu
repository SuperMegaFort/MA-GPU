#include "Thread1D.cu.h"
#include "cudas.h"

#include "Reduction.cu.h"
#include "Lock.cu.h"

#include <stdio.h>

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

static __device__ void reductionIntraThread(int* tabSM);

// Operateur reduction
static __device__ int add(int x , int y);
static __device__ void addAtomicV1(int* ptrX , int y);
static __device__ void addAtomicV2(int* ptrX , int y);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

__global__ void KIntProtocoleII(int* ptrSumGM)
    {
    // TODO ReductionIntII
    extern __shared__ int tabSM[];
    reductionIntraThread(tabSM);
    __syncthreads();
    Reduction::reduce(add, addAtomicV1, tabSM, ptrSumGM);
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/**
 * TID partout en tabSM
 */
__device__ void reductionIntraThread(int* tabSM)
    {
    // TODO ReductionIntII
    const int TID_loc = Thread2D::tidLocal();
    const int TID = Thread2D::tid();

    tabSM[TID_loc] = TID;
    }

/*----------------------------*\
|*	Operateur reduction    *|
 \*---------------------------*/

__device__ int add(int x , int y)
    {
    // TODO ReductionIntII
    return x+y;
    }



/**
 * Utiliser la methode system : atomicAdd(pointeurDestination, valeurSource);
 */
__device__ void addAtomicV1(int* ptrX , int y)
    {
    // TODO ReductionIntII
    atomicAdd(ptrX, y);
    }

/**
 * Une alternative, moins performante, mais generalisable serait d'employer un lock
 * Tip : le Lock est implementer avec deux methodes atomic
 */
__device__ int volatile mutex = 0;	//variable global
__device__ void addAtomicV2(int* ptrX , int y)
    {
    Lock locker(&mutex);
    locker.lock();

    // TODO ReductionIntII
    *ptrX = *ptrX +y;
    locker.unlock();
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

