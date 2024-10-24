#include "cudas.h"
#include "Limits.h"

/*----------------------------------------------------------------------*\
 |*			Declaration					*|
 \*---------------------------------------------------------------------*/

static __device__ int loseTime(int u);
static __device__ int inc(int t);

/*----------------------------------------------------------------------*\
 |*			Implementation					*|
 \*---------------------------------------------------------------------*/

/**
 * Quoi:
 *
 * 	Fonction identity
 * but :
 *
 * 	 Ralentir pour le temps de kernel ne soit pas trop petit, et montrer l'interet des streams dans ce cas
 *
 * Piege:
 *
 * 	nvcc supprime les codes morts.
 * 	Pour que losetime ne soit pas un code mort, on emploie la variable resultat que l'on doit renvoyer cote host.
 * 	On modifie cette varaible, mais on s'arrange pour retomber sur nos pas a la fin
 *
 * Note1:
 *
 * 	loseTime et un Fonction identity
 *
 * 		u -> perdre du temps avec u -> u
 * Note2:
 * 	Le but du du TP est d'apprendre les streams, et non de devoir implementer un algorithme compliquer cote device.
 * 	addVector est simple a coder cote device, mais on a pas besoin d'un gpu pour additionner deux vecteurs, un cpu
 * 	fait ca tres bien et certainment en moins de temps que la copie des datas sur le device. On cree ici artificiellement
 * 	un interet a l'activite avec la fonction losetime.
 */
__device__ int loseTime(int u)
    {
    // Plus le GPU est performant plus il faut prendre grand
    const int N = 300; // chercher speed up de 2.1

    long uu=u;
    int t = 0;

    while (t < N)
	{
	t++;

	uu = uu +inc(t);
	}

    while(t>=1)
	{
	uu = uu - inc(t);

	t--;
	}

    return (int)uu;
    }

/*----------------------------------------------------------------------*\
 |*			Secondaire					*|
 \*---------------------------------------------------------------------*/

__device__ int inc(int t)
    {
    float a = t;

    //int inc = round(cosf(a) * cosf(a) + sinf(a) * sinf(a)); // 1
    int inc = __float2int_rn(cosf(a) * cosf(a) + sinf(a) * sinf(a)); // 1

    return inc;
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

