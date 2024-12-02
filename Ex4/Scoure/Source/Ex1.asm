extern printf
extern scanf
extern getch

section .data
    tb1 db "Nhap n: ",0
    true db "%d la so nguyen to",0
    false db "%d khong phai la so nguyen to",0
    fmt db "%d",0

section .bss
    n: resd 1           

section .text
    global main

main:
    ;in tb1
    push tb1
    call printf
    add esp,4
    ; nhap n
    push n
    push fmt
    call scanf
    add esp,8
    ; goi ham _CheckPrime
    push dword[n]
    call _CheckPrime
    ;pause
    call getch
    xor eax, eax
    ret

global _CheckPrime
_CheckPrime:
    push ebp
    mov ebp, esp
    push esi
    
    ; if n < 2
    cmp dword[ebp + 8], 2
    jl _CheckPrime.NotPrime
    
    ;  if n == 2
    je _CheckPrime.Prime
    
    mov ecx, 2          ; i= 2
_CheckPrime.Loop:
    mov eax, [ebp + 8]  ; eax =  n
    xor edx, edx        ; edx= 0
    div ecx             ; eax = n/i, edx = n%i
    test edx, edx       ; check edx
    jz _CheckPrime.NotPrime ; if edx ==0
    inc ecx             ; i++
    mov eax, ecx        ; eax = i
    mul ecx             ; eax = i*i
    cmp eax, [ebp + 8]  ; eax <= n ?
    jbe _CheckPrime.Loop ; true =>  loop
    jmp _CheckPrime.Prime ; false => prime

_CheckPrime.Prime:
    push dword[ebp + 8] ; push n
    push true           ; push true
    call printf         ; in thong bao
    add esp, 8          ; xoa 2 phan tu khoi stack
    jmp _CheckPrime.End

_CheckPrime.NotPrime:
    push dword[ebp + 8] ; push n
    push false           ; push false
    call printf           ; in thong bao
    add esp, 8

_CheckPrime.End:
    pop esi        ; tra gia tri esi
    mov esp, ebp   ; khoi phuc stack
    pop ebp        ; khoi phuc ebp
    ret 4          ; tra ve gia tri