#include "Rippling3DMath.h"
#include "Thread2D.cu.h"
#include "Indices.cu.h"

#include "cudas.h"

#include "DomainMath3D_GPU.h"
using namespace gpu;

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/**
 * w nbPoint en x
 * h nbPoint en y
 *
 * domaineMath pas utiliser ici
 */
__global__ void rippling3DCuda(float3* tabVerticesXYZGM , uchar4* tabVerticesColorGM , int w , int h , float t)
    {
    Rippling3DMath rippling3DMath(w, h, t);

    // Indication :
    //		(I1) 	comme en 2D
    //		(I2) 	domaineMath pas utiliser ici

    // TODO
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

