#include "MandelbrotWindow.h"

#include "Mandelbrot3DProvider.h"

using std::cout;

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*-------------------------*\
 |*	Constructeur	    *|
 \*-------------------------*/

MandelbrotWindow::MandelbrotWindow(RenderMode renderMode) : //
	renderMode(renderMode)
    {
    this->ptrSurfaceStrip = Mandelbrot3DProvider::createSurfaceStrip();

    // Scene
    this->ptrScene = new SurfaceSceneStrip(this->ptrSurfaceStrip);

    // Scene Options
	{
	this->ptrScene->setAppearance(renderMode); // RENDER_MODE_FILL RENDER_MODE_LINE RENDER_MODE_POINT

	BoundViewOption boundViewOptionRippling(false, false, false, false, false, false);
	this->ptrScene->setBoundViewOption(boundViewOptionRippling);
	}

    // Window
    this->prtWindow = new GLUTWindowScene(this->ptrScene, "Mandelbrot", 1024, 768, 50, 50);  // w x px py
    }

MandelbrotWindow::~MandelbrotWindow()
    {
    // delete this->ptrScene; // pas besoin fait dans ptrSurfaceStrip
    delete this->ptrSurfaceStrip;
    delete this->prtWindow;
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

