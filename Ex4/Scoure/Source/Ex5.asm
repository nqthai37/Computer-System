extern scanf
extern printf

section .data
    menu_tb db 0Ah, "-------------------MENU-------------------", 0Ah, "1. Xuat mang 1 chieu n so nguyen", 0Ah, "2. Tim so nguyen to trong mang", 0Ah, "3. Tim so lon nhat trong mang", 0Ah, "4. Tinh trung binh cong cua mang", 0Ah, "5. Thoat", 0Ah, "Chon: ", 0
    tb1 db "Nhap so luong phan tu n: ", 0
    tb2 db "a[%d]: ", 0
    tb3 db "Mang vua nhap la:", 0Ah, 0
    tb4 db "Cac so nguyen to trong mang la: ", 0Ah, 0
    tb5 db "So lon nhat trong mang la: ", 0
    tb6 db "Trung binh cua mang la: ", 0
    fmt db "%d", 0
    fmt1 db "%d ", 0
    fmt2 db "%d", 0Ah, 0

section .bss
    menu_sel: resd 1
    arr: resd 20
    n: resd 1

section .text
    global main
    global _menu
    global _Nhap
    global _Xuat
    global _Prime
    global _FindMax
    global _getAvg

main:
    call _Nhap
    call _menu

    xor eax, eax
    ret
    
_menu:
    push menu_tb
    call printf
    add esp, 4

    push menu_sel
    push fmt
    call scanf
    add esp, 8

    mov eax, dword[menu_sel]
    cmp eax, 1
    je _case_Xuat
    cmp eax, 2
    je _case_Prime
    cmp eax, 3
    je _case_FindMax
    cmp eax, 4
    je _case_getAvg
    cmp eax, 5
    je _case_End

    jmp _menu

    _case_Xuat:
        call _Xuat
        jmp _menu

    _case_Prime:
        call _Prime
        jmp _menu

    _case_FindMax:
        call _FindMax
        jmp _menu

    _case_getAvg:
        call _getAvg
        jmp _menu

    _case_End:
        ret

_Nhap:
    push ebp
    mov ebp, esp

    push tb1
    call printf
    add esp, 4

    push n
    push fmt
    call scanf
    add esp, 8

    mov eax, [n]
    cmp eax, 20
    jle _Nhap.ValidSize

    push tb1             ; Print error message
    call printf
    add esp, 4

    jmp _Nhap            ; Request input again

    _Nhap.ValidSize:
        mov ebx, arr
        mov esi, 0
    _Nhap.Loop:
        push esi
        push tb2
        call printf
        add esp, 8

        push ebx
        push fmt
        call scanf
        add esp, 8

        add ebx, 4
        inc esi
        cmp esi, [n]
        jl _Nhap.Loop

    pop ebp
    ret

_Xuat:
    push ebp
    mov ebp, esp

    push tb3
    call printf
    add esp, 4

    mov ebx, arr
    mov esi, 0
    _Xuat.Loop:
        push dword[ebx]
        push fmt1
        call printf
        add esp, 8

        add ebx, 4
        inc esi
        cmp esi, [n]
        jl _Xuat.Loop

    pop ebp
    ret

_Prime:
    push ebp
    mov ebp, esp

    push esi

    push tb4         ; Print header message
    call printf
    add esp, 4

    mov esi, 0      ; Initialize counter
    mov ebx, arr    ; Array pointer

    _Prime.Check:       ; Main loop for each number
        mov eax, dword[ebx]  ; Load current number
        cmp eax, 2          ; Check if < 2
        jl _Prime.NotPrime
        je _Prime.IsPrime   ; 2 is prime
        
        mov ecx, 2          ; Start checking from 2
    _Prime.Loop:
        mov eax, dword[ebx] ; Reload number
        xor edx, edx        ; Clear EDX for division
        div ecx             ; Divide by current divisor
        test edx, edx       ; Check remainder
        jz _Prime.NotPrime  ; If divisible, not prime

        inc ecx             ; Next divisor
        mov eax, ecx        ; Check if ecx*ecx > number
        mul ecx
        cmp eax, dword[ebx]
        jbe _Prime.Loop     ; Continue if ecx*ecx <= number
        
    _Prime.IsPrime:         ; Number is prime
        push dword[ebx]
        push fmt1           ; Use space-separated format
        call printf
        add esp, 8

    _Prime.NotPrime:
        add ebx, 4          ; Next array element
        inc esi
        cmp esi, [n]
        jl _Prime.Check     ; Continue if not done
        
    _Prime.End:
        pop esi
        pop ebp
        ret          ; Return to menu

_FindMax:
    push ebp
    mov ebp, esp

    push esi           ; Save register esi

    mov ebx, arr       ; Pointer to arr[0]
    mov esi, 1         ; i = 1, start from the second element

    mov ecx, dword[ebx] ; max = arr[0]
    add ebx, 4         ; Move to arr[1]

    _FindMax.Loop:
        cmp esi, dword[n]       ; Check if i >= n
        jge _FindMax.PrintMax ; If i >= n, print max

        mov eax, dword[ebx] ; Get value of arr[i]

        cmp eax, ecx        ; Compare with current max
        jle _FindMax.Skip   ; If eax <= ecx, skip update

        mov ecx, dword[ebx]     ; Update max
        
        _FindMax.Skip:
            add ebx, 4          ; Move to next element
            inc esi             ; Increase index i
            jmp _FindMax.Loop   ; Go back to loop

    _FindMax.PrintMax:
        mov esi, ecx

        push tb5
        call printf
        add esp, 4

        push esi
        push fmt2
        call printf
        add esp, 8

        jmp _FindMax.End

    _FindMax.End:
        pop esi             ; Restore esi
        pop ebp
        ret          ; Return to menu

_getAvg:
    push ebp
    mov ebp, esp
    push esi

    mov ebx, arr
    mov ecx, 0         ; sum = 0
    mov esi, 0         ; i = 0

    _getAvg.Loop:
        add ecx, dword[ebx]   ; sum += arr[i]
        add ebx, 4            ; move to the next element

        inc esi               ; increment i
        cmp esi, [n]          ; check if i == n
        jl _getAvg.Loop       ; if not, continue loop

    ; Perform division to calculate the average
    mov eax, ecx          ; eax = sum
    xor edx, edx          ; clear edx (for division)
    div dword [n]         ; divide eax by n, quotient in eax, remainder in edx

    mov esi, eax
    
    ; Print result
    push tb6
    call printf
    add esp, 4            ; adjust stack for string

    push esi              ; push average
    push fmt2             ; format for printing the integer
    call printf
    add esp, 8            ; adjust stack for integer

    _getAvg.End:
        pop esi
        pop ebp
        ret
