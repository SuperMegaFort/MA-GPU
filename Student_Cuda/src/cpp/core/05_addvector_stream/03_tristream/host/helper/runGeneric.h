#pragma once

/*----------------------------------------------------------------------*\
 |*			implementation 					*|
 \*---------------------------------------------------------------------*/

/**
 * conseil : a coder que une fois tous les warmups reussis
 */
void AddVectorTristream::runGeneric()
    {
    // Warning : Aidez-vous de nouveau des 3 methodes:
    //
    //			- void copyHtoD(int sid , cudaStream_t stream)
    //			- void copyDtoH(int sid , cudaStream_t stream)
    //			- kernelSlice  (int sid , cudaStream_t stream)

    // partie Init
	{
	// step1
	    {
	    // TODO stream see schema in pdf
	    }

	// step2
	    {
	    // TODO stream see schema in pdf
	    }
	}

    // 6 variable utile pour les permutations
    cudaStream_t streamA = stream0; // cudaStream_t est un int
    cudaStream_t streamB = stream2;
    cudaStream_t streamC = stream1;

    cudaStream_t streamA_old = stream0;
    cudaStream_t streamB_old = stream2;
    cudaStream_t streamC_old = stream1;

    // partie centrale 3 stream en parallel
	{
	// TODO stream see schema in pdf
	}

    // partie finale
	{
	const int INDEX_LAST = nbSlice - 1;
	const int INDEX_BEFORE_LAST = INDEX_LAST - 1;

	// before last
	    {
	    // TODO stream see schema in pdf
	    }

	// last
	    {
	    // TODO stream see schema in pdf
	    }
	}
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
