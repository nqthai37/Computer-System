.extern printf
.extern scanf
    .data
    tb1: .asciz "Nhap n: "
	true: .asciz "%d la so chinh phuong\n"
    false: .asciz "%d khong phai la so chinh phuong\n"
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
    
	mov x21,#1
Loop:

    mul x20, x21, x21
    cmp x20, x19
    b.ge CheckPerSquare
    add x21,x21,#1
    b Loop
CheckPerSquare:
    cmp x20, x19
    b.eq PerSquare
    adrp x0,false
    add x0,x0,:lo12:false
    mov x1,x19
    bl printf
    b End

PerSquare:
    adrp x0,true
    add x0,x0,:lo12:true
    mov x1,x19
    bl printf


End:
    mov x0,#0
	mov x8,#93
	svc #0
