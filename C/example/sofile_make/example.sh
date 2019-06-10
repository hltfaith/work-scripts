ubuntu@dongyang-K46CB:~/lua$ gcc -o test test.c -lHello -L.
test.c:1:19: fatal error: Hello.h: 没有那个文件或目录
compilation terminated.
ubuntu@dongyang-K46CB:~/lua$ gcc -o test test.c -lHello -L. -I`pwd`
ubuntu@dongyang-K46CB:~/lua$ ls
Hello.c  Hello.h  iterator.lua  libHello.so  m.lua  numToCN.lua  result  test  test.c  test.lua  testModule.lua
ubuntu@dongyang-K46CB:~/lua$ ./test
./test: error while loading shared libraries: libHello.so: cannot open shared object file: No such file or directory
ubuntu@dongyang-K46CB:~/lua$ gcc test.c -lHello -L. -I`pwd` -o test
ubuntu@dongyang-K46CB:~/lua$ ldd test
        linux-vdso.so.1 =>  (0x00007ffef46eb000)
        libHello.so => not found
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fde84873000)
        /lib64/ld-linux-x86-64.so.2 (0x00007fde84c3d000)
ubuntu@dongyang-K46CB:~/lua$ export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`
ubuntu@dongyang-K46CB:~/lua$ ./test
Hello World!
ubuntu@dongyang-K46CB:~/lua$ ldd test
        linux-vdso.so.1 =>  (0x00007ffd657cc000)
        libHello.so (0x00007f84ab3a1000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f84aafd7000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f84ab5a3000)
ubuntu@dongyang-K46CB:~/lua$
