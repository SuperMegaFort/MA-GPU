#include "Thread2D.cu.h"
#include "Thread1D.cu.h"
#include "cudas.h"
#include "Limits.h"

/*----------------------------------------------------------------------*\
 |*			Declaration					*|
 \*---------------------------------------------------------------------*/

/*--------------------------*\
 |*	private		     *|
 \*-------------------------*/

#include "losetime.cu.h"

static __device__ void processS(int* ptrGmSlice1 , int* ptrDevV2 , int* ptrGmSliceW , int sLocalSlice);

/*----------------------------------------------------------------------*\
 |*			Implementation					*|
 \*---------------------------------------------------------------------*/

/**
 * <pre>
 * Inputs:
 * 	- ptrGmSlice1 : pointeur sur la slice du vecteur1
 * 	- ptrGmSlice2 : pointeur sur la slice du vecteur2
 * 	- ptrGmSlicew : pointeur sur la slice du vecteur resultat w
 *
 * 	- n_by_slice  : le nombre d'element dans une slice
 * 	- sid	      : l'index de slice in [0,nbSlice[		(Pas used ici)
 *
 *
 * Note:
 * 	Ce meme kernel sera utiliser pour nos 3 versions:
 * 		- baseline (sans stream, ou stream unique)
 * 		- bistream (bislice)
 * 		- tristram
 *
 * 	Version baseline (sans stream)
 * 		- ptrGmSlice1 = ptrGMV1	  pointeur sur le debut du vecteur complet v1
 * 		- n_by_slice  = n 	  le nombre d'element total du vecteur
 * 		- sid         = 0	  unique slice, la slice est le vecteur complet
 *
 *   	Version bistream (bislice)
 * 		- ptrGmSlice1 = 	  pointeur sur le debut d'une des slices du vecteur v1
 * 		- n_by_slice  = 	  le nombre d'element d'une slice
 * 		- sid         = 0 ou 1	  selon si on travailler la slice 0 ou la slice 1
 *
 *   	Version tristream
 * 		- ptrGmSlice1 = ptrGMV1	   pointeur sur le debut d'une des slices du vecteur v1
 * 		- n_by_slice  = n 	   le nombre d'element d'une slice
 * 		- sid      		   le slice index

 * </pre>
 */
__global__ void addVector(int* ptrGmSlice1 , int* ptrGmSlice2 , int* ptrGmSliceW , int n_by_slice , int sid = 0)
    {
    //  Indications:
    //	   (I1) Entrelacement sur le slice et uniquement sle slice
    //	   (I2) Aidez vous ensuite de la fonction secondaire processS ci-dessous

    // TODO stream

    // int sGlobal = sLocalSlice + (sid * n_by_slice); // global au vecteur en partant du debut, pas used ici, car on a deja un pointeur sur le debut de la slice
    }

/*--------------------------*\
 |*	private		     *|
 \*-------------------------*/

/**
 * calcul le resultat de la case sLocalSlice in [0,n_by_slice[ de la slice "courante"
 */
__device__ void processS(int* ptrGmSlice1 , int* ptrGmSlice2 , int* ptrGmSliceW , int sLocalSlice)
    {
    // Indications:
    //	(1) additioner la composante s:	u=v1(s)+v2(s)  (avec s= LocalSlice)
    //	(2) appeler loseTime sur u, loseTime ne modifie pas u,loseTime est un fonction identity
    //	(3) le resultat final est loseTime(u), ie la cases s additionner, mais avec une perte de temps
    //
    //	 		resultatS=loseTime(u)

    // TODO stream

    // TIPS : pour debuguer, mettez au début:
    //
    //		ptrGmSliceW[s]=sGlobal;
    //
    //	Si vous avez un bug, ca permetra de savoir si ca vient du host ou du device

    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

