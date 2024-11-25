#pragma once

#include <math.h>
#include <cuda_fp16.h>

#include "real.h"
#include "Maths.h"

#include "Colors.cu.h"

#include "DomaineMath.h"

/*--------------------------------------*\
 |*		Helper type		*|
 \*-------------------------------------*/

#ifdef MANDELBROT_HALF
#define DEUX (half)2
#define QUATRE (half)4
#define ZERO (half)0
#endif

#ifdef MANDELBROT_FLOAT
#define DEUX 2.f
#define QUATRE 4.f
#define ZERO 0.f
#endif

#ifdef MANDELBROT_DOUBLE
#define DEUX 2.0
#define QUATRE 4.0
#define ZERO 0.0
#endif

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

class MandelbrotMath
    {
	/*--------------------------------------*\
	|*		Constructeur		*|
	 \*-------------------------------------*/

    public:

	__device__ MandelbrotMath(int n)
	    {
	    // n(n);
	     this->n = n;
	    }

	__device__
	     virtual ~MandelbrotMath(void)
	    {
	    // rien
	    }

	/*--------------------------------------*\
	|*		Methode			*|
	 \*-------------------------------------*/

    public:

	__device__
	void colorXY(uchar4* ptrColorIJ , real x , real y)
	    {
	    // TODO Mandelbrot GPU

	    // Calculer la suite en (x,y) et recuperer l'indice d'arret de la suite
	    // Colorier : 	Il faut convertir l'indice d'arret en une hue01!
	    //			Calcul dans quel type? float

	    // Conseil:
	    // 		Etape 1 : 	Commencer par afficher une image uniforme grise (128 par exemple)
	    // 				pour valider tout le pipeline en amont
	    //
	    // 		Etape 2:	Puis une fois que l'image grise est valider, attaquer montecarlo

	    // debug temp
	    //		{
	    //		ptrColorIJ->x = 128;
	    //		ptrColorIJ->y = 128;
	    //		ptrColorIJ->z = 128;
	    //		ptrColorIJ->w = 255; // opacity facultatif
	    //		}

	    // Etape 1 : 	Commencer par afficher une image uniforme grise (128 par exemple)

	    // ptrColorIJ->x = 128;
	    // ptrColorIJ->y = 128;
	    // ptrColorIJ->z = 128;
	    // ptrColorIJ->w = 255;

	    // Étape 2 : (à décommenter une fois l'image grise validée)
	    // Si indiceArret est égal au nombre maximal d'itérations, le point est considéré comme appartenant à l'ensemble de Mandelbrot

	    int indiceArret = suite(x, y);
	    if (indiceArret == n)
	    {

	        ptrColorIJ->x = 0;
	        ptrColorIJ->y = 0;
	        ptrColorIJ->z = 0;
	        ptrColorIJ->w = 255;
	    }
	    else
	    {

		float hue01 = indiceArret / (float)n;

	        Colors::HSB_TO_RVB(hue01, ptrColorIJ);


	        ptrColorIJ->w = 255;
	    }
	    }

    private:

	/**
	 * Warning: define real in real.h (real=float or real=double or real= half)
	 */
	__inline__
	__device__
	int suite(real x , real y)
	    {
	    // TODO Mandelbrot GPU

	    // Utiliser dans vos formules les variable :
	    //
	    //		DEUX
	    //		QUATRE
	    //		ZERO
	    //
	    // definit au debut de ce fichier. Est-utile pour  passer facilement d'une version fp64 (double) fp32(float) fp16(half)


	    real a = ZERO;
	    real b = ZERO;
	    real a2 = ZERO;
	    real b2 = ZERO;
	    int k = 0;


	    while (k < n && (a2 + b2) <= QUATRE) // tant que k inférieur au nombre maximal d'itération et que la suite converge
		{
		    real aCopy = a;
		    a = a2 - b2 + x;
		    b = DEUX * aCopy * b + y;


		    a2 = a * a;
		    b2 = b * b;

		    k++; // Incrémentation de l'indice d'itération
		}

	    return k;
	    }
	//
	// Risque:
	//
	// 	Un des risque est de faire une boucle infinie
	//
	// Analyse:
	//
	// 	Comme il n'y pas de ecran physiquement brancher sur le serveur, les kernels n'ont pas de timeout
	// 	Le kernel n'est donc pas stopper apres les 2 secondes de timeout par defaut
	// 	Vous avez donc un risque de laisser le serveur inutilisable pour les autres utilisateus de la machine
	//
	// Consequence:
	//
	// 	Checker bien votre code avant de le lancer
	//
	// 	Arreter bien votre processus:
	//		- carrer rouge eclipse
	//		- linux_kill_cuda (dans la trousse a outil d'exlipse)
	//		- a la racine du projet : cbicc cuda kill
	//
	// 	Verifier avec :
	//		htop 				que votre processus est bien detruit  (filter .run)
	//		nvidia-smi --loop=1		que vous n'employez plus le gpu
	//
	// 	Sinon il y a de grandes chances qu'il faille redemarer le server et les autres utilisateurs de la machine ne vont pas etre content.
	//
	// Info:
	//
	//	On peut tester l etat du serveur (pipeline de rendu openGL) via
	//
	//		gl glxgears
	//
	//	Si la fenetre mais du temps a s'ouvrir . c'est pas bon signe
	//	Si elle ne s'ouvre pas, je dois redemarer le server

	/*--------------------------------------*\
	|*		Attribut		*|
	 \*-------------------------------------*/

    private:

	int n;

    };

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
