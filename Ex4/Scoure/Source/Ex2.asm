extern printf
extern scanf
extern getch

section .data
    tb1 db "Nhap n: ",0
    true db "%d la so hoan thien",0
    false db "%d khong phai la so hoan thien",0
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
    ; goi ham _CheckPerfect
    push dword[n]
    call _CheckPerfect
    ;pause
    call getch
    xor eax, eax
    ret

global _CheckPerfect
_CheckPerfect:
    push ebp
    mov ebp, esp
    push esi
    mov esi, 0
  

    mov ecx, 1          ; i= 1
_CheckPerfect.Loop:
    mov eax, [ebp + 8]  ; eax =  n

    cmp ecx, eax  ; i >= n ?
    jge _CheckPerfect.Try ; true =>  try

    xor edx, edx        ; edx= 0
    div ecx             ; eax = n/i, edx = n%i
    test edx, edx       ; check edx
    jnz  _CheckPerfect.Inc; if edx !=0 => i++
    add esi, ecx        ; esi += i
    inc ecx             ; i++
    jmp _CheckPerfect.Loop ; loop

_CheckPerfect.Inc:
    inc ecx
    jmp _CheckPerfect.Loop

_CheckPerfect.Try:
    cmp esi, [ebp + 8]  ; esi == n ?
    je _CheckPerfect.Perfect ; true => perfect
    jmp _CheckPerfect.NotPerfect ; false => not perfect

_CheckPerfect.Perfect:
    push dword[ebp + 8] ; push n
    push true           ; push true
    call printf         ; in thong bao
    add esp, 8          ; xoa 2 phan tu khoi stack
    jmp _CheckPerfect.End

_CheckPerfect.NotPerfect:
    push dword[ebp + 8] ; push n
    push false           ; push false
    call printf           ; in thong bao
    add esp, 8

_CheckPerfect.End:
    pop esi        ; tra gia tri esi
    mov esp, ebp   ; khoi phuc stack
    pop ebp        ; khoi phuc ebp
    ret 4          ; tra ve gia tri