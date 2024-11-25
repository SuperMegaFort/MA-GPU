#include "Thread1D.cu.h"
#include "cudas.h"

#include "Reduction.cu.h"


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


__global__ void KIntProtocoleI(int* ptrSumGM)
    {
    // TODO ReductionIntI
    extern __shared__ int tabSM[];
    reductionIntraThread(tabSM);
    __syncthreads();
    Reduction::reduce(add, addAtomicV1, tabSM, ptrSumGM);
    // nom fonction = pointeur fonction
    //Reduction::reduce(add, addAtomicV2, tabSM, ptrSumGM);
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/**
 * 1 partout en tabSM
 */
__device__ void reductionIntraThread(int* tabSM)
    {
    // TODO ReductionIntI
    const int TID_loc = Thread2D::tidLocal();
    tabSM[TID_loc] = 1;
    }

/*----------------------------*\
|*	Operateur reduction    *|
 \*---------------------------*/

__device__ int add(int x , int y)
    {
    // TODO ReductionIntI
    return x+y;
    }

/**
 * Utiliser la methode system
 *
 * 		atomicAdd(pointeurDestination, valeurSource);
 */
__device__ void addAtomicV1(int* ptrX , int y)
    {
    // TODO ReductionIntI
    atomicAdd(ptrX, y);
    }

/**
 * 10x plus lent,mais plus flexible!
 * Necessaire si un vrai operateur atomic n'existe pas
 * Necessaire aussi pour des objets par exemple
 */
__device__ int volatile mutex = 0;	//variable global
__device__ void addAtomicV2(int* ptrX , int y)
    {
    Lock locker(&mutex);
    locker.lock();

    // TODO ReductionIntI
    *ptrX = *ptrX +y; // * = contenu de..
    locker.unlock();
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

