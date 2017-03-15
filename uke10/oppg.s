    .globl f1
f1:
    movl  4(%esp), %eax
    addl  %eax, $1
    imull %eax, $4
    ret


      .globl f2
f2:
    movl 4(%esp), %eax
    imull %eax, 4(%esp)
    imull %eax, 4(%esp)
    imull %eax, 4(%esp)
    imull %eax, 4(%esp)
    ret

      .globl f3
f3:
    movl $0, %eax
    cmp 4(%esp), %eax
    jle a
    cmp 8(%esp), %eax
    jle b
    movl 12(%esp), %eax
    ret
a:
  movl 4(%esp), %eax
  ret

b:
  movl 8(%esp), %eax
  ret


      .globl oppg2
oppg2:
      movl 4(%esp), %eax
      jpo oddetall
      movl $0, %eax
      ret

oppdetall:
        movl $1, %eax
        ret
