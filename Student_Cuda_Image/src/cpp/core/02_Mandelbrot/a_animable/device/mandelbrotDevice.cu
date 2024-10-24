#include "Thread2D.cu.h"
#include "cudas.h"

#include "real.h"
#include "MandelbrotMath.cu.h"

#include "DomaineMath.h"
#include "Indices.cu.h"

/*----------------------------------------------------------------------*\
 |*			Piste Optimisation 				*|
 \*---------------------------------------------------------------------*/

// optimisation lookup table color
static __device__ void fill(uchar4* tabSM,int n);
static __device__ void color(uchar4* ptrColor,int k, int n);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

__global__ void mandelbrot(uchar4* tabPixelsGM , uint w , uint h , DomaineMath domaineMath , int n)
    {
    MandelbrotMath mandelbrotMath(n);

    // TODO Mandelbrot GPU :
    //
    // entrelacement
    // s -> (i,j) -> (x,y)
    // appeler colorXY

    double x;
    double y;
    //domaineMath.toXY(i, j, &x, &y); // x et y doivent etre en double! Caster ensuite en real lors du passage à colorXY

    // Probleme : Choix a faire pour le type de (x,y) :
    //
    //			- Travailler en float pour plus de performance?
    //			- Travailler en double pour pouvoir zoomer plus loin dans le fractale?
    //
    // Solution : Travailler avec le typedef real definit dans "real.h"
    //		  Specifier dans "real.h" si vous souhaitez travailler en float ou en double
    //	          Ainsi on passe facilement et proprement d'une version float a une version double
    //
    // Note : domaineMath.toXY travaille lui toujours en double pour vous permettre les deux possibilites ci-dessus
    //
    }

/*----------------------------------------------------------------------*\
 |*			private	 					*|
 \*---------------------------------------------------------------------*/

/**
 * optimisation lookup table color
 */
__inline__
__device__ void fill(uchar4* tabSM,int n)
    {
    // Indications:
    //		(I1)	tabSM a n cases
    //		(I2)	La case k contient les couleurs en RVBA lorsque la suite s est arreter a k
    //		(I3)	Utiliser la methode color ci-dessous pour vous aider
    //		(I4)	Utiliser tabSM dans la partie mandelbrotMath, updater a cet effet quelques prototypes si necessaire
    //			Passer par exemple tabSM au constructeur de mandelbrotMath
    //
    //	Warning
    //		(W1)	Commencer d'abord sans cette piste d'optimisation

    }

/**
 * optimisation lookup table color
 */
__inline__
__device__ void color(uchar4* ptrColor,int k, int n)
    {

    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

