#include <setjmp.h>
#include <signal.h>

jmp_buf ex_buf__;

/*
#define TRY if (setjmp(ex_buf__) == 0)
#define CATCH else
#define THROW longjmp(ex_buf__, 1)
*/

#define TRY switch( setjmp(ex_buf__) ){ case 0:
#define CATCH(ex) break; case ex:
#define ENDTRY break; }
#define THROW(ex) longjmp(ex_buf__, ex)

#define SYSTEM_EXCEPTION            100 
#define FILE_NOT_FOUND_EXCEPTION    101 
#define FILE_OPEN_EXCEPTION         102
#define ARGUMENT_EXCEPTION          103
#define OPERATION_EXCEPTION         104
#define DIVIDE_BY_ZERO_EXCEPTION    105
#define PERMISSION_DENIED_EXCEPTION 106
#define APPLICATION_EXCEPTION       107
#define RUNTIME_EXCEPTION           108
