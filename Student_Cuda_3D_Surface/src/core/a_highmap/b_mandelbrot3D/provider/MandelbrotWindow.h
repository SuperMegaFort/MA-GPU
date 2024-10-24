#pragma once

#include "SurfaceSceneStrip.h"
#include "GLUTWindowScene.h"

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

class MandelbrotWindow
    {
	/*--------------------------------------*\
	|*		Constructor		*|
	 \*-------------------------------------*/

    public:

	/**
	 * <pre>
	 * RenderMode:
	 * 		- RENDER_MODE_FILL
	 * 		- RENDER_MODE_LINE
	 * 		- RENDER_MODE_POINT
	 * </pre>
	 */
	MandelbrotWindow(RenderMode renderMode = RenderMode::RENDER_MODE_FILL);

	virtual ~MandelbrotWindow();

	/*--------------------------------------*\
	 |*		Methodes		*|
	 \*-------------------------------------*/

	/*--------------------------------------*\
	|*		Attributs		*|
	 \*-------------------------------------*/

    private:

	// Inputs
	RenderMode renderMode;

	// Tools
	SurfaceStrip_I* ptrSurfaceStrip;
	SurfaceSceneStrip* ptrScene;
	GLUTWindowScene* prtWindow;
    };

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
