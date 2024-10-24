#include "Mandelbrot3DMath.h"
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
 */
__global__ void mandelbrot3DCuda(float3* tabVerticesXYZGM , uchar4* tabVerticesColorGM , int w , int h , DomainMath3D domaineMath , int n)
    {
    Mandelbrot3DMath mandelbrot3DMath(n);

    const int TID = Thread2D::tid();
    const int NB_THREAD = Thread2D::nbThread();

    const int WH = w * h;

    float x;
    float y;
    float DX;
    float DY;

    int vertexI;
    int vertexJ;

    domaineMath.delta(w, h, &DX, &DY);

    int s = TID;
    while (s < WH)
	{
	Indices::toIJ(s, w, &vertexI, &vertexJ); // update (vertexI, vertexJ)

	domaineMath.toXY(DX, DY, vertexI, vertexJ, &x, &y);

	mandelbrot3DMath.xyz(&tabVerticesColorGM[s], &tabVerticesXYZGM[s], x, y);

	s += NB_THREAD;
	}
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

