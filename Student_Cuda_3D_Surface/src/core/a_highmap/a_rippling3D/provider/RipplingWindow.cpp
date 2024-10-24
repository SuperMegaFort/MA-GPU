#include "RipplingWindow.h"

#include "Rippling3DProvider.h"


using std::cout;

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*-------------------------*\
 |*	Constructeur	    *|
 \*-------------------------*/

RipplingWindow::RipplingWindow(RenderMode renderMode) : //
	renderMode(renderMode)
    {
    this->ptrSurfaceStrip = Rippling3DProvider::createSurfaceStrip();

    // Scene
    this->ptrScene = new SurfaceSceneStrip(this->ptrSurfaceStrip);

    // Scene Options
	{
	this->ptrScene->setAppearance(renderMode); // RENDER_MODE_FILL RENDER_MODE_LINE RENDER_MODE_POINT

	BoundViewOption boundViewOptionRippling(false, false, false, false, false, false);
	this->ptrScene->setBoundViewOption(boundViewOptionRippling);
	}

    // Window
    this->prtWindow = new GLUTWindowScene(this->ptrScene, "Rippling", 1024, 768, 10, 10);  // w x px py

    cout<<"Rippling : warning : rotate to the sunny side of the surface to see the rippling.\n";
    }

RipplingWindow::~RipplingWindow()
    {
    // delete this->ptrScene; // pas besoin fait dans ptrSurfaceStrip
    delete this->ptrSurfaceStrip;
    delete this->prtWindow;
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

