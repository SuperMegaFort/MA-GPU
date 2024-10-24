#include "AddVectorBistream.h"

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

AddVectorBistream::AddVectorBistream(const Grid& grid , int* ptrV1 , int* ptrV2 , int* ptrW , int n , bool isVerbose) :
	RunnableGPU(grid, title() + "-" + to_string(n), isVerbose), // classe parente
	//
	ptrV1(ptrV1), //
	ptrV2(ptrV2), //
	ptrW(ptrW), //
	n(n), //
	isStreamDefaultUse(false)
    {
    assert(n % 2 == 0);

    this->sizeVector = n * sizeof(int); // octet

    // MM (malloc Device)
	{
	GM::malloc(&ptrGMV1, sizeVector);
	GM::malloc(&ptrGMV2, sizeVector);
	GM::malloc(&ptrGMW, sizeVector);
	}

    // Stream
	{
	// TODO stream, see attribute in .h
	assert(false);
	}
    }

AddVectorBistream::~AddVectorBistream(void)
    {
    //MM (device free)
	{
	GM::free(ptrGMV1);
	GM::free(ptrGMV2);
	GM::free(ptrGMW);
	}

    // Stream
	{
	// TODO stream
	}
    }

/*--------------------------------------*\
 |*		Methode			*|
 \*-------------------------------------*/

/**
/**
 * override
 */
void AddVectorBistream::run()
    {
    const int MIDLE = n >> 1; // n/2
    const size_t MIDLE_SIZE = sizeVector >> 1; // sizeVector/2

    // Step 1:
	{
	// TODO stream see schema in pdf
	// stream0 : copieHtoD  slice0

	Stream::synchronize(stream0);
	}

    // Step 2:
	{
	// TODO stream see schema in pdf
	// stream1 : copieHtoD  slice1
	// stream0 : kernel     slice0
	// Warning : il faut lancer le kernel sur une slice!, pas sur tout le veteur!
	//	(W1)	Attention a la dimension a donner
	//	(W2)	Attention au sliceIndex,  ie 0
	}

    // Step 3:
	{
	// TODO stream see schema in pdf
	// stream0 : copieDtoH   slice0
	// stream1 : kernel      slice1
	// Warning : il faut lancer le kernel sur la slice1, pas sur tout le veteur!
	//	(W1)	Attention a la dimension a donner, ie le nombre de case de la slice, ie MIDLE
	//	(W2) 	Attention au sliceIndex, ie 1
	//	(W3)	Attention a  l'arithmetic des pointeurs!
	//		on veut travailler non pas sur:
	//				ptrGMV1
	//				ptrGMV2
	//				ptrGMVW
	//		mais sur :
	//				ptrGMV1+MIDLE
	//				ptrGMV2+MIDLE
	//				ptrGMVW+MIDLE
	}

    // Step 4:
	{
	// TODO stream see schema in pdf
	// stream1 : copieDtoH      slice1
	}

    // Synchronize
	{
	// v1 : best
	    {
	    Stream::synchronize(stream0);
	    Stream::synchronize(stream1);
	    }

	// v2 :bad (au cas ou d'autre TP sont lancer en meme temps
	//Stream::synchronize();
	}
    }

/*--------------------------------------*\
 |*		secondaire		*|
 \*-------------------------------------*/

/**
 * override
 */
double AddVectorBistream::getInputGO()
    {
    return ((long)2 * (long)n * (long)sizeof(half)) / (double)((long)1024 * (long)1024 * (long)1024);
    }

/**
 * override
 */
double AddVectorBistream::getOutputGO()
    {
    return ((long)1 * (long)n * (long)sizeof(half)) / (double)((long)1024 * (long)1024 * (long)1024);
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

string AddVectorBistream::title()
    {
    if (VectorTools::isDMA())
	{
	return "Addvector-bistream-DMA-int";
	}
    else
	{
	return "Addvector-bistream-int";
	}
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
