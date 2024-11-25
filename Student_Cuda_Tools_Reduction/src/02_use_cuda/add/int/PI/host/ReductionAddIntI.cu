#include "ReductionAddIntI.h"

#include "GM.h"
#include "Grid.h"

#include <iostream>
#include <assert.h>

using std::cout;
using std::endl;
using std::to_string;

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Imported	 	*|
 \*-------------------------------------*/

extern __global__ void KAddIntProtocoleI(int* ptrSumGM);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Constructeur			*|
 \*-------------------------------------*/

ReductionAddIntI::ReductionAddIntI(const Grid& grid , int* ptrSum , bool isVerbose) :
	RunnableGPU(grid, "ReductionAddIntI-" + to_string(grid.threadCounts()), isVerbose), // classe parente
	ptrSum(ptrSum)
    {
    // TODO ReductionAddIntI
    // MM pour ptrSumGM (oubliez pas initialisation)
    this->sizeSM = sizeof(int)*grid.threadByBlock();

    // Tip:  Il y a une methode dedier pour malloquer un int cote device et l'initialiser a zero
    //
    //		GM::mallocInt0(&ptrSumGM);
    GM::mallocInt0(&ptrSumGM);
    }

ReductionAddIntI::~ReductionAddIntI()
    {
    // TODO ReductionAddIntI
    GM::free(ptrSumGM);
    }

/*--------------------------------------*\
 |*		Methode			*|
 \*-------------------------------------*/

void ReductionAddIntI::run()
    {
    // TODO ReductionAddIntI
    // appeler le kernel
    // recuperer le resulat coter host

    // Tip:  Il y a une methode dedier ramener coter host un int
    //
    //		GM::memcpyDtoH_int(ptrDestination, ptrSourceGM);


    KAddIntProtocoleI<<<grid.dg,grid.db, sizeSM >>>(ptrSumGM);
    GM::memcpyDToH_int(ptrSum, ptrSumGM);
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
