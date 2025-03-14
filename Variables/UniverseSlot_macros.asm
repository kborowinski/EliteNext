
AddJunkCount:           MACRO
                        ld      hl,JunkCount
                        inc     (hl)
                        ENDM

SubJunkCount:           MACRO
                        ld      hl,JunkCount
                        dec     (hl)
                        ENDM
                        
AddCop:                 MACRO
                        ld      hl,CopCount
                        inc     (hl)
                        ENDM
                        
SubCop:                 MACRO
                        ld      hl,CopCount
                        dec     (hl)
                        ENDM

AddPirateCount:         MACRO
                        ld      hl,PirateCount
                        inc     (hl)     
                        ENDM

SubPirateCount:         MACRO
                        ld      hl,PirateCount
                        inc     (hl)     
                        ENDM

AreCopsPresent:         MACRO
                        ld      a,(CopCount)
                        and     a
                        ENDM
                
TestRoomForJunk:        MACRO   Target
                        ld      a,3
                        JumpIfALTMemusng    JunkCount, Target
                        ENDM

JumpIfSpaceStation:     MACRO   Target
                        ld      hl,UniverseSlotType
                        ld      a,(hl)
                        cp      ShipTypeStation
                        ENDM

ClearSlotMem:           MACRO   mem
                        ld      a,(mem)
                        call    ClearSlotA
                        ENDM
                        
IsSlotEmpty:            MACRO
                        ld      hl,UniverseSlotList
                        add     hl,a
                        ld      a,(hl)
                        cp      0
                        ENDM

                        
; Checks if slot is empty else A = ship type
ReturnIfSlotAEmpty:     MACRO
                        ld      hl,UniverseSlotList
                        add     hl,a
                        ld      a,(hl)
                        inc     a
                        ret     z           ; if slot was ff inc would make it 0
                        dec     a           ; get original value back for later
                        ENDM

JumpIfSlotAEmpty:       MACRO   Target
                        ld      hl,UniverseSlotList
                        add     hl,a
                        ld      a,(hl)
                        inc     a
                        jp      z,Target    ; if slot was ff inc would make it 0
                        dec     a           ; get original value back for later
                        ENDM
                        
JumpIfSlotHLEmpty:      MACRO   Target
                        ld      a,(hl)
                        and     a
                        jr      nz,Target
                        ENDM