;nhap n. tinh tong tu 1 den n
%include "io.inc"
extern getch
section .data
    tb1 db "Nhap n: ",0
    tb2 db "Tong 1 den %d la: %d",0
    fmt db "%d"
section .bss
    n resd 1
    s resd 1 
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
    push fmt
    call scanf
    add esp, 8
    
    mov dword[s], 0 ; s = 0
    mov ecx,[n]; i = n
Lap:
    add [s],ecx; s = s+i
    Loop Lap
    
    
    ;xuat tb2
    push dword[s]
    push dword[n]
    push tb2
    call printf
    add esp,12
    
    
    call getch
    
    
    xor eax, eax
    ret