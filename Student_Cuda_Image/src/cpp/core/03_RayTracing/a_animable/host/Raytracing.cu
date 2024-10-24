#include "Raytracing.h"

#include <iostream>

#include "MM.h"
#include "GM.h"
#include <assert.h>
#include "SphereCreator.h"
#include "nbSphere.h"
#include "Bandwidth.h"
#include "ChronoFactory.h"

using std::cout;
using std::endl;
using std::string;

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Imported	 	*|
 \*-------------------------------------*/

__global__ void kernelRaytacingGM(uchar4* tabPixelsGM , uint w , uint h , float t , Sphere* tabSpheresGM , int nbSpheres);
__global__ void kernelRaytacingSM(uchar4* tabPixelsGM , uint w , uint h , float t , Sphere* tabSpheresGM , int nbSpheres);
__global__ void kernelRaytacingCM(uchar4* tabPixelsGM , uint w , uint h , float t , int nbSpheres);
__global__ void kernelRaytacingCM2SM(uchar4* tabPixelsGM , uint w , uint h , float t , int nbSpheres);

__host__ void uploadToCM(Sphere* tabSpheres , int nbSpheres);

/*--------------------------------------*\
 |*		Imported	 	*|
 \*-------------------------------------*/

static string titre(const MemoryType& memoryType);

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Constructeur		*|
 \*-------------------------------------*/

Raytracing::Raytracing(const Grid& grid , uint w , uint h , float dt , bool isVerbose , int nbSpheres , const MemoryType& memoryType) :
	Animable_I<uchar4>(grid, w, h, titre(memoryType), isVerbose), // super classe
	memoryType(memoryType), //
	dt(dt), //
	nbSpheres(nbSpheres)
    {
    // Tools
    this->sizeSpheres = nbSpheres * sizeof(Sphere);
    this->t = 0;

    // spheres
	{
	Chrono* ptrChrono = ChronoFactory::create();
	SphereCreator sphereCreator(nbSpheres, w, h);
	ptrChrono->stop();
	if (isVerbose)
	    {
	    cout << "\n[SphereCreator] : " << *ptrChrono << endl;
	    }
	delete ptrChrono;

	uploadToDevice(sphereCreator.getTabSphere());
	} // SphereCreator depiler, donc detruit, tabSphere cote host detruit!
    }

Raytracing::~Raytracing()
    {
    switch (memoryType)
	{
    case GM:
	{
	// TODO  Raytracing  GM
	assert(false);	   // to be removed once implemented

	break;
	}
    case CM:
	{
	// Indication:  Rien a detruire pour la CM
	// Note : 	La duree de vie pour la CM est une duree processus.

	// TODO  Raytracing CM
	assert(false);	   // to be removed once implemented

	break;
	}
    case SM:	// ou GM2SM (synonyme)
	{
	// Indication: 	Rien a detruire pour la SM
	// Note :	La duree de vie pour la SM est une duree de vie de kernel, seulement!
	// Warning: 	Par contre si vous avez eu besoin de GM, il faut détruire la GM

	// TODO  Raytracing SM
	assert(false);	   // to be removed once implemented

	break;
	}
    case CM2SM:
	{
	// TODO  Raytracing  CM2SM
	assert(false);	   // to be removed once implemented

	break;
	}
	}
    }

/*--------------------------------------*\
 |*		Methode			*|
 \*-------------------------------------*/

/**
 * Override
 */
void Raytracing::process(uchar4* tabPixelsGM , uint w , uint h , const DomaineMath& domaineMath)
    {
    switch (memoryType)
	{
    case GM:
	{
	// Indication : Call the kernel kernelRaytacingGM (prototype line 20, about)

	// TODO Raytracing GM
	assert(false);	   // to be removed once implemented

	break;
	}
    case SM: // ou GM2SM (synonyme)
	{
	// TODO Raytracing SM
	assert(false);	   // to be removed once implemented
	break;
	}
    case CM:
	{
	// TODO Raytracing CM
	assert(false);	   // to be removed once implemented
	break;
	}
    case CM2SM:
	{
	 // TODO Raytracing CM_2_SM
	assert(false);	   // to be removed once implemented
	break;
	}
	}
    }

/**
 * Override
 */
void Raytracing::animationStep()
    {
    t += dt;
    }

/**
 * Override
 */
double Raytracing::getInputGO()
    {
    return NB_SPHERE * sizeof(Sphere) / ((double)1024 * (double)1024 * (double)1024);
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

void Raytracing::uploadToDevice(Sphere* tabSpheres)
    {
    Bandwidth bandwidth(sizeSpheres, "\n" + titre(memoryType) + " : Host -> Device :");

    switch (memoryType)
	{
    case GM:
	{
	// But : copier les spheres en GM
	// Indicastions:
	//		(I1) MM pour la GM ( malloc et memcpy)
	// 		(I2) Utiliser la classe GM
	// 		(I3) Regarder bien les attributs de la classe dans le Raytracing.h

	// TODO Raytracing GM uploadToDevice
	assert(false);	   // to be removed once implemented

	break;
	}
    case SM: // ou GM2SM (synonyme)
	{
	// Indications:
	//		(I1) Coter device, on copie GM to SM
	//		(I2) Il faut donc d'abord copier les spheres sur le device!
	//		(I3) Le code est donc le meme que GM

	// TODO Raytracing SM uploadToDevice
	assert(false);	   // to be removed once implemented

	break;
	}
    case CM:
	{
	// But :
	//
	//	Copier les spheres en CM
	//
	// Indications:
	//
	//	(I1) Lisez raytracingCM.cu.h (dans la partie device). Tout est coder.
	//	(I2) Utiliser uploadToCM
	//
	// Notes:
	//
	//	(N1) La CM utilise une variable globale cote device : TAB_SPHERES_CM
	//	(N2) Elle se trouve dans raytracingCM.cu.h (Ligne 12 environ)
	//	(N3) Pour cette raison:
	//			(a) Ce .h est cote device, car ce .h sera inclut cote device dans le fichier du kernel
	//			(b) On a pas acces cote host a TAB_SPHERES_CM
	//			(c) On vous fournit raytracingCM.cu.h qui solutionne tous les problemes
	//	(N4) Le nombre de sphere est defini dans nbSphere.h, qui sera inclut coter host et coter device,
	//	     car on a besoin de connaitre cette quantiter des deux coters


	// TODO Raytracing CM uploadToDevice
	assert(false);	    // to be removed once implemented

	break;
	}
    case CM2SM:
	{
	// Indications:
	//		(I1)Coter device, on copie CM to SM
	//		(I2) Il faut donc d'abord copier les spheres en CM
	//		(I3) Le code est donc le meme que CM

	// TODO uploadToDevice CM2SM ://to be removed once implemented
	assert(false);

	break;
	}
	}

    if (isVerbose)
	{
	cout << endl << bandwidth << endl;
	}
    }

string titre(const MemoryType& memoryType)
    {
    switch (memoryType)
	{
    case GM:
	return "Raytracing-GM-uchar4";

    case SM:
	return "Raytracing-GM2SM-uchar4";

    case CM:
	return "Raytracing-CM-uchar4";

    case CM2SM:
	return "Raytracing-CM2SM-uchar4";

    default:
	{
	assert(false);
	return "ERROR";
	}
	}
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

