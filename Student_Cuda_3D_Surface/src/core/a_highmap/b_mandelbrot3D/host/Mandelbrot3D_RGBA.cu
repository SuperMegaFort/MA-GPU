#include "Mandelbrot3D_RGBA.h"

#include <assert.h>

#include "Maths.h"
#include "cudas.h"

using std::to_string;

using gpu::DomainMath3D;
using gpu::SurfaceStrip_RGBA_uchar4;

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Imported	 	*|
 \*-------------------------------------*/

extern __global__ void mandelbrot3DCuda(float3* tabVerticesXYZGM, uchar4* tabVerticesColorGM, int w, int h, DomainMath3D domaineMath, int n);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*-------------------------*\
 |*	Constructeur	    *|
 \*-------------------------*/

Mandelbrot3D_RGBA::Mandelbrot3D_RGBA(const Grid& grid , int w , int h , const DomainMath3D& domaineMath , int nMin,int nMax) :
	// Parent
	SurfaceStrip_RGBA_uchar4(w, h, domaineMath), //
	// Inputs
	dg(grid.dg), //
	db(grid.db), //
	// Inputs animation
	nMin(nMin), nMax(nMax),
	// Tools animation
	variateurN(Interval<int>(nMin, nMax), 1) // tools animation
    {
    // Tools
    this->title = "Mandelbrot_RGBA_uchar4";
    this->n = nMin;
    }

Mandelbrot3D_RGBA::~Mandelbrot3D_RGBA()
    {
    // rien
    }

/*-------------------------*\
 |*	Surcharge	   *|
 \*------------------------*/

/**
 * Override
 * Call periodicly by the api
 */
void Mandelbrot3D_RGBA::fillVertex(float3* tabVerticesXYZGM , uchar4* tabVerticesColorGM , uint w , uint h , const gpu::DomainMath3D& domaineMath)
    {
    mandelbrot3DCuda<<<dg,db>>>(tabVerticesXYZGM,tabVerticesColorGM,w,h,domaineMath,n);
    }

/**
 * Override
 * Call periodicly by the api
 */
void Mandelbrot3D_RGBA::animationStep(bool& isNeedUpdate)
    {
    this->n = variateurN.varierAndGet(); // in [nMIn,nMax]
    }

/**
 * Override
 * Call periodicly by the api
 */
void Mandelbrot3D_RGBA::paintPrimitives(Graphic2D& graphic2D)
    {
    graphic2D.setFont(TIMES_ROMAN_24);

    float r = 0.5f;
    float g = 0.5f;
    float b = 0.5f;

    graphic2D.setColorRGB(r, g, b);

    // TOP : Para Animation
	{
	string message = "n = " + to_string(n);
	graphic2D.drawTitleTop(message);
	}

	// BOTTOM : Title
	{
	graphic2D.drawTitleBottom(title);
	}
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

