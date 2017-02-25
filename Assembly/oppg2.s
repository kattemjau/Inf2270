// oppg2

      .globl mul8
mul8:
      movl 4(%esp), %eax
      addl %eax, %eax
      addl %eax, %eax
      addl %eax, %eax
      ret

//oppg3
      .globl mul10
mul10:
      movl 4(%esp), %eax
      addl %eax, %eax
      addl %eax, %eax
      addl 4(%esp), %eax
      addl %eax, %eax
      ret
