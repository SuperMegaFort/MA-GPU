#pragma once

#include "cudas.h"
#include "Grid.h"
#include "RunnableGPU.h"

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

class AddVectorTristream: public RunnableGPU
    {
	/*--------------------------------------*\
	|*		Constructor		*|
	 \*-------------------------------------*/

    public:

	/**
	 *  update w by v1+v2
	 *  3 stream
	 *  nbSlice >3 voir VectorTools::n()
	 */
	AddVectorTristream(const Grid& grid , int* ptrV1 , int* ptrV2 , int* ptrW , int n , int nbSlice , bool isVerbose);

	virtual ~AddVectorTristream(void);

	/*--------------------------------------*\
	|*		Methodes		*|
	 \*-------------------------------------*/

    public:

	/**
	 * override
	 */
	virtual void run();

	/**
	 * override
	 */
	virtual double getOutputGO();

	/**
	 * override
	 */
	virtual double getInputGO();

    private:

	/*------------------------*\
	|*  differentes versions  *|
	 \*-----------------------*/

	void run3Slice(); // warmup
	void run4Slice(); // warmup
	void run5Slice(); // warmup
	void runGeneric();

	/*------------------------*\
	|*  	Tools  		   *|
	 \*-----------------------*/

	/**
	 * sid=sliceIndex
	 */
	void copyHtoD(int sid , cudaStream_t stream);

	/**
	 * sid=sliceIndex
	 */
	void copyDtoH(int sid , cudaStream_t stream);

	/**
	 * sid=sliceIndex
	 */
	void kernelSlice(int sid , cudaStream_t stream);

	/**
	 * sid=sliceIndex
	 * return decalage a effectuer pour pointer sur le premier element d'une slice
	 */
	int offsetSlice(int sid);


	std::string title(int nbStream);

	/*--------------------------------------*\
	|*		Attributs		*|
	 \*-------------------------------------*/

    private:

	// Inputs
	int* ptrV1;
	int* ptrV2;
	int n;
	int nbSlice;

	// Inputs/Outputs
	int* ptrW;

	// Tools
	int* ptrGMV1;
	int* ptrGMV2;
	int* ptrGMW;
	size_t sizeVector; //[octet]

	cudaStream_t stream0;
	cudaStream_t stream1;
	cudaStream_t stream2;

	size_t SIZE_SLICE;
	int N_BY_SLICE;

    };

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
