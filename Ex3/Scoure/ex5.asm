.extern printf
.extern scanf
.section .data
    menu_tb: .asciz "\n-------------------MENU-------------------\n1. Xuat mang 1 chieu n so nguyen\n2. Tim so nguyen to trong mang\n3. Tim so lon nhat trong mang\n4. Tinh trung binh cong cua mang\n5. Thoat\nChon: "
    tb1: .asciz "Nhap n: "
    tb2: .asciz "a[%d]: "
    tb3: .asciz "Mang vua nhap la:\n"
    tb4: .asciz "\nCac so nguyen to trong mang la: \n"
    tb5: .asciz "\nSo lon nhat trong mang la: "
    tb6: .asciz "Trung binh cua mang la: "
    fmt: .asciz "%d"
    fmt1: .asciz "%d "
    fmt2: .asciz "%d\n"
.section .bss
    arr: .space 160
    menu_sel: .space 8
    n: .space 8
.section .text
.global main
.global menu
.global Nhap
.global Xuat
.global Prime
.global FindMax
.global getAvg
.global End

main:
	bl Nhap
menu:
    adrp x0, menu_tb
    add x0, x0, :lo12:menu_tb
    bl printf

    adrp x0, fmt
    add x0, x0, :lo12:fmt
    adrp x1, menu_sel
    add x1, x1, :lo12:menu_sel
    bl scanf

    adrp x1, menu_sel
    add x1, x1, :lo12:menu_sel
    ldur x1, [x1]

    cmp x1, #1
    b.eq cd1
    cmp x1, #2
    b.eq cd2 
    cmp x1, #3
    b.eq cd3
    cmp x1, #4
    b.eq cd4
    cmp x1, #5
    b.eq cd5

    bl menu

cd1:
    bl Xuat
    bl menu
cd2:
    bl Prime
    bl menu
cd3:
    bl FindMax
    bl menu
cd4: 
    bl getAvg
    bl menu
cd5:
    bl End
Nhap:
    adrp x0, tb1
    add x0, x0, :lo12:tb1
    bl printf

    adrp x0, fmt
    add x0, x0, :lo12:fmt
    adrp x1, n
    add x1, x1, :lo12:n
    bl scanf

    adrp x19, n
    add x19, x19, :lo12:n
    ldur x19, [x19]

    adrp x20, arr
    add x20, x20, :lo12:arr

    mov x21, #0
LoopNhap:
    cmp x21, x19
    b.ge EndNhap

    adrp x0, tb2
    add x0, x0, :lo12:tb2
    mov x1, x21
    bl printf

    adrp x0, fmt
    add x0, x0, :lo12:fmt
    mov x1, x20
    bl scanf

    add x20, x20, #8
    add x21, x21, #1
    b LoopNhap

EndNhap:
    bl menu

Xuat:
    adrp x0, tb3
    add x0, x0, :lo12:tb3
    bl printf

    adrp x20, arr
    add x20, x20, :lo12:arr
    mov x21, #0

LoopXuat:
    cmp x21, x19
    b.ge EndXuat

    adrp x0, fmt1
    add x0, x0, :lo12:fmt1
    ldur x1, [x20]
    bl printf

    add x20, x20, #8
    add x21, x21, #1
    b LoopXuat

EndXuat:
    bl menu

Prime:
    adrp x0, tb4
    add x0, x0, :lo12:tb4
    bl printf

    adrp x20, arr
    add x20, x20, :lo12:arr
    mov x21, #0

LoopPrime:
    cmp x21, x19
    b.ge EndPrime

    ldur x2, [x20]
    cmp x2, #2
    b.lt NotPrime

    mov x23, #2

CheckPrime:
    cmp x23, x2
    b.ge PrintPrime

    udiv x24, x2, x23
    msub x25, x24, x23, x2
    cbz x25, NotPrime

    add x23, x23, #1
    b CheckPrime

PrintPrime:
    adrp x0, fmt1
    add x0, x0, :lo12:fmt1
    mov x1, x2
    bl printf
    b NextPrime

NotPrime:
NextPrime:
    add x20, x20, #8
    add x21, x21, #1
    b LoopPrime

EndPrime:
    bl menu

FindMax:
    adrp x20, arr
    add x20, x20, :lo12:arr
    ldur x22, [x20]
    add x20, x20, #8
    mov x21, #1

LoopMax:
    cmp x21, x19
    b.ge PrintMax

    ldur x1, [x20]
    cmp x1, x22
    b.le NotMax
    mov x22, x1

NotMax:
    add x20, x20, #8
    add x21, x21, #1
    b LoopMax

PrintMax:
    adrp x0, tb5
    add x0, x0, :lo12:tb5
    bl printf

    adrp x0, fmt2
    add x0, x0, :lo12:fmt2
    mov x1, x22
    bl printf
    bl menu

getAvg:
    adrp x20, arr
    add x20, x20, :lo12:arr
    mov x21, #0
    mov x22, #0

LoopAvg:
    cmp x21, x19
    b.ge CalculateAvg

    ldur x1, [x20]
    add x22, x22, x1

    add x20, x20, #8
    add x21, x21, #1
    b LoopAvg

CalculateAvg:
    udiv x22, x22, x19

    adrp x0, tb6
    add x0, x0, :lo12:tb6
    bl printf

    adrp x0, fmt2
    add x0, x0, :lo12:fmt2
    mov x1, x22
    bl printf
    bl menu

End:
    mov x0, #0
    mov x8, #93
    svc #0
