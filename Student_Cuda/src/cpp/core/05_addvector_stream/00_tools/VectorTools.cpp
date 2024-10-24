#include <iostream>
#include <math.h>
#include <assert.h>

#include "VectorTools.h"
#include "HM.h"
#include "Limits.h"

using std::cout;
using std::endl;

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/**
 * Contrainte	n % nbSlice = 0
 */
int VectorTools::n()
    {
    // Pour le warmup, activer la ligne requise ci-dessous:

   // return nWarmup_3_slices();
    //return nWarmup_4_slices();
    //return nWarmup_5_slices();

    // pour le cas generique,activer une des deux lignes  ci-dessous:

    return nGenerique1();
    //return nGenerique2();
    }

/**
 * Exemple de possiblity pour le nombre de slice possible avec ce n :
 *
 * 	Exemple 1:  #slice in [2,15]
 *  	Exemple 2:  #slice in [5,75] par pas de 5
 */
int VectorTools::nGenerique1()
    {
    const int N = 2 * 3 * 4 * 5 * 7 * 9 * 11 * 13 * 5; // apres trop grand
    // 8  remove car 2*4
    // 10 remove car 2*5
    // 12 remove car 3*4
    // 15 remove car 3*5

    check_nGenerique1(N);

    return N;
    }

/**
 * Exemple de possiblity pour le nombre de slice possible avec ce n :
 *
 * 	Exemple 1:  #slice  10 20 30 40 50
 *  	Exemple 2 : #slice  10 100 1000 10000 20000 30000 40000 50000
 */
int VectorTools::nGenerique2()
    {
    const int N = 2 * 3 * 4 * 5 * 10 * 10 * 10 * 10 * 2;
    return N;
    }

/**
 * static
 */
void VectorTools::check_nGenerique1(int N)
    {
    //cout << N << endl;

    assert(N >= 3);
    assert(N <= Limits::MAX_INT);

    for (int i = 2; i <= 15; i++)
	{
	//cout << i << endl;
	assert(N % i == 0); // pour pouvoir faire varier le nombre de slice entre [3,nbSliceMax()]
	}

    for (int i = 5; i <= 75; i += 5)
	{
	//cout << i << endl;
	assert(N % i == 0); // pour pouvoir faire varier le nombre de slice par pas de 5 dans [0,60]
	}
    }

/*--------------------------------------*\
 |*		warmup			*|
 \*-------------------------------------*/

int VectorTools::nWarmup_3_slices()
    {
    return 6; // doit etre divisible par 3
    }

int VectorTools::nWarmup_4_slices()
    {
    return 8; // doit etre divisible par 4
    }

int VectorTools::nWarmup_5_slices()
    {
    return 10; // doit etre divisible par 10
    }

/*--------------------------------------*\
 |*		MM			*|
 \*-------------------------------------*/

static bool IS_MEMORY_DMA = true; // TODO  changer a false pour voir la difference (bandepassante H2D et D2H afficher dans la console)

bool VectorTools::isDMA()
    {
    return IS_MEMORY_DMA;
    }

int* VectorTools::create(int n)
    {
    if (!IS_MEMORY_DMA)
	{
	return new int[n];
	}
    else
	{
	int* ptr;
	HM::malloc(&ptr, n * sizeof(int));
	return ptr;
	}
    }

void VectorTools::free(int* ptrV)
    {
    if (!IS_MEMORY_DMA)
	{
	delete[] ptrV;
	}
    else
	{
	HM::free(ptrV);
	}
    }

/*--------------------------------------*\
|*		Vector			*|
 \*-------------------------------------*/

int* VectorTools::createV1(int n)
    {
    int* ptrV = VectorTools::create(n);

    for (int i = 0; i < n; i++)
	{
	ptrV[i] = i;
	}

    return ptrV;
    }

int* VectorTools::createV2(int n)
    {
    int* ptrV = VectorTools::create(n);

    for (int i = 0; i < n; i++)
	{
	ptrV[i] = i * 10;
	}

    return ptrV;
    }

void VectorTools::print(int* ptrV , int n)
    {
    cout << endl;
    for (int i = 0; i < n; i++)
	{
	cout << ptrV[i] << "\t";
	}
    cout << endl;
    }

bool VectorTools::isAddVector_Ok(int* ptrV1 , int* ptrV2 , int* ptrW , int n)
    {
    for (int i = 0; i < n; i++)
	{
	int delta = ptrW[i] - ptrV1[i] - ptrV2[i];

	if (delta != 0)
	    {
	    return false;
	    }
	}

    return true;
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

