#include <iostream>

#include "Grid.h"
#include "Hardware.h"
#include "Maths.h"

#include "Mandelbrot3D_RGBA.h"
#include "Mandelbrot3DProvider.h"

#include "DomainMath3D_GPU.h"

using gpu::DomainMath3D;

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/**
 * static
 */
SurfaceStrip_I* Mandelbrot3DProvider::createSurfaceStrip()
    {
    // Dimension
    int w = 3200;
    int h = w; // contrainte temporaire! Doit eter carrer, sinon bug!

    // Animation
    int nMin = 5;
    int nMax = 75;

    // Domaine init
    double x1 = -2.1;
    double y1 = -1.3;

    double x2 = 0.8;
    double y2 = 1.3;

    double z1 = 0;
    double z2 = 1;

    DomainMath3D domaineMath(x1, x2, y1, y2, z1, z2); // Attention ordre, pas idem DomainMath2D, ici x1,x2, ...

    // Grid Cuda
    int mp = Hardware::getMPCount();
    int coreMP = Hardware::getCoreCountMP();

    dim3 dg(mp, 4, 1);  	// disons, a optimiser selon le gpu, peut drastiqument ameliorer ou baisser les performances
    dim3 db(coreMP, 4, 1);   	// disons, a optimiser selon le gpu, peut drastiqument ameliorer ou baisser les performances
    Grid grid(dg, db);

    return new Mandelbrot3D_RGBA(grid, w, h, domaineMath, nMin, nMax); // Model
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

