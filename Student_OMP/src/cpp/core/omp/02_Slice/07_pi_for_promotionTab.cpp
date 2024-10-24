#include <omp.h>
#include "Maths.h"
#include "Omps.h"
#include "00_pi_tools.h"

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

bool isPiOMPforPromotionTab_Ok(int n);

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

static double piOMPforPromotionTab(int n);
static void syntaxeSimplifier(double* tabSumThread , int n);
static void syntaxeFull(double* tabSumThread , int n);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

bool isPiOMPforPromotionTab_Ok(int n)
    {
    return isAlgoPI_OK(piOMPforPromotionTab, n, "Pi OMP for promotion tab");
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/**
 * De-synchronisation avec PromotionTab
 */
double piOMPforPromotionTab(int n)
    {
    const int NB_THREAD = Omps::setAndGetNaturalGranularity();
    const double DX = 1/(double)n;
    double tab[NB_THREAD];

    for (int i=0;i<NB_THREAD;i++)
    {
        tab[i] = 0;
    }

    #pragma omp parallel for
    for (int i=0;i<n;i++)
    {
	const int TID = Omps::getTid();
	double xi = i*DX;
	#pragma omp atomic
	tab[TID] += fpi(xi);
    }
    double somme = 0;
    for (int i=0;i<NB_THREAD;i++)
    {
	somme += tab[i];
    }

    return somme * DX;
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

