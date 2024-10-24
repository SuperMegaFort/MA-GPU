#include "Rippling3D_RGBA.h"

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

extern __global__ void rippling3DCuda(float3* tabVerticesXYZGM, uchar4* tabVerticesColorGM, int w, int h,float t);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*-------------------------*\
 |*	Constructeur	    *|
 \*-------------------------*/

Rippling3D_RGBA::Rippling3D_RGBA(const Grid& grid , int w , int h , const DomainMath3D& domaineMath , double dt) :
	// Parent
	SurfaceStrip_RGBA_uchar4(w, h, domaineMath), //
	// Inputs
	dg(grid.dg), //
	db(grid.db), //
	// Inputs animation
	dt(dt)
    {
    // Tools
    this->t=0;
    this->title = "Rippling3D_RGBA_uchar4";
    }

Rippling3D_RGBA::~Rippling3D_RGBA()
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
void Rippling3D_RGBA::fillVertex(float3* tabVerticesXYZGM , uchar4* tabVerticesColorGM , uint w , uint h , const gpu::DomainMath3D& domaineMath)
    {
    rippling3DCuda<<<dg,db>>>(tabVerticesXYZGM,tabVerticesColorGM,w,h,t);
    }

/**
 * Override
 * Call periodicly by the api
 */
void Rippling3D_RGBA::animationStep(bool& isNeedUpdate)
    {
    this->t+=dt;
    }

/**
 * Override
 * Call periodicly by the api
 */
void Rippling3D_RGBA::paintPrimitives(Graphic2D& graphic2D)
    {
    graphic2D.setFont(TIMES_ROMAN_24);

    float r = 0.5f;
    float g = 0.5f;
    float b = 0.5f;

    graphic2D.setColorRGB(r, g, b);

    // TOP : Para Animation
	{
	string message = "t= " + to_string(t);
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

