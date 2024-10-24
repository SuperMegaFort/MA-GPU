#include <omp.h>
#include "Omps.h"
#include "00_pi_tools.h"

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

bool isPiOMPEntrelacerPromotionTab_Ok(int n);

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

static double piOMPEntrelacerPromotionTab(int n);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

bool isPiOMPEntrelacerPromotionTab_Ok(int n)
    {
    return isAlgoPI_OK(piOMPEntrelacerPromotionTab, n, "Pi OMP Entrelacer promotionTab");
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/**
 * pattern cuda : excellent!
 */
double piOMPEntrelacerPromotionTab(int n)
    {
    //TODO
    const int NB_THREAD = Omps::setAndGetNaturalGranularity();
    const double DX = 1/(double)n;
    double tab[NB_THREAD];
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
	tab[TID]=sommeThread;
    }
    double somme = 0;
    for (int i=0;i<NB_THREAD;i++)
	{
	    somme += tab[i];
	}

    return somme*DX;
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

