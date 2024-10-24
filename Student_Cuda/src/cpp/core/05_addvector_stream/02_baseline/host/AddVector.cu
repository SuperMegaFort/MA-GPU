#include "AddVector.h"

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

AddVector::AddVector(const Grid& grid , int* ptrV1 , int* ptrV2 , int* ptrW , int n , bool isVerbose) :
	RunnableGPU(grid, title() + "-" + to_string(n), isVerbose), // classe parente
	//
	ptrV1(ptrV1), //
	ptrV2(ptrV2), //
	ptrW(ptrW), //
	n(n)
    {
    this->sizeVector = n * sizeof(int); // octet

    // MM (malloc Device)
	{
	GM::malloc(&ptrGMV1, sizeVector);
	GM::malloc(&ptrGMV2, sizeVector);
	GM::malloc(&ptrGMW, sizeVector);
	}

    }

AddVector::~AddVector(void)
    {
    //MM (device free)
	{
	GM::free(ptrGMV1);
	GM::free(ptrGMV2);
	GM::free(ptrGMW);
	}
    }

/*--------------------------------------*\
 |*		Methode			*|
 \*-------------------------------------*/

/**
 * override
 */
void AddVector::run()
    {
    // MM (copy Host->Device)
	{
	Bandwidth bandwidth(sizeVector * 2, "[" + title() + "] : Host -> GM :");

	GM::memcpyHToD(ptrGMV1, ptrV1, sizeVector);
	GM::memcpyHToD(ptrGMV2, ptrV2, sizeVector);

	if (isVerbose) // dans Runable ou RunnableGPU
	    {
	    cout << bandwidth << endl;
	    }
	}

    // call kernel
	{
    addVector<<<dg,db>>>(ptrGMV1, ptrGMV2, ptrGMW, n);	// assynchrone
    }

// MM (Device -> Host)
    {
    Bandwidth bandwidth(sizeVector, "[" + title() + "] : GM -> Host :");

    GM::memcpyDToH(ptrW, ptrGMW, sizeVector);

    if (isVerbose)
	{
	cout << bandwidth << endl;
	}
    }
}

/**
 * override
 */
double AddVector::getInputGO()
{
return ((long)2 * (long)n * (long)sizeof(half)) / (double)((long)1024 * (long)1024 * (long)1024);
}

/**
 * override
 */
double AddVector::getOutputGO()
{
return ((long)1 * (long)n * (long)sizeof(half)) / (double)((long)1024 * (long)1024 * (long)1024);
}

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

string AddVector::title()
{
if (VectorTools::isDMA())
    {
    return "Addvector-DMA-int";
    }
else
    {
    return "Addvector-int";
    }
}

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
