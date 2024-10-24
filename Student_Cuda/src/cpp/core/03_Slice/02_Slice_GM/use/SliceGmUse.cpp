#include "SliceGmUse.h"

#include "SliceGM.h"
#include "SliceNumber.h"

#include "Maths.h"
#include "Hardware.h"

#include <iostream>
#include <iomanip>
#include <assert.h>

using std::cerr;
using std::cout;
using std::endl;
using std::string;
using std::to_string;
using std::setprecision;

/*--------------------------------------*\
 |*		Imported		*|
 \*-------------------------------------*/

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Constructeurs		*|
 \*-------------------------------------*/

/**
 * contrainte : grid (dg et db) une puissance de 2
 */
SliceGmUse::SliceGmUse(const Grid& grid , bool isVerbose) : //
	grid(grid), //
	nbSlice(SliceNumber::nbSlice()), //
	piHat(-1)
    {
    this->ptrRunnableGPU = new SliceGM(grid, this->nbSlice, &piHat, isVerbose);

    assert(filter(grid));
    }

SliceGmUse::SliceGmUse(bool isVerbose) : //
	SliceGmUse(createGrid(), isVerbose)
    {
    //rien
    }

SliceGmUse::~SliceGmUse()
    {
    delete ptrRunnableGPU;
    }

/*--------------------------------------*\
|*		Methodes		*|
 \*-------------------------------------*/

/**
 * override
 */
bool SliceGmUse::filter(const Grid& grid)
    {
    return Use_I::filter(grid) //
    && Maths::isPower2(grid.threadCounts());
    }

/*--------------*\
|*	isOk	*|
 \*-------------*/

/**
 * Override
 */
bool SliceGmUse::isOk(bool isVerbose)
    {
    this->ptrRunnableGPU->run();

    bool isOk = Maths::isEquals(piHat, PI, 1e-2); // Si certains de vos tests unitaires manquent de precision, passer a 1e-2 (non associtaivite de l'addition)

    if (isVerbose)
	{
	string title = "[" + ptrRunnableGPU->getTitle() + "]";
	cout << setprecision(4);
	cout << endl;
	cout << title << " : PI hat = " << piHat << endl;
	cout << title << " : PI     = " << PI << endl;
	cout << title << " : ";

	if (isOk)
	    {
	    cout << "Success!" << endl;
	    }
	else
	    {
	    cerr << "Failed!" << endl;
	    }
	}
    return isOk;
    }

/*--------------*\
|*	get	*|
 \*-------------*/

/**
 * override
 * Warning : It's a getter, the user is not responsible for deleting RunnableGPU_I*
 */
RunnableGPU_I* SliceGmUse::getRunnableGPU()
    {
    return this->ptrRunnableGPU;
    }

/*--------------------------------------*\
|*		Private			*|
 \*-------------------------------------*/

/**
 * static
 */
Grid SliceGmUse::createGrid()
    {
    const bool IS_CHECK_HEURISTIC = false;

    // Contraintes :
    //	(C1) max(db.x*db.y*db.z)<=1024
    //	(C2) dg power 2 (reduction)
    //	(C3) db power 2 (reduction)

    // Indications:
    //		(I1)	 Y a t'il une contrainte a respecter?
    //		(I2)	 Quel est l'heuristic a suivre pour db?
    //		(I3)	 Quel est l'heuristic a suivre pour dg?
    //		(I4)	 Peux t'on respecter la contrainte et les deux heuristics?

    dim3 dg;// TODO SliceGM
    dim3 db;// TODO SliceGM
    Grid grid(dg,db,IS_CHECK_HEURISTIC);

    assert(false); // to remove once coded

    return grid;
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
