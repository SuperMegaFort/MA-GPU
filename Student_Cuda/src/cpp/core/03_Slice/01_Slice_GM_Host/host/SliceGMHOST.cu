#include "SliceGMHOST.h"

#include <iostream>
#include <assert.h>

#include "GM.h"
#include "Maths.h"
#include "Hardware.h"
#include "Kernel.h"

using std::cout;
using std::endl;
using std::to_string;

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Imported	 	*|
 \*-------------------------------------*/

extern __global__ void reductionIntraThreadGMHOST(float* tabGM,int nbSlice);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Constructeur			*|
 \*-------------------------------------*/

SliceGMHOST::SliceGMHOST(Grid grid , int nbSlice , double* ptrPiHat , bool isVerbose) :
	RunnableGPU(grid, "SliceGM-HOST-" + to_string(nbSlice), isVerbose), // classe parente
//
	nbSlice(nbSlice), //
	ptrPiHat(ptrPiHat) //
    {
    // ntabGM
	{
	this->nTabGM = grid.threadCounts(); // TODO SliceGMHOST // le nombre de case de tabGM. Indication :  grid.threadCounts() donne le nombre de thread ed la grille


	// Warning : Advanced : Et si plus de threads que slices? complique! (pas utile de le coder)
	}

    // MM
	{
	this->sizeTabGM =n*sizeof(float);//  TODO SliceGMHOST // la taille en octet de tabGM [octet]

	}
    }

SliceGMHOST::~SliceGMHOST(void)
    {
    //MM (device free)
	{
	// TODO SliceGMHOST
	GM::free(ptrGMV1);

	}
    }

/*--------------------------------------*\
 |*		Methode			*|
 \*-------------------------------------*/

/**
 * <pre>
 * Idea globale
 *
 *	Etape 0 : Promotion d'un tableau en GM (MemoryManagement MM)		(Dans le constructeur)
 * 	Etape 1 : Reduction intra-thread dans un tableau promu en GM
 * 	Etape 2 : Copy du tableau coter host
 * 	Etape 3 : Reduction  du tableau coter host
 * 	Etape 4 : Destruction GM						(Dans le destructeur)
 *
 * </pre>
 */
void SliceGMHOST::run()
    {
    // TODO SliceGMHOST // call the kernel
    reductionIntraThreadGMHOST<<<dg,db>>>(float* tabGM,int nbSlice);

    // Indication:
    // 		dg et db sont stokcer dans la classe parente
    // 		vous pouvez les utiliser directement
    // 		exemple : reductionIntraThreadGMHOST<<<dg,db>>>(...)

    reductionHost();
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/**
 * Reduction paralle sur cpu du tableau promu en GM, ramener coter host
 */
void SliceGMHOST::reductionHost()
    {
    // 1) Creer un tableau de bonne dimension (sur la pile, possible ssi petit, sinon sur la tas)
    // 2) Transferer la tabGM dedans
    // 3) Reduction sequentiel cote host
    // 4) finalisation du calcul de ptrPiHat

    // TODO SliceGMHOST
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
