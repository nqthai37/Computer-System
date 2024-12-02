extern printf
extern scanf
extern getch

section .data
    tb1 db "Nhap n: ",0
    true db "%d la so chinh phuong",0
    false db "%d khong phai la so chinh phuong",0
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
    ; goi ham _CheckSquare
    push dword[n]
    call _CheckSquare
    ;pause
    call getch
    xor eax, eax
    ret

global _CheckSquare
_CheckSquare:
    push ebp
    mov ebp, esp
    push esi
    

    mov ecx, 1          ; i= 1
_CheckSquare.Loop:
    mov eax, ecx        ; eax = i
    mul ecx            ; eax = i*i
    cmp eax, [ebp + 8]  ; eax >= n ?
    jge _CheckSquare.Try ; true =>  try

    inc ecx
    jmp _CheckSquare.Loop
_CheckSquare.Try:
    cmp eax, [ebp + 8]  ; eax == n ?
    je _CheckSquare.Square ; true => Square
    jmp _CheckSquare.NotSquare ; false => not Square

_CheckSquare.Square:
    push dword[ebp + 8] ; push n
    push true           ; push true
    call printf         ; in thong bao
    add esp, 8          ; xoa 2 phan tu khoi stack
    jmp _CheckSquare.End

_CheckSquare.NotSquare:
    push dword[ebp + 8] ; push n
    push false           ; push false
    call printf           ; in thong bao
    add esp, 8

_CheckSquare.End:
    pop esi        ; tra gia tri esi
    mov esp, ebp   ; khoi phuc stack
    pop ebp        ; khoi phuc ebp
    ret 4          ; tra ve gia tri