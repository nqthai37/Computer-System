%include "io.inc"

extern getch

section .data
    tb1 db "Nhap n: ",0
	true db "%d la so nguyen to\n",0
    false db "%d khong phai la so nguyen to\n",0
	fmt db "%d",0

section .bss
	n: resd 1           
section .text
    global main

main:
	//xuat tb1
    push tb1
    call printf
    add esp,4
	
	//Nhap n
    push n
    push fmt
    call scanf
    add esp,8

    ;Goi ham kiem tra nguyen to
    push dword[n]
    call _CheckPrime

    call getch                 ; Dừng màn hình để người dùng xem kết quả
    xor eax, eax               ; Trả về 0 để báo kết thúc

    ret
    
; 	//Load n vao x19
; 	adrp x19,n
; 	add x19,x19,:lo12:n
; 	ldur x19,[x19]

;      cmp x19, #1
;     b.le NotPrime
;     //Khoi tao vong lap
; 	mov x21,#2  // i = 2
; Loop:

;    mul x20, x21, x21
;     cmp x20, x19
;     b.gt Prime
;     // Check if n % i == 0
;     udiv x22, x19, x21 // x22 = n / i   
;     msub x23, x22, x21, x19 // x23 = n - i * (n / i)
;     cmp x23, #0
;     b.eq NotPrime

;     add x21,x21,#1
;    b Loop
 
; Prime:
;     adrp x0,true
; 	add x0,x0,:lo12:true
; 	mov x1,x19
; 	bl printf
;     b End
; NotPrime:
;     adrp x0,false
; 	add x0,x0,:lo12:false
; 	mov x1,x19
; 	bl printf

; End:
;     mov x0,#0
; 	mov x8,#93
; 	svc #0
 
global _CheckPrime
_CheckPrime:
    push  ebp
    mov ebp, esp
    push esi

    mov eax,1 
_CheckPrime.Loop:

    mul eax, eax
    cmp eax, [ebp+8]
    jgt Prime
    // Check if n % i == 0
    udiv x22, x19, x21 // x22 = n / i   
    msub x23, x22, x21, x19 // x23 = n - i * (n / i)
    cmp x23, #0
    b.eq NotPrime

    add x21,x21,#1
   b Loop
