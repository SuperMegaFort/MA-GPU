#pragma once

/*----------------------------------------------------------------------*\
 |*			implementation 					*|
 \*---------------------------------------------------------------------*/


/**
 * Warmup : 5 slice
 */
void AddVectorTristream::run5Slice()
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

    // partie centrale 3 stream en parallel
	{
	// step3
	    {
	    // TODO stream see schema in pdf
	    }

	// step4
	    {
	    // TODO stream see schema in pdf
	    }

	// step 5
	    {
	    // TODO stream see schema in pdf
	    }
	}

    // partie finale
	{
	const int INDEX_LAST = -1;        // TODO 		// un peu de genericiter
	const int INDEX_BEFORE_LAST = INDEX_LAST - 1; 	// un peu de genericiter

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
