#include <stdio.h>
#include "main.h"
#include "mydebug.h"
#include "myrun.h"
#include "fsqu.h"
#include "fcb.h"

#ifdef MYDEBUG
    #define myrun_start()
    #define myrun_end()
#else
    #define myrun_start() myrun_printf_start()
    #define myrun_end() myrun_printf_end()
#endif

#ifdef MYRELEASE
    #define mydebug_start()
    #define mydebug_end()
#else
    #define mydebug_start() mydebug_printf_start()
    #define mydebug_end() mydebug_printf_end()
#endif

//#define UNUSE(x) (void)(x)
#define UNUSE(x) (x = x)

int main(void)
{
    int x = 100;
    int y = 20;
    UNUSE(x);

    mydebug_start();
    myrun_start();
    printf("----++++----****----++++----\n");
    mydebug_end();
    myrun_end();

    printf("%d square = %d\n",y,square(y));
    printf("%d cube = %d\n",y,cube(y));
    return 0;
}