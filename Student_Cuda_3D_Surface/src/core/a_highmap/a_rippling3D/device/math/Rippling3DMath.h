#pragma once

#include "cudas.h"

#include <math.h>

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

class Rippling3DMath
    {

	/*--------------------------------------*\
	|*		Constructor		*|
	 \*-------------------------------------*/

    public:

	__device__ Rippling3DMath(uint w , uint h , float t) :
		dim2(w >>1), //
		t(t)
	    {
	    // rien
	    }

	/*--------------------------------------*\
	|*		Methodes		*|
	 \*-------------------------------------*/

    public:

	/**
	 * <pre>
	 * Par rapport a la version 2D, on calcule ici le niveau de gris en float et non en uchar.
	 * ce niveau de gris est ensuite utiliser pour:
	 * 		- la hauteur en float
	 * 		- la couleur une fois caste en uchar
	 * </pre>
	 */
	__device__
	void xyz(uchar4* ptrColorIJGM , float3* ptrSommetXYZGM , int i , int j)
	    {
	    // on calcul levelGray qu une seule fois, puis on l'utilise pour :
	    //	- la "couleur"
	    //	- la hauteur

	    float levelGrayFloat0255 = levelGray(i, j); // car la surface sera plus "lisse" en float qu'en uchar et z peut etre en float.
	    uchar levelGris = static_cast<uchar>(levelGrayFloat0255);

	    ptrColorIJGM->x = levelGris;
	    ptrColorIJGM->y = levelGris;
	    ptrColorIJGM->z = levelGris;

	    ptrColorIJGM->w = 255;


	    // color
		{
		uchar levelGris = (uchar)levelGrayFloat0255; // car la couleur est en uchar

		// Indication:
		//	(I1)	Utiliser i et j pour obtenir x et y
		//
		// Warning :
		//	(W1)	i est sur l'axe y, i est y, presque
		//	(W2)	j est sur l'aye x, j est x, presque
		//	(W3)	Pour que le centre de graviter de la forme soit au centre de "l ecran", et pour pouvoir
		//		tourner avec la souris autour du centre de gravite:
		//			- decaler de dim2 sur l'axe des x
		//			- decaler de dim2 sur l'axe des y

		// TODO RIPPLING 3D


		}

	    // sommet (float3 est une structure a 3 champs x y et z (3 float)
		{
		// Indication : pour la hauteur z utiliser 6 x levelGrayFloat0255s (plus joli)

		// TODO RIPPLING 3D
		ptrSommetXYZGM->x = j - dim2;
		ptrSommetXYZGM->y = i - dim2;
		ptrSommetXYZGM->z = 3.0f * levelGrayFloat0255;
		}
	    }

    private:

	/*---------------------*\
	|*	level gray	*|
	 \*--------------------*/

	__inline__
	__device__
	float levelGray(int i , int j ) // en float in [0,255]
	    {
	    // TODO RIPPLING 3D

	    float result;
	    dij(i, j, &result); // warning : dij return void. Ne peut pas etre "imbriquer dans une fonction"

	    result = result / 10.f;
	    // TODO Rippling GPU : cf formules math rippling.pdf
	    float nume = cosf(result -t/7);
	    float denum = result+1;
	    // *ptrLevelGray = 128 + 127*(nume/denum);
	    return 128.0f + 127.0f * (nume / denum);

	    // return -1;
	    }

	__inline__
	__device__
	void dij(int i , int j, float* ptrResult )
	    {
	    // TODO RIPPLING 3D

	    // float fi;
	    // float fj;
	    // fi = i-dim2;
	    // fj = j-dim2;
	    // *ptrResult = sqrt(fi*fi + fj*fj);

	    float fi = i - dim2;
	    float fj = j - dim2;
	    *ptrResult = sqrtf(fi * fi + fj * fj);

	    }

	/*--------------------------------------*\
	|*		Attributs		*|
	 \*-------------------------------------*/

    private:

	// Input
	float t;

	// Tools
	int dim2;	    // dim2=dim/2

    };

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
