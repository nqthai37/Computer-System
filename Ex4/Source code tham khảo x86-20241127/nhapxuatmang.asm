;nhap xuat mang 1 chieu n so nguyen
%include "io.inc"
extern getch
section .data
    tb1 db "Nhap n: ",0
    tb2 db "a[%d]: ",0
    tb3 db "Mang vua nhap la: ",0
    fmt1 db "%d",0
    fmt2 db "%3d",0
section .bss
    arr resd 30
    n resd 1 
    i resd 1 
section .text
global main
main:
    ;write your code here
    ;xuat tb1
    push tb1
    call printf
    add esp,4
    
    ;nhap n
    push n
    push fmt1
    call scanf
    add esp,8
    
    ;khoi tao vong lap
    mov ebx,arr ; ebx = address arr
    mov esi,0
Lap.Nhap:
    ;xuat tb2
    push esi
    push tb2
    call printf
    
    ;nhap a[i]
    push ebx
    push fmt1
    call scanf
    
    add ebx,4; tang dia chi mang
    inc esi; i++
    cmp esi, [n]
    jl Lap.Nhap
    
    
    ;xuat tb3
    push tb3
    call printf
    add esp,4
    
    ;khoi tao vong lap
    mov ebx,arr
    mov esi,0
Lap.Xuat:
    push dword[ebx]
    push fmt2
    call printf
    add esp,8
    
    add ebx,4; tang dia chi mang
    inc esi; i++
    cmp esi, [n]
    jl Lap.Xuat
    
    call getch
    xor eax, eax
    ret