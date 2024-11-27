.extern printf
.extern scanf
    .data
    tb1: .asciz "Nhap n: "
	true: .asciz "%d la so hoan thien\n"
    false: .asciz "%d khong phai la so hoan thien\n"
	fmt: .asciz "%d"
.section .bss
	n: .space 8             
.section .text
    .global main

main:
	//xuat tb1
	adrp x0,tb1
	add x0,x0,:lo12:tb1
	bl printf
	
	//Nhap n
	adrp x0,fmt
	add x0,x0,:lo12:fmt
	adrp x1,n
	add x1,x1,:lo12:n
	bl scanf
    
	//Load n vao x19
	adrp x19,n
	add x19,x19,:lo12:n
	ldur x19,[x19]
    //Khoi tao vong lap
	mov x21,#1 // i = 1
    mov x20,#0  // sum = 0
Loop:
    cmp x21, x19
    b.ge CheckPerfect

    // chia lay du
    udiv x22, x19, x21 // x22 = n / i
    msub x23, x22, x21, x19 // x23 = n - i * (n / i)
    cmp x23, #0
    b.ne Divisor
    add x20,x20,x21
Divisor:
   add x21,x21,#1
    b Loop

CheckPerfect:
    cmp x20, x19
    b.eq Perfect
    adrp x0,false
    add x0,x0,:lo12:false
    mov x1,x19
    bl printf
    b End

Perfect:
    adrp x0,true
    add x0,x0,:lo12:true
    mov x1,x19
    bl printf
End:
    mov x0,#0
	mov x8,#93
	svc #0
