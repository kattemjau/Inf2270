    .globl intcmp
intcmp:
    movl 4(%esp), %eax
    subl 8(%esp), %eax
    ret
