;Viet ham tinh x^n
%include "io.inc"
extern getch
section .data
    tb1 db "Nhap x: ",0
    tb2 db "Nhap n: ",0
    tb3 db "%d ^ %d = %d",0
    fmt db "%d",0
    
section .bss
    x resd 1
    n resd 1
    t resd 1
section .text
global main
main:
    ;write your code here
    ;xuat tb1
    push tb1
    call printf
    add esp,4
    
    ;nhap x
    push x
    push fmt
    call scanf
    add esp,8
    
    ;xuat tb2
    push tb2
    call printf
    add esp,4
    
    ;nhap n
    push n
    push fmt
    call scanf
    add esp,8
    
    ;goi ham _TinhMu
    push dword[n]
    push dword[x]
    call _TinhMu
    ;Luu ket qua tra ve vao t
    mov [t],eax
    
    ;xuat tb3
    push dword[t]
    push dword [n]
    push dword [x]
    push tb3
    call printf
    add esp, 16
    
    call getch
    xor eax, eax
    ret
    
;Viet ham _TinhMu
;dau thu tuc
global _TinhMu
_TinhMu:
    push ebp ; backup ebp
    mov ebp, esp
    ;backup thanh ghi
    push esi
    
;Than thu tuc
    ;khoi tao vong lap
    mov eax,1; t = 1
    mov esi,1; i = 1
_TinhMu.Lap:
    mul dword[ebp + 8]; eax = eax * x
    inc esi; i++
    cmp esi, [ebp + 12]
    jle _TinhMu.Lap
    
;cuoi thu tuc
    pop esi
    pop ebp
    ret
    

    