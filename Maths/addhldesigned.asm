addhldesigned:          bit     7,h
                        jr      nz,.noneghl
                        call    negate16hl
.noneghl:               bit     7,d
                        jr      nz,.nonegde
                        call    negate16de
.nonegde:               add     hl,de                       ; do 2'd c add      
                        xor     a                           ; assume positive
                        bit     7,h
                        ret     z                           ; if not set then can exit early
                        call    negate16hl
                        ld      a,$FF
                        ret
