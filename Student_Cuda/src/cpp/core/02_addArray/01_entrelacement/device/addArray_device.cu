#include "Thread2D.cu.h"
#include "Thread1D.cu.h"
#include "cudas.h"

#include <stdio.h>

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/**
 * output : void required, car kernel is asynchrone
 * pattern entrelacement
 */
__global__ void addArray(float* ptrGMV1 , float* ptrGMV2 , float* ptrGMW , int n)
    {
    const int NB_THREAD = Thread2D::nbThread();
    const int TID = Thread2D::tid();
    int s = TID;

    while(s < n){
	ptrGMW[s] = ptrGMV1[s] + ptrGMV2[s];
	s += NB_THREAD;

    }

    // Debug, facultatif
//    if (TID == 0)
//	{
//	printf("Coucou from device tid = %d", TID);
//	}

    // TODO addArray
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

