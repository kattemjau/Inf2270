        .globl  dumpreg
# Navn:         dumpreg
# Synopsis:     Skriver ut alle registrene.
# C-signatur:   void dumpreg (void).
# Registre:     Ødelegger _ingen_ registre eller flagg!
        
dumpreg:
        pushl   %ebp            # Standard
        movl    %esp,%ebp       # funksjonsstart
        pushf                   # Gjem også flaggene,
        pushl   %eax            # EAX,
        pushl   %ecx            # ECX og EDX (siden
        pushl   %edx            # 'printf' kan
                                # ødelegge dem)
        pushl   %edx            # Legg EDX,
        pushl   %ecx            # ECX,
        pushl   %ebx            # EBX og
        pushl   %eax            # EAX på stakken.
        movl    4(%ebp),%eax    # Legg PC (returadr)
        pushl   %eax            # på stakken.
        leal    form1,%eax      # Legg adr til form1
        pushl   %eax            # på stakken.
        call    printf          # Kall 'printf'.
        popl    %eax            # 
        popl    %eax            # Rydd
        popl    %eax            # opp 
        popl    %eax            # på
        popl    %eax            # stakken.
        popl    %eax            #

        pushl   %edi            # Legg EDI
        pushl   %esi            # og ESI på stakken.
        movl    0(%ebp),%eax    # Hent riktig EBP
        pushl   %eax            # og legg på stakken.
        movl    %ebp,%eax       # Riktig ESP er
        subl    $4,%eax         # EBP-4;  legg
        pushl   %eax            # den på stakken.
        lea     form2,%eax      # Legg adr til form2
        pushl   %eax            # på stakken.
        call    printf          # Kall 'printf'.
        popl    %eax            # 
        popl    %eax            # Rydd
        popl    %eax            # opp
        popl    %eax            # på
        popl    %eax            # stakken.

        popl    %edx            # Hent tilbake EDX,
        popl    %ecx            # ECX,
        popl    %eax            # EAX,
        popf                    # og flaggene.
        popl    %ebp            #
        ret                     # Retur.

        .data

form1:  .asciz  "Dump: PC=%08x EAX=%08x EBX=%08x ECX=%08x EDX=%08x\n"
form2:  .asciz  "                  ESP=%08x EBP=%08x ESI=%08x EDI=%08x\n"
