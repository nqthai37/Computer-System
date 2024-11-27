    .extern printf
    .extern scanf
    .data
    prompt: .asciz "Nhap mot so: "
    true: .asciz "%d la so doi xung\n"
    false: .asciz "%d khong phai la so doi xung\n"
    fmt: .asciz "%d"
    
    .section .bss
    n: .space 8             
    .section .text
    .global main

main:
    adrp x0, prompt
    add x0, x0, :lo12:prompt
    bl printf
    
    adrp x0, fmt
    add x0, x0, :lo12:fmt
    adrp x1, n
    add x1, x1, :lo12:n
    bl scanf
    
    adrp x19, n
    add x19, x19, :lo12:n
    ldur x19, [x19]            
    
    mov x20, #0               
    mov x21, x19               

ReverseLoop:
    cmp x21, #0
    beq CompareNumbers        
    
    mov x25,#10
    udiv x22, x21, x25         
    msub x23, x22, x25, x21   
    mul x20, x20, x25          
    add x20, x20, x23          

    mov x21, x22              
    b ReverseLoop

CompareNumbers:
  
    cmp x19, x20
    b.eq IsPalindrome   

     adrp x0,false
    add x0, x0, :lo12:false
    mov x1, x19               
    bl printf
    b End

IsPalindrome:
    adrp x0, true
    add x0, x0, :lo12:true
    mov x1, x19               
    bl printf

End:
    mov x0, #0
    mov x8, #93
    svc #0
