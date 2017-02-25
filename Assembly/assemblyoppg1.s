        .globl num3
add:
    movl    4(%esp), %eax
    addl    %eax, 8(%esp)
    addl    %eax, 12(%esp)
    ret
