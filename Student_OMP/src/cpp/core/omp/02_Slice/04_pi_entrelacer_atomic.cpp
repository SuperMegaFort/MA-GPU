#include <omp.h>
#include "Omps.h"
#include "00_pi_tools.h"

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

bool isPiOMPEntrelacerAtomic_Ok(int n);

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

static double piOMPEntrelacerAtomic(int n);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

bool isPiOMPEntrelacerAtomic_Ok(int n)
    {
    return isAlgoPI_OK(piOMPEntrelacerAtomic, n, "Pi OMP Entrelacer atomic");
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/**
 * Bonne performance, si!
 */
double piOMPEntrelacerAtomic(int n)
    {
    // TODO
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
	#pragma opm atomic
	sommeGlobal += sommeThread;

    }


    return sommeGlobal*DX;
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

