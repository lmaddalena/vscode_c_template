#include "../include/stda.h"

int main(int argc, char *argv[])
{    
    TRY 
    {
    	printf("Hello World!!\n");

        float n = 3;
        float d = 0;

        if (d == 0)        
            THROW(DIVIDE_BY_ZERO_EXCEPTION);

        float r = n/d;
        printf("%2.2f/%2.2f=%2.2f\n", n, d, r);

        if(errno > 0)
            THROW(SYSTEM_EXCEPTION);

    }
    CATCH (DIVIDE_BY_ZERO_EXCEPTION)
    {
        printf("Attempted to divide by Zero\n"); 
    }

    CATCH (SYSTEM_EXCEPTION)
    {
        printf("Value of errno: %d\n ", errno); 
        perror("Message from perror"); 
    }

    ENDTRY

    printf("Press [ENTER] to quit!\n");
    getchar();

    return 0;
}