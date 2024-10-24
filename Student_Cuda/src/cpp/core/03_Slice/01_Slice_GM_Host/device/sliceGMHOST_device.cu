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
 * puis stocke son resultat dans SA case dans tabGM
 *
 * tabGM est un tableau promu, qui a autant de case que de thread
 * </pre>
 */
__global__ void reductionIntraThreadGMHOST(float* tabGM , int nbSlice)
    {
    // TODO SliceGMHOST

    const int TID= Thread2D::tid()//global à la grille
    const int NB_THREAD= Thread2D::nbThread();//nbThreadTotal
    int s=TID;
    while(s<nbSlice)
    {
    // work with : s
    float xs = s*DX;
    sommeThread += fpi(xs);
    float sommeThread = 0;
    s+=NB_THREAD;
    }

    const float NB_THREAD = Omps::setAndGetNaturalGranularity();
    const float DX = 1/(float)n;
    float tabGM[NB_THREAD];

    #pragma omp parallel
    {
	const float TID = Omps::getTid();
	float s = TID;
	float sommeThread = 0;
	while(s < n){
	    float xs = s*DX;
	    sommeThread += fpi(xs);
	    s += NB_THREAD;
	}
	tab[TID]=sommeThread;
    }
    float somme = 0;

    for (int i=0;i<NB_THREAD;i++)
	{
	    somme += tab[i];
	}

    return somme*DX;
}


    // Conseils :
    //
    //		(C1) 	Ne calculer pas en double cote device, mais tout en float.
    //			En particulier, on ecrira 4.0f et non 4 (meme si ici le compilateur va l'optimiser a notre place, mais c'est bien de la faire par principe)
    //
    // 		(C2) 	Effectuez plutot le fois DX de l'aire du slice une seule fois par Thread, que pour chaque slice,
    //          	 ou qu'une seule fois cote host (debordement de type float cote device, car on ne fait que sommer?)
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

__device__ float f(float x)
    {
    // TODO SliceGMHOST
    double fpi(double x)
        {
        return 4 / (1 + x * x);
        }
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
