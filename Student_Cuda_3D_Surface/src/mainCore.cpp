#include <iostream>

#include "GLUTWindowManagers.h"
#include "Args.h"

#include "RipplingWindow.h"
#include "MandelbrotWindow.h"

using std::cout;
using std::endl;

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

void mainCore(const Args& args)
    {
    GLUTWindowManagers::init(args.argc, args.argv);

    RipplingWindow rippling(RenderMode::RENDER_MODE_FILL); 	// RENDER_MODE_FILL RENDER_MODE_LINE RENDER_MODE_POINT
    //MandelbrotWindow mandelbrot(RenderMode::RENDER_MODE_FILL); 	// RENDER_MODE_FILL RENDER_MODE_LINE RENDER_MODE_POINT

    // Info
    cout << "\nTourner-Zoomer\n" << endl;

    // Run
    GLUTWindowManagers::getInstance()->runALL(); // bloquant
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
