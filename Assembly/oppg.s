    .globl fs
fs:
    movl  4(%esp), %eax
    addl  %eax, 8(%esp)
    addl  %eax, 8(%esp)
    addl  %eax, 8(%esp)
    addl  %eax, 12(%esp)
    ret
