#include "AddVectorTristream.h"

#include <iostream>
#include <assert.h>

#include "Kernel.h"
#include "GM.h"
#include "Bandwidth.h"
#include "VectorTools.h"
#include "Stream.h"

using std::cout;
using std::endl;
using std::to_string;
using std::string;

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Imported	 	*|
 \*-------------------------------------*/

extern __global__ void addVector(int* ptrGmSlice1 , int* ptrGmSlice2 , int* ptrGmSliceW , int n_by_slice , int sid = 0);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Constructeur			*|
 \*-------------------------------------*/

AddVectorTristream::AddVectorTristream(const Grid& grid , int* ptrV1 , int* ptrV2 , int* ptrW , int n , int nbSlice , bool isVerbose) :
	RunnableGPU(grid, title(nbSlice) + "-" + to_string(n), isVerbose), // classe parente
	//
	ptrV1(ptrV1), //
	ptrV2(ptrV2), //
	ptrW(ptrW), //
	n(n), //
	nbSlice(nbSlice)
    {
    assert(n % nbSlice == 0);
    assert(nbSlice >= 3);

    this->sizeVector = n * sizeof(int); // octet
    this->SIZE_SLICE = sizeVector / nbSlice;
    this->N_BY_SLICE = n / nbSlice;

    // MM (malloc Device)
	{
	GM::malloc(&ptrGMV1, sizeVector);
	GM::malloc(&ptrGMV2, sizeVector);
	GM::malloc(&ptrGMW, sizeVector);
	}

    // Stream
	{
	// TODO stream, see attribute in .h
	assert(false); // to remove once coded
	}
    }

AddVectorTristream::~AddVectorTristream(void)
    {
    //MM (device free)
	{
	GM::free(ptrGMV1);
	GM::free(ptrGMV2);
	GM::free(ptrGMW);
	}

    // Stream
	{
	// TODO stream, see attribute in .h
	}
    }

/*--------------------------------------*\
 |*		Methode			*|
 \*-------------------------------------*/

/**
 * Conseils :
 *
 * 	(C1) Commencer par les warmup pour un nombre de slice petit et fixe, puis passer seulement ensuite a la generalisation.
 *
 * 	(C2) Pour les warmup, prenez une taille n de vecteur petit (pour pouvoir afficher le resultat)
 * 	     Aller dans:
 *
 * 	    		VectorTools::n(); // activez la ligne debug provisoirement, et dans nDebug() prenez une valeur petite et divisible par votre nombre se slice
 *
 * 	(C3) Travailler au début avec mainUse.cpp (utiliser le blog debug fournit avec flag de verbosite a false avec !)
 */
void AddVectorTristream::run()
    {
    // warmup
	{
	run3Slice();
	//run4Slice();
	//run5Slice();
	}

    //runGeneric(); // TODO stream a activer une fois le warmup valider

    // Warning : le mode LaunchModeMOO::TEST dans main a besoin du code generic coder et activer

    // synchronise
	{
	// TODO stream (attendre la fin de toutes les stream de ce tp)
	}
    }

/*--------------------------------------*\
 |*	Differentes Versions		*|
 \*-------------------------------------*/

// pour des raisons de clareter, le code se trouve dans les .h includer ci-dessous (il se trouve dans le folder helper)

#include "run3Slice.h"
#include "run4Slice.h"
#include "run5Slice.h"
#include "runGeneric.h"

/*--------------------------------------*\
 |*		Tools			*|
 \*-------------------------------------*/

/**
 * sid=sliceIndex in [0,nbSlice[
 * return decalage a effectuer pour pointer sur le premier element d'une slice.
 *
 * Exemple:
 *
 * 	Si les slices ont 4 cases, et qu'il a 3 slices:
 *
 * 	sid=0  offsetSlice(0) vaut 0	ptrGMV1+offsetSlice(0) pointe sur la premiere case du slice 0   (de v1)
 * 	sid=1  offsetSlice(1) vaut 4	ptrGMV1+offsetSlice(1) pointe sur la premiere case du slice 1	(de v1)
 * 	sid=2  offsetSlice(2) vaut 8	ptrGMV1+offsetSlice(2) pointe sur la premiere case du slice 2	(de v1)
 */
int AddVectorTristream::offsetSlice(int sid)
    {
    assert(false); // remove once coded
    return 0; // TODO stream
    }

/**
 * copyHtoD: la slice sid pour
 *
 * 	v1
 * 	v2
 * ou
 * 	sid=sliceIndex in [0,nbSlice[
 */
void AddVectorTristream::copyHtoD(int sid , cudaStream_t stream)
    {
    const int OFFSET_SLICE = offsetSlice(sid);

    // Indication:
    //		pour le slice de v1
    //		pour le slice de v2

    // TODO stream
    assert(false); // remove once coded
    }

/**
 * copyDtoH: la slice sid pour
 *
 * 	w
 * ou
 * 	sid=liceIndex in [0,nbSlice[
 */
void AddVectorTristream::copyDtoH(int sid , cudaStream_t stream)
    {
    const int OFFSET_SLICE = offsetSlice(sid);

    // TODO stream
    assert(false); // remove once coded
    }

/**
 * lance le kernel de calcul pour la slice sid
 * ou
 * 	sid=sliceIndex in [0,nbSlice[
 */
void AddVectorTristream::kernelSlice(int sid , cudaStream_t stream)
    {
    const int OFFSET_SLICE = offsetSlice(sid);

    // TODO stream
    assert(false); // remove once coded
    }

/*------------------------*\
|*  	secondaire  	   *|
 \*-----------------------*/

/**
 * override
 */
double AddVectorTristream::getInputGO()
    {
    return ((long)2 * (long)n * (long)sizeof(half)) / (double)((long)1024 * (long)1024 * (long)1024);
    }

/**
 * override
 */
double AddVectorTristream::getOutputGO()
    {
    return ((long)1 * (long)n * (long)sizeof(half)) / (double)((long)1024 * (long)1024 * (long)1024);
    }

string AddVectorTristream::title(int nbSlice)
    {
    if (VectorTools::isDMA())
	{
	return "Addvector-tristream-slice" + to_string(nbSlice) + "-DMA-int";
	}
    else
	{
	return "Addvector-tristream-slice" + to_string(nbSlice) + "-DMA-int";
	}
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
