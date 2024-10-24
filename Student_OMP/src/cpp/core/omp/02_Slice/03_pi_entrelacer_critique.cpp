#include <omp.h>
#include "Omps.h"
#include "00_pi_tools.h"

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

bool isPiOMPEntrelacerCritical_Ok(int n);

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

static double piOMPEntrelacerCritical(int n);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

bool isPiOMPEntrelacerCritical_Ok(int n)
    {
    return isAlgoPI_OK(piOMPEntrelacerCritical, n, "Pi OMP Entrelacer critical");
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

double piOMPEntrelacerCritical(int n)
    {
	//TODO
	    const int NB_THREAD = Omps::setAndGetNaturalGranularity();
	    const double DX = 1/(double)n;
	    double sommeGlobal = 0;
	    #pragma omp parallel
	    {
		const int TID = Omps::getTid();
		int s = TID;
		double sommeThread = 0;
		while(s < n){
		    double xs = s*DX;
		    sommeThread += fpi(xs);
		    s += NB_THREAD;
		}
		#pragma opm critical
		{
		sommeGlobal += sommeThread;
	    }
	    }
	    

	    return sommeGlobal*DX;
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

