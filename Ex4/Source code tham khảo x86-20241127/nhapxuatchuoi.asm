;Nhap ho ten + nam sinh
; xuat xin chao + hoten + Tuoi:
%include "io.inc"
extern gets
extern getch
section .data
    tb1 db "Nhap ho ten: ",0
    tb2 db "Nhap nam sinh: ",0
    tb3 db "xin chao %s, tuoi: %d",0
    fmt db "%d",0
section .bss
    hoten resb 30
    ns resd 1
    tuoi resd 1
section .text
global main
main:
    ;write your code here
    ;xuat tb1
    push tb1
    call printf
    add esp,4
    
    ;nhap ho ten
    push hoten
    call gets
    add esp,4
    
    ;xuat tb2
    push tb2
    call printf
    add esp,4
    
    ;Nhap ns
    push ns
    push fmt
    call scanf
    add esp,8
    
    ;tinh tuoi
    mov eax,2024
    sub eax,[ns]
    mov [tuoi],eax
    
    ;xuat tb3
    push dword[tuoi]
    push hoten
    push tb3
    call printf
    add esp,12
    
    call getch
    xor eax, eax
    ret
  