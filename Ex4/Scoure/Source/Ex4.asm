extern printf
extern scanf
extern getch

section .data
    tb1 db "Nhap n: ",0
    true db "%d la so doi xung",0
    false db "%d khong phai la so doi xung",0
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
    ; goi ham _CheckPalindromic
    push dword[n]
    call _CheckPalindromic
    ;pause
    call getch
    xor eax, eax
    ret

global _CheckPalindromic
_CheckPalindromic:
    push ebp
    mov ebp, esp
    push esi
    mov esi,0

    mov ecx, 1          ; i= 1
    mov eax, [ebp + 8]  ; eax =  n
_CheckPalindromic.Loop:
    cmp eax,0
    je _CheckPalindromic.Try
    mov edx, 0

    mov ecx,10
    div ecx

    mov ecx , esi
    imul ecx,10
    add ecx,edx
    mov esi,ecx

    jmp _CheckPalindromic.Loop
_CheckPalindromic.Try:
    cmp esi, [ebp + 8]  ; eax == n ?
    je _CheckPalindromic.Palindromic ; true => Palindromic
    jmp _CheckPalindromic.NotPalindromic ; false => not Palindromic

_CheckPalindromic.Palindromic:
    push dword[ebp + 8] ; push n
    push true           ; push true
    call printf         ; in thong bao
    add esp, 8          ; xoa 2 phan tu khoi stack
    jmp _CheckPalindromic.End

_CheckPalindromic.NotPalindromic:
    push dword[ebp + 8] ; push n
    push false           ; push false
    call printf           ; in thong bao
    add esp, 8

_CheckPalindromic.End:
    pop esi        ; tra gia tri esi
    mov esp, ebp   ; khoi phuc stack
    pop ebp        ; khoi phuc ebp
    ret 4          ; tra ve gia tri