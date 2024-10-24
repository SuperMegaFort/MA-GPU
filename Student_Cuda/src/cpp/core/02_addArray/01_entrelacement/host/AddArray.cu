#include "AddArray.h"

#include <iostream>
#include <assert.h>

#include "Kernel.h"
#include "GM.h"
#include "VectorTools.h"

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

extern __global__ void addArray(float* ptrGMV1 , float* ptrGMV2 , float* ptrGMW , int n);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Constructeur			*|
 \*-------------------------------------*/

AddArray::AddArray(const Grid& grid , float* ptrV1 , float* ptrV2 , float* ptrW , int n) :
	ptrV1(ptrV1), //
	ptrV2(ptrV2), //
	ptrW(ptrW), //
	n(n), //
	dg(grid.dg), //
	db(grid.db)
    {
    this->sizeVector = n*sizeof(float); // TODO addArray // octet


    // MM (malloc Device)
	{
	GM::malloc(&ptrGMV1, sizeVector);
	GM::malloc(&ptrGMV2, sizeVector);
	GM::malloc(&ptrGMW, sizeVector);
	// TODO addArray
	}

    }

AddArray::~AddArray(void)
    {
    //MM (device free)
	{
	GM::free(ptrGMV1);
	GM::free(ptrGMV2);
	GM::free(ptrGMW);


	// TODO addArray
	}
    }

/*--------------------------------------*\
 |*		Methode			*|
 \*-------------------------------------*/

/**
 * override
 */
void AddArray::run()
    {
    // MM (copy Host->Device)
	{
	GM::memcpyHToD(ptrGMV1, ptrV1, sizeVector);
	GM::memcpyHToD(ptrGMV2, ptrV2, sizeVector);

	// TODO addArray
	}

    // TODO addArray // call kernel // assynchrone
	addArray<<<dg,db>>>(ptrGMV1, ptrGMV2, ptrGMW, n);

    //Kernel::synchronize();// inutile

    // MM (Device -> Host)
	{
	// TODO addArray // MM barier de synchronisation implicite
	GM::memcpyDToH(ptrW, ptrGMW, sizeVector);
	}
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
