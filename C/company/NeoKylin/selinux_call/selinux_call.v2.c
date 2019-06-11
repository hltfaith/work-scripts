#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>

#define LABEL "sysadm_u:sysadm_r:rpm_t:s0-s0:c0.c1023"
int main(void){

	int (*func)();
	void *handle=dlopen("/usr/lib64/libselinux.so.1", RTLD_LAZY);

	
	func = dlsym(handle, "setcon");
	//(*func)('sysadm_u:sysadm_r:rpm_t:s0-s0:c0.c1023');
	(*func)(LABEL);

	func = dlsym(handle, "security_setenforce");
	(*func)(0);

	printf("强访状态 getenforce \n");
	func = dlsym(handle,"security_getenforce");
	// (*func)();
	int aa = (*func)();
	printf("%d\n", aa);
	
}
