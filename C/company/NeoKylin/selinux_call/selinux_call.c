#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dlfcn.h>

#define PyObject_GenericGetAttr
void show_err_info();

int main(void)
{
        void (*pfun)(void);
        int (*myadd)(void);
        void *handle=NULL;
        handle = dlopen("./_selinux.so", RTLD_LAZY);

        if(!pfun)
        {
                printf("dlopen failed\n");
                exit(1);
        }

        show_err_info();

        myadd = dlsym(handle, "security_getenforce");
        printf("success");
        pfun();

        int aa = myadd();
        dlclose(handle);

        printf("%d\n", aa);
        return 0;
}

void show_err_info()
{
        char *perr=NULL;
        perr = dlerror();
        if(NULL!=perr)
        {
                printf("%s\n", perr);
                exit(1);
        }
}
