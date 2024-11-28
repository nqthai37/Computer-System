D:/SASM/NASM/nasm.exe --gprefix _ -f win32 $1.asm -o $1.obj
D:/SASM/MinGW/bin/gcc.exe -m32 -o $1.exe $1.obj

./$1.exe
rm $1.obj $1.exe