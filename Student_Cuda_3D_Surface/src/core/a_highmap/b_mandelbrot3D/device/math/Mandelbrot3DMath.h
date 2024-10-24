#pragma once

#include <math.h>
#include <cuda_fp16.h>

//#include "Calibreur.cu.h"
#include "Colors.cu.h"

//Half
#define DEUX (half)2
#define QUATRE (half)4
#define ZERO (half)0

// float
//#define DEUX 2.f
//#define QUATRE 4.f
//#define ZERO 0.f

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

class Mandelbrot3DMath
    {

	/*--------------------------------------*\
	|*		Constructor		*|
	 \*-------------------------------------*/

    public:

	__device__ Mandelbrot3DMath(int n) :
		n(n)
	    {
	    // rien
	    }

	/*--------------------------------------*\
	|*		Methodes		*|
	 \*-------------------------------------*/

    public:

	__device__
	void xyz(uchar4* ptrColorIJ , float3* ptrSommetXYZ , float x , float y)
	    {
	    ptrSommetXYZ->x = x;
	    ptrSommetXYZ->y = y;

	    int k = suite((half)x, (half)y); // in [0,n]

	    if (k >= n)
		{
		// sommet
		    {
		    // TODO  hauteur 0
		    }

		// color black
		    {
		    // TODO comme en 2D
		    }
		}
	    else
		{
		float h01 = k / (float)(n - 1); // in [0,1]

		// sommet
		    {
		    // TODO utiliser la fonction z ci-dessous
		    }

		// color
		    {
		    // TODO comme end 2D
		    }
		}
	    }

    private:

	/*---------------------*\
	|*	suite		*|
	 \*--------------------*/

	__inline__
	__device__
	int suite(half x , half y)
	    {
	    // TODO comme en 2D
	    }

	/*---------------------*\
	|*	hauteur		*|
	 \*--------------------*/

	__inline__
	__device__
	float z(float h01)
	    {
	    const int M = 8; //disons
	    return logs(h01, M) + 0.5f;
	    }

	__inline__
	__device__
	float logs(float z, const int M)
	    {
	    for (int i = 0; i <= M; i++)
		{
		z = log(z + 1.0f);
		}
	    return z;
	    }

	/*--------------------------------------*\
	|*		Attributs		*|
	 \*-------------------------------------*/

    private:

// Input
	int n;

    };

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
