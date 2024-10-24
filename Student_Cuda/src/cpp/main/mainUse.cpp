#include <iostream>
#include <stdlib.h>

using std::cerr;
using std::cout;
using std::endl;

// Tools
#include "Limits.h"
#include "ChronoFactory.h"

// Hello
extern bool addScalar_objet();
extern bool addScalar_procedurale();

// Array
#include "AddArrayUse.h"
#include "AddArrayUse11.h"

// Slice
#include "SliceGmHostUse.h"
#include "SliceGmUse.h"
#include "SliceSmUse.h"

// Montecarlo
#include "MontecarloUse.h"
#include "MontecarloMultiUse_thread.h"
#include "MontecarloMultiUse_stream.h"

// Vector
#include "AddVectorUse.h"
#include "AddVectorBistreamUse.h"
#include "AddVectorTristreamUse.h"
#include "VectorTools.h"

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

int mainUse()
    {
    Chrono* ptrChrono = ChronoFactory::create();

    const int IS_VERBOSE = true;

    // Commenter ce dont vous n'avez pas besoin ci-dessous

    bool isOk = true;

    // hello : addSCalar
	{
	//isOk &= addScalar_procedurale();
	//isOk &= addScalar_objet();
	}

    // AddArray
	{
	// Patern entrelacement
	    {
	    AddArrayUse addArrayUse;
	    isOk &= addArrayUse.isOk();
	    }

	// Patern 11
//	    {
//	    AddArrayUse11 addArrayUse11;
//	    isOk &= addArrayUse11.isOk();
//	    }
	}

    Slice
	{
//	SliceGmHostUse sliceGmHostUse(IS_VERBOSE);
//	SliceGmUse sliceGmUse(IS_VERBOSE);
//	SliceSmUse sliceSmUse(IS_VERBOSE);
//
//	isOk &= sliceGmHostUse.isOk(IS_VERBOSE);
//	isOk &= sliceGmUse.isOk(IS_VERBOSE);
//	isOk &= sliceSmUse.isOk(IS_VERBOSE);
	}

    // Montecarlo
//	{
//	for (float h = 4; h <= 10; h = h + 1)
//	    {
//	    MontecarloUse montecarloUse(IS_VERBOSE, h);
//	    isOk &= montecarloUse.isOk(IS_VERBOSE);
//	    }
//
//	cout << endl;
//
//	for (float h = 4; h <= 10; h = h + 1)
//	    {
//	    MontecarloMultiUse_thread montecarloMultiUse(IS_VERBOSE, h);
//	    isOk &= montecarloMultiUse.isOk(IS_VERBOSE);
//	    }
//
//	cout << endl;
//
//	for (float h = 4; h <= 10; h = h + 1)
//	    {
//	    MontecarloMultiUse_stream montecarloMultiUse(IS_VERBOSE, h);
//	    isOk &= montecarloMultiUse.isOk(IS_VERBOSE);
//	    }
//	}

// Stream addVector
//	{
//	// Base line
//	    {
//	    AddVectorUse addVectorUse(IS_VERBOSE);
//	    isOk &= addVectorUse.isOk(false);
//	    }
//
//	// Bi-stream
//	    {
//	    AddVectorBistreamUse addVectorBistreamUse(IS_VERBOSE);
//	    isOk &= addVectorBistreamUse.isOk(false);
//	    }
//
//	const bool IS_WARMUP = true;
//
//	// Warning :
//	//		 On ne peut pas en meme temps lancer en mode warmup et en mode generic.
//	//		 D'abord on valide completement le mode warmup (les 3) puis apres on attaque le mode generic.
//	//		 Une fois le mode generic fonctionel, le mode warmup n'est plus tres utile.
//	//		 Il nous a juste permis de contruire le mode generic
//	//		 Sauf erreur, les tests unitaires ne sont coder que pour le cas generique.
//
//	if (IS_WARMUP)  // Tri-stream : warmup 3 4 5  slices
//	    {
//	    // Warning :
//	    //		(W0) Le code warump doit etre activer dans votre implementation soit pour 3 4 ou 5 slices
//	    //		(W1) Le true  ci-dessous implique un affichage dans la console
//	    //		(W2) Dans ce cas il serait bien que  VectorTools:n() soit petit
//	    //		(W3) Changer le provisoirement
//	    //		(W4) Ce n doit etre divisible par nbSlice
//	    //		(W5) Il faut donc changer le code a 4 endroits differents
//	    //				ICI : nbSlice
//	    //				ICI : IS_WARMUP
//	    //				VectorToos.n()
//	    //				void AddVectorTristream::run()
//
//	    int nbSlice = 3;
//	    // int nbSlice = 4;
//	    // int nbSlice = 5;
//
//	    AddVectorTristreamUse addVectorTristreamUse(nbSlice, true); // true implique un affichage dans la console
//	    bool isOkSlice = addVectorTristreamUse.isOk(!false);
//	    cout << nbSlice << "\t" << isOkSlice << endl;
//
//	    isOk &= isOkSlice;
//	    }
//	else // Tri-stream (generic)	: Warning : le code generic doit etre activer dans votre implementation
//	    {
//	    // Use1
//		{
//		for (int nbSlice = 3; nbSlice <= 15; nbSlice++)
//		    {
//		    AddVectorTristreamUse addVectorTristreamUse(nbSlice, IS_VERBOSE);
//		    bool isOkSlice = addVectorTristreamUse.isOk(false);
//		    //cout << nbSlice << "\t" << isOkSlice << endl;
//
//		    isOk &= isOkSlice;
//		    }
//		}
//
//	    // Use2
//		{
//		for (int nbSlice = 5; nbSlice <= 75; nbSlice += 5)
//		    {
//		    AddVectorTristreamUse addVectorTristreamUse(nbSlice, IS_VERBOSE);
//		    bool isOkSlice = addVectorTristreamUse.isOk(false);
//		    // cout << nbSlice << "\t" << isOkSlice << endl;
//
//		    isOk &= isOkSlice;
//		    }
//		}
//	    }
//	} // fin stream

    ptrChrono->stop();

    cout << endl << endl;
    cout << "mainCore :" << *ptrChrono << endl;
    cout << "mainCore : ";
    if (isOk)
	{
	cout << "SUCCESS, Congratulation!";
	}
    else
	{
	cerr << "FAILED, sorry!";
	}
    cout << endl << endl;

    delete ptrChrono;

    return isOk ? EXIT_SUCCESS : EXIT_FAILURE;
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

