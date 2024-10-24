#include <iostream>

#include "Grid.h"
#include "Hardware.h"
#include "Maths.h"

#include "Rippling3D_RGBA.h"
#include "Rippling3DProvider.h"

#include "DomainMath3D_GPU.h"

using gpu::DomainMath3D;

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/**
 * static
 */
SurfaceStrip_I* Rippling3DProvider::createSurfaceStrip()
    {
    // Dimension
    int w = 960;
    int h = w; // contrainte temporaire! Doit eter carrer, sinon bug!

    // Animation;
    float dt = 2 * PI / 10;

    // Domaine init
    double x1 = -w / 2;
    double y1 = -h / 2;

    double x2 = w / 2;
    double y2 = h / 2;

    double z1 = 0;
    double z2 = 6 * 255;

    DomainMath3D domaineMath(x1, x2, y1, y2, z1, z2); // Attention ordre, pas idem DomainMath2D, ici x1,x2, ...

    // Grid Cuda
    int mp = Hardware::getMPCount();
    int coreMP = Hardware::getCoreCountMP();

    dim3 dg(mp, 4, 1);  	// disons, a optimiser selon le gpu, peut drastiqument ameliorer ou baisser les performances
    dim3 db(coreMP, 4, 1);   	// disons, a optimiser selon le gpu, peut drastiqument ameliorer ou baisser les performances
    Grid grid(dg, db);

    return new Rippling3D_RGBA(grid, w, h, domaineMath, dt); // Model
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

