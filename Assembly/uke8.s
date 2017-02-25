
// oppg1

      .globl f
f:
      movl $0, %eax
      subl 4(%esp), %eax
      subl 8(%esp), %eax
      
      ret
