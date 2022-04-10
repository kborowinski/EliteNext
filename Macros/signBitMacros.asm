ClearSignBitMem:        MACRO mem
                        ld      a,(mem)
                        and     SignMask8Bit
                        ld      (mem),a
                        ENDM

SetSignBitMem:          MACRO   mem
                        ld      a,(mem)
                        or      SignOnly8Bit
                        ld      (mem),a
                        ENDM

FlipSignMem:            MACRO mem
                        ld  a,(mem)
                        xor SignOnly8Bit
                        ld  (mem),a
                        ENDM

ClearSignBit:           MACRO reg
                        ld      a,reg
                        and     SignMask8Bit
                        ld      reg,a
                        ENDM

SetSignBit:             MACRO   reg
                        ld      a,reg
                        or      SignOnly8Bit
                        ld      reg,a
                        ENDM
                        
FlipSignBit:            MACRO   reg
                        ld      a,reg
                        xor     SignOnly8Bit
                        ld      reg,a
                        ENDM
                        
ClearSignBitA:          MACRO 
                        and     SignMask8Bit
                        ENDM

SetSignBitA:            MACRO   
                        or      SignOnly8Bit
                        ENDM

FlipSignBitA:           MACRO   
                        xor     SignOnly8Bit
                        ENDM
                        