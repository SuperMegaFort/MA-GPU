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

//    Rippling3DMath rippling3DMath(n);

    const int TID = Thread2D::tid();
    const int NB_THREAD = Thread2D::nbThread();

    const int WH = w * h;

//    float x;
//    float y;
//    float DX;
//    float DY;
    int i, j;
//    int vertexI;
//    int vertexJ;

//    Rippling3DMath.delta(w, h, &DX, &DY);

    int s = TID;
    while (s < WH)
	{
	Indices::toIJ(s, w, &i, &j); // update (vertexI, vertexJ)

//	Rippling3DMath.toXY(DX, DY, vertexI, vertexJ, &x, &y);

	rippling3DMath.xyz(&tabVerticesColorGM[s], &tabVerticesXYZGM[s], i, j); // update (sommet s , color s)

	s += NB_THREAD;
	}


    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

