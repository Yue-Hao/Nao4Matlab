/*
export MATLAB="/Applications/MATLAB_R2011b.app/"
export DYLD_LIBRARY_PATH=$MATLAB/bin/maci64/:$MATLAB/sys/os/maci/:DYLD_LIBRARY_PATH
sudo ln -s /Applications/MATLAB_R2011a.app/bin/matlab /usr/bin/matlab
g++ -o engdemo engdemo.cpp -I$MATLAB/extern/include/ -L$MATLAB/bin/maci/ -leng -lm -lmat -lmx -lut
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "engine.h"
#include "matrix.h"

#pragma comment(lib,"libeng.lib")
#pragma comment(lib,"libmx.lib")

int main()
{
    Engine *ep;
    int i , j ;
    
    //show how to open MATLAB engine
    //for remote ones:
    //engOpen( ADDRESS OF REMOTE SYSTEM ) ;
    
    if (!(ep = engOpen("\0"))){
        fprintf(stderr, "\nCan't start MATLAB engine\n");
        return EXIT_FAILURE;
    }
    
    //show how to create matrix
    mxArray *Y = mxCreateDoubleMatrix(1 , 3 , mxREAL) ;
    
    //show how to put data in matrix
    double tmp[3] = {1.0 , 2.0 , 3.0} ;
    memcpy(mxGetPr(Y) , tmp , sizeof(tmp)) ;
    
    //show how to put variables in the Engine
    engPutVariable(ep , "Y" , Y) ;
    
    //show how to execute commands in MATLAB
    engEvalString(ep, "X = ones(5,1) * Y");
    engEvalString(ep, "plot(Y)");
    
    //show how to get variables from the Engine
    mxArray *X = engGetVariable(ep , "X") ;
    
    //show how to manipulate dimensions
    int dims[10] ;
    int ndims ;
    ndims = mxGetNumberOfDimensions(X) ;
    printf("total number of dimensions is %d\n" , ndims) ;
    memcpy(dims , mxGetDimensions(X) , ndims * sizeof(int)) ;
    for ( i = 0 ; i < ndims ; i ++ ){
        printf("dimension %d : %d\n" , i , dims[i]) ;
    }
    printf("\n") ;
    
    //show how the data is stored in the memory
    double *p = (double*)mxGetData(X) ;
    for ( i = 0 ; i < dims[0] ; i ++ ){
        for ( j = 0 ; j < dims[1] ; j ++ ){
            printf("%8.2f" , p[j * dims[0] + i]) ;
        }
        printf("\n") ;
    }
    
    //---important, to release resources
    mxDestroyArray(X) ;
    mxDestroyArray(Y) ;
    
    //show how to hide and unhide MATLAB command window
    printf("type RETURN to hide the MATLAB command window...\n") ;
    getchar() ;
    engSetVisible(ep , false) ;
    printf("type RETURN to unhide the MATLAB command window...\n") ;
    getchar() ;
    engSetVisible(ep , true) ;
    
    printf("type RETURN to END this program...\n") ;
    getchar() ;
    //remembering to close it is important .
    //but if you are debugging your programs ,
    //annotate the following line will save you a lot of time ,
    //for you needn't to restart the Engine .
    engClose(ep) ;
    
    //when your work is accomplished , type "exit" in MATLAB command window
    
    return EXIT_SUCCESS;
}