#include "../include/stda.h"

int main(int argc, char *argv[])
{    
    TRY 
    {
    	printf("Hello World!!\n");

        float n = 3;
        float d = 0;

        logger_log_info("n = %2.2f", n);
        logger_log_info("d = %2.2f", d);

        FILE *fp;
        errno = 0;
        fp = fopen("Nofile", "r");

        if(errno > 0)
            THROW(SYSTEM_EXCEPTION);

        fclose(fp);

        if (d == 0)        
            THROW(DIVIDE_BY_ZERO_EXCEPTION);

        float r = n/d;
        printf("%2.2f/%2.2f=%2.2f\n", n, d, r);

    }
    CATCH (DIVIDE_BY_ZERO_EXCEPTION)
    {
        logger_log_err("Attempted to divide by Zero");
    }

    CATCH (SYSTEM_EXCEPTION)
    {
        logger_log_err("errno: %d - %s", errno, strerror(errno));
    }

    ENDTRY

    printf("Press [ENTER] to quit!\n");
    getchar();

    return 0;
}