#include "Thread2D.cu.h"
#include "Thread1D.cu.h"
#include "cudas.h"

#include "Indices.cu.h"

#include "RipplingMath.cu.h"

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

static __device__ void ripplingBaseline(uchar4* tabPixelsGM , uint w , uint h , float t);
static __device__ void ripplingDemi(uchar4* tabPixelsGM , uint w , uint h , float t);
static __device__ void ripplingQuart(uchar4* tabPixelsGM , uint w , uint h , float t);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

__global__ void rippling(uchar4* tabPixelsGM , uint w , uint h , float t)
    {
    ripplingBaseline(tabPixelsGM, w, h, t);
   // ripplingDemi(tabPixelsGM, w, h, t);
   // ripplingQuart(tabPixelsGM, w, h, t);
    }

/*----------------------------------------------------------------------*\
 |*			private	 					*|
 \*---------------------------------------------------------------------*/

/**
 * v1
 */
__inline__
__device__ void ripplingBaseline(uchar4* tabPixelsGM , uint w , uint h , float t)
    {
    // TODO instacier RipplingMath

    const int TID = Thread2D::tid();
    const int NB_THREAD = Thread2D::nbThread();
    const int WH = w * h;

    // TODO Rippling GPU  pattern entrelacement
    }

/**
 * v2 : optimisation
 */
__inline__
__device__ void ripplingDemi(uchar4* tabPixelsGM , uint w , uint h , float t)
    {
    // Indication:
    //		(I1)	Utiliser la symetrie horizontale de l'image
    //		(I2)	Calculer que la demi partie superieur
    //		(I3)	Ranger la couleur calculer dans la demi partie inferieur (effet miroir)
    //			Partez de la fin de l'image, peut-etre

    // TODO Rippling GPU
    }

/**
 * v3 : optimsation : defi (difficile)
 */
__inline__
__device__ void ripplingQuart(uchar4* tabPixelsGM , uint w , uint h , float t)
    {
    // Indication:
    //		(I1)	Utiliser la symetrie horizontale et verticale de l'image
    //		(I2)	Calculer que le quart en huat a gauche
    //		(I3)	Ranger la couleur calculer dans les autres quarts
    //	Warning
    //		(w1)	Necessaire sans doute pour passer le test performance
    //
    //	Contrainte
    //		(C1)	Utiliser toujours le pattern d'entrelacement

    // TODO Rippling GPU
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

