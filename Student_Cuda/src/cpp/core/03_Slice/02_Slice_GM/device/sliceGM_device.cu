#include "Thread2D.cu.h"
#include "Thread1D.cu.h"
#include "cudas.h"

#include <stdio.h>

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

static __device__ float f(float x);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/**
 * <pre>
 * Chaque thread effecteur une reduction intrathread avec le patern d'entrelacement,
 * puis stocke son résultat dans SA case dans tabGM
 *
 * tabGM est un tableau promu, qui a autant de case que de thread
 * </pre>
 */

__global__ void reductionIntraThreadGM(float* tabGM , int nbSlice)
    {
    const int NB_THREAD = Thread2D::nbThread();
    const int TID = Thread2D::tid();
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
    tabGM[TID] = sum * DX;
    }
/**
 * <pre>
 * Effectue la reduction de tabGM cote device, par ecrasement 2 à 2 successif.
 * Ce kernel d ecrasement est appeler depuis le host dans une boucle, avec le bon nombre de thread
 *
 * Hypothese : |tabGM| est une puissance de 2
 *
 * Output: le resultat de la reduction est tans tabGM[0]
 * </pre>
 */
/*
__global__ void ecrasementGM(float* tabGM , int middle)
    {
    // TODO SliceGM

    int tid = Thread1D::tid();
    if (tid < middle) {
	tabGM[tid] += tabGM[tid + middle];
        }
    }
*/
__global__ void ecrasementGM(float* tabGM , int middle)
    {
    const int TID = Thread2D::tid();
    tabGM[TID] = tabGM[TID] + tabGM[TID + middle];
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

__device__ float f(float x)
    {
    // TODO SliceGM
    return 4.f / (1.f + x * x);
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

