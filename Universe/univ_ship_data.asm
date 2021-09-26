; In  flight ship data tables
; In  flight ship data tables
; There can be upto &12 objects in flight.
; To avoid hassle of memory heap managment, the free list
; will correspond to a memory bank offset so data will be held in
; 1 bank per universe object. Its a waste of a lot of memory but really
; simple that way. Each bank will be 8K and swapped on 8K slot 7 $E000 to $FFFF
; This means each gets its own line list, inwork etc

; "Runtime Ship Data paged into in Bank 7"
StartOfUniv:        DB "Universe PG"
; NOTE we can cheat and pre allocate segs just using a DS for now

;   \ -> & 565D \ See ship data files chosen and loaded after flight code starts running.
; Universe map substibute for INWK
;-Camera Position of Ship----------------------------------------------------------------------------------------------------------
UBnKxlo                     DB  0                       ; INWK+0
UBnKxhi                     DB  0                       ; there are hi medium low as some times these are 24 bit
UBnKxsgn                    DB  0                       ; INWK+2
UBnKylo                     DB  0                       ; INWK+3 \ ylo
UbnKyhi                     DB  0                       ; INWK+4 \ yHi
UBnKysgn                    DB  0                       ; INWK +5
UbnKzlo                     DB  0                       ; INWK +6
UBnKzhi                     DB  0                       ; INWK +7
UBnKzsgn                    DB  0                       ; INWK +8
;-Rotation Matrix of Ship----------------------------------------------------------------------------------------------------------
; Rotation data is stored as lohi, but only 15 bits with 16th bit being  a sign bit. Note this is NOT 2'c compliment
UBnkrotmatSidevX            DW  0                       ; INWK +21
UBnkrotmatSidev             equ UBnkrotmatSidevX
UBnkrotmatSidevY            DW  0                       ; INWK +23
UBnkrotmatSidevZ            DW  0                       ; INWK +25
UBnkrotmatRoofvX            DW  0                       ; INWK +15
UBnkrotmatRoofv             equ UBnkrotmatRoofvX
UBnkrotmatRoofvY            DW  0                       ; INWK +17
UBnkrotmatRoofvZ            DW  0                       ; INWK +19
UBnkrotmatNosevX            DW  0                       ; INWK +9
UBnkrotmatNosev             EQU UBnkrotmatNosevX
UBnkrotmatNosevY            DW  0                       ; INWK +11
UBnkrotmatNosevZ            DW  0                       ; INWK +13


UBnkspeed                   DB  0                       ; INWK +27
UBnkAccel                   DB  0                       ; INWK +28
UBnkrotXCounter             DB  0                       ; INWK +29
UBnkrotZCounter             DB  0                       ; INWK +30
UBnkexplDsp                 DB  0                       ; INWK +31 clear exploding/display state|missiles
; Flags work as follows:
; 7 - Flag ship to be killed with debris
; 6 - Invisible/Erase (also mentions Laser Firing?)
; 5 - Ship is exploding if set
; 4 -
; 3 - Display state - Plot as a Dot
; 2 - Nbr of Missiles bit 2
; 1 - Nbr of Missiles bit 1
; 0 - Nbr of Missiles bit 0
UBnkaiatkecm                DB  0                       ; INWK +32 ai_attack_univ_ecm i.e. AI type
UBnkCam0yLo                 DB  0                       ; INWK +33 ????
UBnkCam0yHi                 DB  0                       ; INWK +34?????
UbnKEnergy                  DB  0                       ; INWK +35
UbnKNewb                    DB  0                       ; INWK +36 INWK+36
; Flags work as follows:
; 7 - set then remove ship, if set then to code removes without debris
; 6 - Police ship (used to determine fuguitive status)
; 4 - Docking
; 3 - Pirate
; 2 - Angry status (e.g. space station or bounty hunter)
; 0 - Trader ship
INWKxlo                     equ UBnKxlo
INWKxhi                     equ UBnKxhi                 ; there are hi medium low as some times these are 24 bit
INWKxsgn                    equ UBnKzsgn                ; INWK+2
INWKyLo                     equ UBnKylo                 ; INWK+3 \ ylo
INWKyhi                     equ UbnKyhi                 ; Y Hi???
INWKysgn                    equ UBnKysgn                ; INWK +5
INWKzlo                     equ UbnKzlo                 ; INWK +6
INWKzhi                     equ UBnKzhi                 ; INWK +7
INWKzsgn                    equ UBnKzsgn                ; INWK +8
; Orientation Matrix [nosev x y z ] nose vector ( forward) 19 to 26
;                    [roofv x y z ] roof vector (up)
;                    [sidev x y z ] side vector (right)
INWKspeed                   equ UBnkspeed               ; INWK +27UBnkTransmat2zLo  DB  0               ; XX16+16
INWKAccel                   equ UBnkAccel               ; INWK +28          UBnkTransmat2zHi    DB  0               ; XX16+17
rotXCounter                 equ UBnkrotXCounter         ; INWK +29
rotZCounter                 equ UBnkrotZCounter         ; INWK +30UBnkDrawCam0xLo   DB  0               ; XX18+0
explDsp                     equ UBnkexplDsp             ; INWK +31 clear exploding/display state|missiles UBnkDrawCam0xHi   DB  0               ; XX18+1
aiatkecm                    equ UBnkaiatkecm            ; INWK +32 ai_attack_univ_ecm i.e. AI typeUBnkDrawCam0xSgn      DB  0               ; XX18+2
INWKDrawCam0yLo             equ UBnkDrawCam0yLo         ; INWK +33UBnkDrawCam0yLo   DB  0               ; XX18+3
INWKDrawCam0yHi             equ UBnkDrawCam0yHi         ; INWK +34UBnkDrawCam0yHi   DB  0               ; XX18+4
INWKEnergy                  equ UbnKEnergy              ; INWK +35UBnkDrawCam0ySgn      DB  0               ; XX18+5
;UBnkDrawCam0ySgn    equ UbnKEnergy              ; Reycles but not a good idea TODO
INWKNewb                    equ UbnKNewb                ; INWK +36 INWK+36 \ NEWB bit 7 remove ship?UBnkDrawCam0zLo     DB  0               ; XX18+6
;-- XX16 --------------------------------------------------------------------------------------------------------------------------
UBnkTransmatSidevX          DW  0               ; XX16+0
UBnkTransmatSidev           EQU UBnkTransmatSidevX
UBnkTransmatSidevY          DW 0                ; XX16+2
UBnkTransmatSidevZ          DW 0                ; XX16+2
UBnkTransmatRoofvX          DW 0
UBnkTransmatRoofv           EQU UBnkTransmatRoofvX
UBnkTransmatRoofvY          DW 0                ; XX16+2
UBnkTransmatRoofvZ          DW 0                ; XX16+2
UBnkTransmatNosevX          DW 0
UBnkTransmatNosev           EQU UBnkTransmatNosevX
UBnkTransmatNosevY          DW 0                ; XX16+2
UBnkTransmatNosevZ          DW 0                ; XX16+2
UbnkTransmatTransX          DW 0
UbnkTransmatTransY          DW 0
UbnkTransmatTransZ          DW 0
XX16                        equ UBnkTransmatSidev
;-- XX16Inv --------------------------------------------------------------------------------------------------------------------------
UbnkTransInvRow0x0          DW 0
UbnkTransInvRow0x1          DW 0
UbnkTransInvRow0x2          DW 0
UbnkTransInvRow0x3          DW 0
UbnkTransInvRow1y0          DW 0
UbnkTransInvRow1y1          DW 0
UbnkTransInvRow1y2          DW 0
UbnkTransInvRow1y3          DW 0
UbnkTransInvRow2z0          DW 0
UbnkTransInvRow2z1          DW 0
UbnkTransInvRow2z2          DW 0
UbnkTransInvRow2z3          DW 0

XX16Inv             equ UbnkTransInvRow0x0
;-- XX25 --------------------------------------------------------------------------------------------------------------------------
UbnkProjxLo                 DB  0
UbnkProjxHi                 DB  0
UbnkProjxSgn                DB  0
UbnkProjx                   EQU UbnkProjxLo
UbnkProjyLo                 DB  0
UbnkProjyHi                 DB  0
UbnkProjySgn                DB  0
UbnkProjy                   EQU UbnkProjyLo
UbnkProjzLo                 DB  0
UbnkProjzHi                 DB  0
UbnkProjzSgn                DB  0
UbnkProjz                   EQU UbnkProjzLo
XX25                        EQU UbnkProjxLo
;-- XX18 --------------------------------------------------------------------------------------------------------------------------
UBnkDrawCam0xLo             DB  0               ; XX18+0
UBnkDrawCam0xHi             DB  0               ; XX18+1
UBnkDrawCam0xSgn            DB  0               ; XX18+2
UBnkDrawCam0x               equ UBnkDrawCam0xLo
UBnkDrawCam0yLo             DB  0               ; XX18+3
UBnkDrawCam0yHi             DB  0               ; XX18+4
UBnkDrawCam0ySgn            DB  0               ; XX18+5
UBnkDrawCam0y               equ UBnkDrawCam0yLo
UBnkDrawCam0zLo             DB  0               ; XX18+6
UBnkDrawCam0zHi             DB  0               ; XX18+7
UBnkDrawCam0zSgn            DB  0               ; XX18+8
UBnkDrawCam0z               equ UBnkDrawCam0zLo
XX18                        equ UBnkDrawCam0xLo
; Used to make 16 bit reads a little cleaner in source code
UbnkZPoint                  DS  3
UbnkZPointLo                equ UbnkZPoint
UbnkZPointHi                equ UbnkZPoint+1
UbnkZPointSign              equ UbnkZPoint+2
;-- XX15 --------------------------------------------------------------------------------------------------------------------------
UBnkXScaled                 DB  0               ; XX15+0Xscaled
UBnkXScaledSign             DB  0               ; XX15+1xsign
UBnkYScaled                 DB  0               ; XX15+2yscaled
UBnkYScaledSign             DB  0               ; XX15+3ysign
UBnkZScaled                 DB  0               ; XX15+4zscaled
UBnkZScaledSign             DB  0               ; XX15+5zsign

XX15                        equ UBnkXScaled
XX15VecX                    equ XX15
XX15VecY                    equ XX15+1
XX15VecZ                    equ XX15+2
UbnkXPoint                  equ XX15
UbnkXPointLo                equ XX15+0
UbnkXPointHi                equ XX15+1
UbnkXPointSign              equ XX15+2
UbnkYPoint                  equ XX15+3
UbnkYPointLo                equ XX15+3
UbnkYPointHi                equ XX15+4
UbnkYPointSign              equ XX15+5
; Repurposed XX15 pre clip plines
UbnkPreClipX1               equ XX15+0
UbnkPreClipY1               equ XX15+2
UbnkPreClipX2               equ XX15+4
UbnkPreClipY2               equ XX15+6
; Repurposed XX15 post clip lines
UBnkNewX1                   equ XX15+0
UBnkNewY1                   equ XX15+1
UBnkNewX2                   equ XX15+2
UBnkNewY2                   equ XX15+3
; Repurposed XX15
regXX15fx                   equ UBnkXScaled
regXX15fxSgn                equ UBnkXScaledSign
regXX15fy                   equ UBnkYScaled
regXX15fySgn                equ UBnkYScaledSign
regXX15fz                   equ UBnkZScaled
regXX15fzSgn                equ UBnkZScaledSign
; Repurposed XX15
varX1                       equ UBnkXScaled       ; Reused, verify correct position
varY1                       equ UBnkXScaledSign   ; Reused, verify correct position
varZ1                       equ UBnkYScaled       ; Reused, verify correct position
; After clipping the coords are two 8 bit pairs
UBnkPoint1Clipped           equ UBnkXScaled
UBnkPoint2Clipped           equ UBnkYScaled
;-- transmat0 --------------------------------------------------------------------------------------------------------------------------
; Note XX12 comes after as some logic in normal processing uses XX15 and XX12 combines
UBnkXX12xLo                 DB  0               ; XX12+0
UBnkXX12xSign               DB  0               ; XX12+1
UBnkXX12yLo                 DB  0               ; XX12+2
UBnkXX12ySign               DB  0               ; XX12+3
UBnkXX12zLo                 DB  0               ; XX12+4
UBnkXX12zSign               DB  0               ; XX12+5
XX12Save                    DS  6
XX12Save2                   DS  6
XX12                        equ UBnkXX12xLo
varXX12                     equ UBnkXX12xLo
; Post clipping the results are now 8 bit
UBnkVisibility              DB  0               ; replaces general purpose xx4 in rendering

UBnkProjectedY              DB  0
UBnkProjectedX              DB  0
UBnkProjected               equ UBnkProjectedY  ; resultant projected position
XX15Save                    DS  8
XX15Save2                   DS  8
VarBackface                 DB 0
; Heap (or array) information for lines and normals
; Coords are stored XY,XY,XY,XY
; Normals
; This needs re-oprganising now.
; Runtime Calculation Store

FaceArraySize               equ 30
EdgeHeapSize                equ 40
NodeArraySize               equ 40
LineArraySize               equ 50
; Storage arrays for data
; Structure of arrays
; Visibility array  - 1 Byte per face/normal on ship model Bit 7 (or FF) visible, 0 Invisible
; Node array corresponds to a processed vertex from the ship model transformed into world coordinates and tracks the node list from model
; NodeArray         -  4 bytes per element      0           1            2          3
;                                               X Coord Lo  Y Coord Lo   Z CoordLo  Sign Bits 7 6 5 for X Y Z Signs (set = negative)
; Line Array        -  4 bytes per eleement     0           1            2          3
;                                               X1          Y1           X2         Y2
UbnkFaceVisArray            DS FaceArraySize            ; XX2 Up to 16 faces this may be normal list, each entry is controlled by bit 7, 1 visible, 0 hidden
UBnkNodeArray               DS NodeArraySize * 4        ; XX3 Holds the points as an array, its an array not a heap
UBnkNodeArray2              DS NodeArraySize * 4        ; XX3 Holds the points as an array, its an array not a heap
UbnkLineArray               DS LineArraySize * 4        ; XX19 Holds the clipped line details
UBnkLinesHeapMax            EQU $ - UbnkLineArray
UbnkEdgeProcessedList DS EdgeHeapSize
; Array current Lengths
UbnkFaceVisArrayLen         DS 1
UBnkNodeArrayLen            DS 1
UbnkLineArrayLen            DS 1                        ; total number of lines loaded to array 
UbnkLineArrayBytes          DS 1                        ; total number of bytes loaded to array  = array len * 4
XX20                        equ UbnkLineArrayLen
varXX20                     equ UbnkLineArrayLen


UbnkEdgeHeapSize            DS 1
UbnkEdgeHeapBytes           DS 1
UBnkLinesHeapLen            DS 1
UbnKEdgeHeapCounter         DS 1
UbnKEdgeRadius              DS 1
UbnKEdgeShipType            DS 1
UbnKEdgeExplosionType       DS 1

; Node heap is used to write out transformed Vertexs

; Lines
UBnkXX19                    DS  3


; Used to make 16 bit reads a little cleaner in source code



; Repurposed XX15 when plotting lines
; Repurposed XX15 before calling clip routine
UBnkX1                      equ XX15
UBnKx1Lo                    equ XX15
UBnKx1Hi                    equ XX15+1
UBnkY1                      equ XX15+2
UbnKy1Lo                    equ XX15+2
UBnkY1Hi                    equ XX15+3
UBnkX2                      equ XX15+4
UBnkX2Lo                    equ XX15+4
UBnkX2Hi                    equ XX15+5
; Repurposed XX12 when plotting lines
UBnkY2                      equ XX12+0
UbnKy2Lo                    equ XX12+0
UBnkY2Hi                    equ XX12+1
UBnkDeltaXLo                equ XX12+2
UBnkDeltaXHi                equ XX12+3
UBnkDeltaYLo                equ XX12+4
UBnkDeltaYHi                equ XX12+5
UbnkGradient                equ XX12+2
UBnkTemp1                   equ XX12+2
UBnkTemp1Lo                 equ XX12+2
UBnkTemp1Hi                 equ XX12+3
UBnkTemp2                   equ XX12+3
UBnkTemp2Lo                 equ XX12+3
UBnkTemp2Hi                 equ XX12+4

;rotmatFx            equ rotmat0xHi
;rotmatFy            equ rotmat0yHi
;rotmatFz            equ rotmat0zHi
;rotmatUx            equ rotmat1xHi
;rotmatUy            equ rotmat1yHi
;rotmatUz            equ rotmat1zHi

UbnkShipType                DB  0
        
UBnkHullCopy                DS  22
ScoopDebrisAddr             equ UBnkHullCopy + 0
MissileLockLoAddr           equ UBnkHullCopy + 1
MissileLockHiAddr           equ UBnkHullCopy + 2
EdgeAddyAddr                equ UBnkHullCopy + 3
LineX4Addr                  equ UBnkHullCopy + 5
GunVertexAddr               equ UBnkHullCopy + 6
ExplosionCtAddr             equ UBnkHullCopy + 7
VertexCtX6Addr              equ UBnkHullCopy + 8
EdgeCountAddr               equ UBnkHullCopy + 9
BountyLoAddr                equ UBnkHullCopy + 10
BountyHiAddr                equ UBnkHullCopy + 11
FaceCtX4Addr                equ UBnkHullCopy + 12
DotAddr                     equ UBnkHullCopy + 13
EnergyAddr                  equ UBnkHullCopy + 14
SpeedAddr                   equ UBnkHullCopy + 15
FaceAddyAddr                equ UBnkHullCopy + 16
QAddr                       equ UBnkHullCopy + 18
LaserAddr                   equ UBnkHullCopy + 19
VerticesAddyAddr            equ UBnkHullCopy + 20

; Static Ship Data. This is copied in when creating the universe object
XX0                         equ UBnkHullCopy        ; general hull index pointer
UBnkHullVerticies           DS  300                 ; can only be 255
UBnkHullEdges               DS  1200                ; can be 255 * 4
UBnkHullNormals             DS  300                 ; can only be 255
OrthagCountdown             DB  12

UBnkShipCopy                equ UBnkHullVerticies               ; Buffer for copy of ship data, for speed will copy to a local memory block, Cobra is around 400 bytes on creation of a new ship so should be plenty
UBnk_Data_len               EQU $ - StartOfUniv


RequAby256DivQOLD:      ld      b,a ;.LL28  BFRDIV R=A*256/Q   byte from remainder of division 
                        ld      a,(varQ)
                        ld      c,a
                        ld      a,b


ResetUBnkData:          ld      hl,StartOfUniv
                        ld      de,UBnk_Data_len
                        xor     a
                        call    memfill_dma
                        ret
   
;divdide by 16 using undocumented instrunctions
;Input: BC = Dividend, DE = Divisor, HL = 0
;Output: BC = Quotient, HL = Remainder
PROJ256mulAdivQ:        ld      b,a
                        ld      c,0
                        ld      d,0
                        ld      a,(varQ)
                        ld      e,a
PROJDIV16UNDOC:         ld      hl,0
                        ld      a,b 
                        ld      b,16
PROJDIV16UNDOCLOOP:     sll     c       ; unroll 16 times
                        rla             ; ...
                        adc     hl,hl       ; ...
                        sbc     hl,de       ; ...
                        jr      nc,PROJDIV16UNDOCSKIP       ; ...
                        add     hl,de       ; ...
                        dec     c       ; ...
PROJDIV16UNDOCSKIP:     djnz    PROJDIV16UNDOCLOOP
                        ld      a,c
                        ld      (varR),a
                        ret
;
    ;Input: BC = Dividend, DE = Divisor, HL = 0
;Output: BC = Quotient, HL = Remainder

;INPUTS:    bhl = dividend  cde = divisor where b and c are sign bytes
;OUTPUTS:   cahl = quotient cde = divisor
DVID3B2:                ld      (varPhi2),a                     ;DVID3B2 \ Divide 3 bytes by 2, K = [P(HiLo).A]/[INWK_z HiLo], for planet radius, Xreg protected. ; P+2    \ num sg
                        ldCopy2Byte UbnKzlo, varQ               ; [QR} = Ubnk zlohi  (i.e. Inwk_z HiLo)
                        ld      a,(UBnKzsgn)                    ; 
                        ld      (varS),a                        ; S = inkw z sign 
DVID3B:                 ld      de,(varP)                       ; K (3bytes)=P(Lo Hi Hi2)/S.R.Q approx  Acc equiv K(0).; get P and P+1 into de
                        ld      a,e                             ; num lo
                        or      1                               ; must be at least 1
                        ld      (varP),a                        ; store
                        ld      e,a                             ; update DE too
                        ld      a,(varPhi2)                     ; varP Sign     E.D.A = P Lo Hi Hi2
                        ld      hl,varS                         ; hl = address of VarS
                        xor     (hl)                            ; A = PHi2 Xor S Signs
                        and     $80                             ; 
                        ld      (varT),a                        ; T = Sign bit of A
                        ld      iyl,0                           ; iyl = yReg = counter
                        ld      a,(varPhi2)                     ; 
                        and     $7F                             ; A = Ph2 again but minus sign bit 
DVL9:                   JumpIfAGTENusng $40,DV14                ; counter Y up; if object is over $40 away then scaled and exit Y count
                        ShiftDELeft1                            ; de (or P,P1) > 1
                        rl      a                               ; and accumulator as 3rd byte
                        inc     iyl
                        jp      nz,DVL9                         ; loop again with a max of 256 iterations
DV14:                   ld      (varPhi2),a                     ; scaled, exited Ycount
                        ld      (varP),de                       ; store off the value so far
                        ld      a,(varS)                        ; zsign
                        and     $7F                             ; denom sg7
                        ; jp mi,DV9                             ; this can never happen as bit 7 is and'ed out
                        ld      hl,(varQ)                       ; demon lo
DVL6:                   dec     iyl                             ; counter Y back down, roll S. ;  scale Y back
                        ShiftHLLeft1
                        rl      a                               ; mulitply QRS by 2
                        jp      p,DVL6                          ; loop roll S until Abit7 set.
DV9:                    ld      (varQ),hl                       ; bmi cant enter here from above ; save off so far
                        ld      (varQ),a                        ; Q \ mostly empty so now reuse as hi denom
                        ld      a,$FE                           ;  Xreg protected so can't LL28+4
                        ld      (varR),a                        ;  R
                        ld      a,(varPhi2)                     ; P+2 \ big numerator
                        call    PROJ256mulAdivQ                 ; TODO LL31\ R now =A*256/Q
                        ld      a,0
                        ld      (varKp1),a
                        ld      (varKp2),a
                        ld      (varKp3),a                      ; clear out K+1 to K+3
                        ld      a,iyl                           ; Y counter for scale
                        JumpOnBitClear a,7,DV12                 ; Ycount +ve
                        ld      a,(varR)                        ; R     \ else Y count is -ve, Acc = remainder.
                        ld      de,(varK)                       ; d= k1
                        ld      hl,(varK2)                      ; h = k3, l = k2
                        ld      e,a                             ; use e to hold K0 pulled from a
DVL8:                   sla     a                               ; boost up a                     ;  counter Y up
                        rl      d                               ; k1
                        rl      l                               ; k2
                        rl      h                               ; k3
                        inc     iyl
                        jr      nz,DVL8                         ;
DVL8Save:               ld      (varK),de
                        ld      (varK2),hl                      ; save back K0 to k3
                        ld      a,(varT)
                        ld      c,a                             ; get varT into c reg 
                        ld      a,h                             ; a= k3 (sign)
                        or      c                               ; merge in varT (sign)that was saved much earlier up)
                        ld      (varK3),a                       ; load sign bit back into K3
                        ret
DV12:                   IfAIsZeroGoto   DV13                    ; Y Count zerp, go to DV13
                        ld      a,(varR)                        ; Reduce Remainder
DVL10:                  srl     a                               ; divide by 2                     ; counter Y reduce
                        dec     iyl
                        jp      nz,DVL10                        ; loop y reduce until y is zero
                        ld      (varK),a                        ; k Lo
                        ldCopyByte  varT,varKp3                 ; Copy sign to K+3
                        ret
DV13:                   ldCopyByte  varR,varK                   ; R \ already correct so copy to K lo;DV13   \ Ycount zero \ K(1to2) already = 0
                        ldCopyByte  varT,varKp3                 ; Copy sign to K+3
                        ret
 
    
PLS6:                   call    DVID3B2                         ; Returns AHL K ( 2 1 0 )
                        ld      a,(varKp3)
                        and     $7F
                        ld      hl,varKp2
                        or      (hl)
                        jp      nz,PL44TooBig
                        ld      a,(varKp1)
                        cp      4                               ; if high byte > 4 then total > 1024 so too big
                        jr      nc,PL44TooBig
                        ClearCarryFlag                          ; we have a good result regardless
                        ld      hl,(varK)                       ; get K (0 1)
                        ld      a,(varKp3)                      ; if sign bit high?
                        bit     7,a
                        ret     z                               ; no so we can just return
PL44:                   ret 
PL44TooBig:             scf
                        ret

;; calcs HLB + DEC where B and C are signs
;; result HL with A as sign
;; special handling if result is zero forcign sign bit to be zero
ADDHLDESignBC:          ld      a,b
                        and     SignOnly8Bit
                        xor     c                           ;if b sign and c sign were different then bit 7 of a will be 1 which means 
                        JumpIfNegative ADDHLDEsBCOppSGN     ;Signs are opposite there fore we can subtract to get difference
ADDHLDEsBCSameSigns:    ld      a,b
                        or      c
                        JumpIfNegative ADDHLDEsBCSameNeg        ; optimisation so we can just do simple add if both positive
                        add     hl,de                       ; both positive so a will already be zero
                        ret
ADDHLDEsBCSameNeg:      add     hl,de
                        ld      a,b
                        or      c                           ; now set bit for negative value, we won't bother with overflow for now TODO
                        ret
ADDHLDEsBCOppSGN:       or      a
                        sbc     hl,de
                        jr      c,ADDHLDEsBCOppInvert
ADDHLDEsBCOppSGNNoCarry: ld      a,b                                               ; we got here so hl > de therefore we can just take hl's previous sign bit
                        ret
ADDHLDEsBCOppInvert:    NegHL                         ; if result was zero then set sign to zero (which doing h or l will give us for free)
                        ld      a,b
                        xor     SignOnly8Bit                ; flip sign bit
                        ret     

ADDHLDESignedv3:        ld      a,h
                        and     SignOnly8Bit
                        ld      b,a                         ;save sign bit in b
                        xor     d                           ;if h sign and d sign were different then bit 7 of a will be 1 which means 
                        JumpIfNegative ADDHLDEOppSGN        ;Signs are opposite there fore we can subtract to get difference
ADDHLDESameSigns:       ld      a,b
                        or      d
                        JumpIfNegative ADDHLDESameNeg       ; optimisation so we can just do simple add if both positive
                        add     hl,de
                        ret
ADDHLDESameNeg:         ld      a,h                         ; so if we enter here then signs are the same so we clear the 16th bit
                        and     SignMask8Bit                ; we could check the value of b for optimisation
                        ld      h,a
                        ld      a,d
                        and     SignMask8Bit
                        ld      d,a
                        add     hl,de
                        ld      a,SignOnly8Bit
                        or      h                           ; now set bit for negative value, we won't bother with overflow for now TODO
                        ld      h,a
                        ret
ADDHLDEOppSGN:          ld      a,h                         ; so if we enter here then signs are the same so we clear the 16th bit                     ; here HL and DE are opposite 
                        and     SignMask8Bit                ; we could check the value of b for optimisation
                        ld      h,a
                        ld      a,d
                        and     SignMask8Bit
                        ld      d,a
                        or      a
                        sbc     hl,de
                        jr      c,ADDHLDEOppInvert
ADDHLDEOppSGNNoCarry:   ld      a,b                         ; we got here so hl > de therefore we can just take hl's previous sign bit
                        or      h
                        ld      h,a                         ; set the previou sign value
                        ret
ADDHLDEOppInvert:       NegHL                                                   ; we need to flip the sign and 2'c the Hl result
                        ld      a,b
                        xor     SignOnly8Bit                ; flip sign bit
                        or      h
                        ld      h,a                         ; recover sign
                        ret 
                
; we could cheat, flip the sign of DE and just add but its not very optimised
SUBHLDESignedv3:        ld      a,h
                        and     SignOnly8Bit
                        ld      b,a                         ;save sign bit in b
                        xor     d                           ;if h sign and d sign were different then bit 7 of a will be 1 which means 
                        JumpIfNegative SUBHLDEOppSGN        ;Signs are opposite therefore we can add
SUBHLDESameSigns:       ld      a,b
                        or      d
                        JumpIfNegative SUBHLDESameNeg       ; optimisation so we can just do simple add if both positive
                        or      a
                        sbc     hl,de
                        JumpIfNegative SUBHLDESameOvrFlw            
                        ret
SUBHLDESameNeg:         ld      a,h                         ; so if we enter here then signs are the same so we clear the 16th bit
                        and     SignMask8Bit                ; we could check the value of b for optimisation
                        ld      h,a
                        ld      a,d
                        and     SignMask8Bit
                        ld      d,a
                        or      a
                        sbc     hl,de
                        JumpIfNegative SUBHLDESameOvrFlw            
                        ld      a,h                         ; now set bit for negative value, we won't bother with overflow for now TODO
                        or      SignOnly8Bit
                        ld      h,a
                        ret
SUBHLDESameOvrFlw:      NegHL                                                        ; we need to flip the sign and 2'c the Hl result
                        ld      a,b
                        xor     SignOnly8Bit                ; flip sign bit
                        or      h
                        ld      h,a                         ; recover sign
                        ret         
SUBHLDEOppSGN:          or      a                                               ; here HL and DE are opposite so we can add the values
                        ld      a,h                         ; so if we enter here then signs are the same so we clear the 16th bit
                        and     SignMask8Bit                ; we could check the value of b for optimisation
                        ld      h,a
                        ld      a,d
                        and     SignMask8Bit
                        ld      d,a     
                        add     hl,de
                        ld      a,b                         ; we got here so hl > de therefore we can just take hl's previous sign bit
                        or      h
                        ld      h,a                         ; set the previou sign value
                        ret

    
SBCHLDESigned:          JumpOnBitSet h,7,SBCHLDEhlNeg
SBCHLDEhlPos:           JumpOnBitSet h,7,SBCHLDEhlNeg
SBCHLDEhlPosDePos:      sbc     hl,de                           ; ignore overflow for now will sort later TODO
                        ret
SBCHLDEhlPosDeNeg:      res     7,d
                        add     hl,de                           ; ignore overflow for now will sort later TODO
                        set     7,d
                        ret
SBCHLDEhlNeg:           res     7,h
                        JumpOnBitSet d,7,SBCHLDEhlNegdeNeg
SBCHLDEhlNegdePos:      sbc     hl,de                       ; ignore overflow for now will sort later TODO
                        set     7,h     
                        ret
SBCHLDEhlNegdeNeg:      res     7,d
                        add     hl,de                   ; ignore overflow for now will sort later TODO
                        set     7,d
                        set     7,h
                        ret
    
; Roate around axis
; varAxis1 and varAxis2 point to the address of the axis to rotate
; so the axis x1 points to roofv  x , y or z
;             x2           nosev or sidev  x, y or z
;   Axis1 = Axis1 * (1 - 1/512)  + Axis2 / 16
;   Axis2 = Axis2 * (1 - 1/512)  - Axis1 / 16
; var RAT2 gives direction  
; for pitch x we come in with Axis1 = roofv_x and Axis2 = nosev_x
;-Set up S R -----------------------------------------
; optimised we don't deal with sign here just the value of roof axis / 512
MVS5XRotateXAxis:       ld      hl,(varAxis1)   ; work on roofv axis to get (1- 1/152) * roofv axis
                        ld      e,(hl)
                        inc     hl
                        ld      d,(hl)          ; de = Axis1 (roofv x for pitch x)
                        ex      de,hl           ; hl = Axis1 (roofv x for pitch x)
                        ld      a,h
                        and     SignOnly8Bit                
                        ld      iyh,a           ; iyh = sign Axis1
                        ld      a,h
                        and     SignMask8Bit    ; a = Axis1 (roof hi axis  unsigned)
                        srl     a               ; a = Axis1/2
                        ld      e,a             ; 
                        ld      a,iyh           ; A = Axis 1 sign
                        ld      d,a             ; de = signed Axis1 / 512
                        or      a               ; clear carry
                        call    SUBHLDESignedv3 ; hl = roof axis - (roof axis /512) which in effect is roof * (1-1/512)
;-Push to stack roof axis - (roofaxis/152)  ----------------------------------------------------------------------------------
                        push    hl              ; save hl on stack PUSH ID 1 (roof axis - roofv aixs /512)
                        ld      a,l
                        ld      (varR),a
                        ld      a,h
                        ld      (varS),a        ;  RS now equals (1- 1/152) * roofv axis or (roof axis - roofv aixs /512)
;-calculate roofv latter half of calc   
                        ld      hl,(varAxis2)   ; now work on nosev axis to get nosev axis / 16
                        ld      e,(hl)
                        inc     hl
                        ld      d,(hl)          ; de = value of roof axis
                        ld      a,d
                        and     SignOnly8Bit
                        ld      iyh,a           ; save sign 
                        ld      a,d 
                        and     SignMask8Bit    ; a = nosev hi axis  unsigned
                        ld      d,a             ; de = abs (nosev)
                        ShiftDERight1
                        ShiftDERight1
                        ShiftDERight1
                        ShiftDERight1           ; de = nosev /16 unsigned
                        ld      a,(varRAT2)     ; need to consider direction, so by defautl we use rat2, but flip via sign bit
                        xor     iyh             ; get the sign back we saveded from DE in so de = nosev axis / 16 signed
                        and     SignOnly8Bit
                        or      d
                        ld      d,a             ; de = nosev /16 signed and ready as if we were doing a + or - based on RAT2            
;;; ld      a,e
;;;     or      iyh
;;; ld      (varP),a        ; PA now equals nosev axis / 16 signed
;-now AP = nosev /16  --------------------------------------------------------------------------------------------------------
                        pop     hl              ; get back RS POP ID 1
    ;ex     de,hl           ; swapping around so hl = AP and de = SR , shoud not matter though as its an add
;-now DE = (roofaxis/512) hl - abs(nosevaxis) --------------------------------------------------------------------------------
                        call    ADDHLDESignedv3 ; do add using hl and de
                        push    hl              ; we use stack to represent var K here now varK = Nosev axis /16 + (1 - 1/512) * roofv axis PUSH ID 2
;-push to stack nosev axis + roofvaxis /512  which is what roofv axis will be ------------------------------------------------  
;-- Set up SR = 1 - 1/512 * nosev-----------------------
                    ld      hl,(varAxis2)   ; work on nosev again to get nosev - novesv / 512
                    ld      e,(hl)
                    inc     hl
                    ld      d,(hl)
                    ex      de,hl
                    ld      a,h
                    and     $80
                    ld      iyh,a
                    ld      a,h
                    and     SignMask8Bit    ; a = roof hi axis  unsigned
                    srl     a               ; now A = unsigned 15 bit nosev axis hi / 2 (or in effect nosev / 512
                    ld      e,a
                    ld      a,iyh
                    ld      d,a
                    or      a               ; clear carry
                    call    SUBHLDESignedv3
;   sbc     hl,de           ; hl = nosev - novesv / 512
                    push    hl              ; save hl on stack  PUSH ID 3
                    ld      a,l
                    ld      (varP),a        ; p = low of resuilt
                    ld      a,h
                    and     SignMask8Bit    ; a = roof hi axis  unsigned
                    ld      (varT),a        ; t = high of result
;-- Set up TQ
                    ld      hl,(varAxis1)   ; now work on roofv axis / 16
;   ld      hl,(varAxis2)   ; work on nosev again 
                    ld      e,(hl)
                    inc     hl
                    ld      d,(hl)
                    ld      a,d
                    and     $80
                    ld      iyh,a           ; save sign 
                    ld      a,d
                    and     SignMask8Bit    ; a = nosev hi axis  unsigned
                    ld      d,a             ; de = abs (nosev)
                    ShiftDERight1
                    ShiftDERight1
                    ShiftDERight1
                    ShiftDERight1           ; de = nosev /16 unsigned
                    ld      a,(varRAT2)
                    xor     iyh             ; get the sign back in so de = nosev axis / 16 signed
                    and     $80
                    or      d
                    ld      d,a
;;; ld      a,e
;;;     or      iyh
;;; ld      (varP),a        ; PA now equals nosev axis / 16 signed
                    pop     hl              ; get back RS   POP ID 3
;   ex      de,hl           ; swapping around so hl = AP and de = SR , shoud not matter though as its an add
                    call    SUBHLDESignedv3 ; do add using hl and de
;-- Update nosev ---------------------------------------
                    ex      de,hl           ; save hl to de
                    ld      hl,(varAxis2)
                    ld      (hl),e
                    inc     hl
                    ld      (hl),d          ; copy result into nosev
;-- Update roofv ---------------------------------------
                    pop     de              ; get calc saved on stack POP ID 2
                    ld      hl,(varAxis1)
                    ld      (hl),e
                    inc     hl
                    ld      (hl),d          ; copy result into nosev
                    ret
    
                    include "Universe/InitialiseOrientation.asm"
;----------------------------------------------------------------------------------------------------------------------------------
OrientateVertex:

;                      [ sidev_x sidev_y sidev_z ]   [ x ]
;  projected [x y z] = [ roofv_x roofv_y roofv_z ] . [ y ]
;                      [ nosev_x nosev_y nosev_z ]   [ z ]
;

;----------------------------------------------------------------------------------------------------------------------------------
TransposeVertex:
;                      [ sidev_x roofv_x nosev_x ]   [ x ]
;  projected [x y z] = [ sidev_y roofv_y nosev_y ] . [ y ]
;                      [ sidev_z roofv_z nosev_z ]   [ z ]
VectorToVertex:
;                     [ sidev_x roofv_x nosev_x ]   [ x ]   [ x ]
;  vector to vertex = [ sidev_y roofv_y nosev_y ] . [ y ] + [ y ]
;                     [ sidev_z roofv_z nosev_z ]   [ z ]   [ z ]

Project:
PROJ:                   ld      hl,(UBnKxlo)                    ; Project K+INWK(x,y)/z to K3,K4 for center to screen
                        ld      (varP),hl
                        ld      a,(UBnKxsgn)
                        call    PLS6                            ; returns result in K (0 1) (unsigned) and K (3) = sign note to no longer does 2's C
                        ret     c                               ; carry means don't print
                        ld      hl,(varK)                       ; hl = k (0 1)
                        ; Now the question is as hl is the fractional part, should this be multiplied by 127 to get the actual range
                        ld      a,ViewCenterX
                        add     hl,a                            ; add unsigned a to the 2's C HL to get pixel position
                        ld      (varK3),hl                      ; K3 = X position on screen
ProjectY:               ld      hl,(UBnKylo)
                        ld      (varP),hl
                        ld      a,(UBnKysgn)
                        call    PLS6
                        ret     c
                        ld      hl,(varK)                       ; hl = k (0 1)
                        ld      a,ViewCenterY
                        add     hl,a                            ; add unsigned a to the 2's C HL to get pixel position
                        ld      (varK4),hl                      ; K3 = X position on screen
                        ret
;--------------------------------------------------------------------------------------------------------
                        include "ModelRender/EraseOldLines-EE51.asm"
                        include "ModelRender/TrimToScreenGrad-LL118.asm"
                        include "ModelRender/CLIP-LL145.asm"
;--------------------------------------------------------------------------------------------------------
                        include "Universe/CopyRotmatToTransMat.asm"
;--------------------------------------------------------------------------------------------------------
SetFaceAVisible:        ld      hl,UbnkFaceVisArray
                        add     hl,a
                        ld      a,$FF
                        ld      (hl),a
                        ret
;--------------------------------------------------------------------------------------------------------
SetFaceAHidden:         ld      hl,UbnkFaceVisArray
                        add     hl,a
                        xor     a
                        ld      (hl),a
                        ret
;--------------------------------------------------------------------------------------------------------
SetAllFacesVisible:     ld      a,(FaceCtX4Addr)            ; (XX0),Y which is XX0[0C] or UBnkHullCopy+FaceCtX4Addr                                 ;;; Faces count (previously loaded into b up front but no need to shave bytes for clarity
                        srl     a                           ; else do explosion needs all vertices                                                  ;;;
                        srl     a                           ;  /=4  TODO add this into blueprint data for speed                                                           ;;; For loop = 15 to 0
                        ld      b,a                         ; b = Xreg = number of normals, faces
                        ld      hl,UbnkFaceVisArray
                        ld      a,$FF
SetAllFacesVisibleLoop:
EE30:                   ld      (hl),a
                        inc     hl
                        djnz    SetAllFacesVisibleLoop
                        ret
;--------------------------------------------------------------------------------------------------------
SetAllFacesHidden:      ld      a,(FaceCtX4Addr)            ; (XX0),Y which is XX0[0C] or UBnkHullCopy+ShipHullFacesCount                           ;;; Faces count (previously loaded into b up front but no need to shave bytes for clarity
                        srl     a                           ; else do explosion needs all vertices                                                  ;;;
                        srl     a                           ;  /=4                                                                                  ;;; For loop = 15 to 0
                        ld      b,a                         ; b = Xreg = number of normals, faces
                        ld      b,16
                        ld      hl,UbnkFaceVisArray
                        ld      a,$00
SetAllFacesHiddenLoop:  ld      (hl),a
                        inc     hl
                        djnz    SetAllFacesHiddenLoop
                        ret

;;;;X = normal scale
;;;;ZtempHi = zhi
;;;;......................................................
;;;; if ztemp hi <> 0                                   ::Scale Object Distance
;;;;  Loop                                              ::LL90
;;;;     inc X
;;;;     divide X, Y & ZtempHiLo by 2
;;;;  Until ZtempHi = 0
;;;;......................................................
;-LL21---------------------------------------------------------------------------------------------------
                        include "Universe/NormaliseTransMat.asm"
;-LL91---------------------------------------------------------------------------------------------------
LoadCraftToCamera:      ld      hl,UBnKxlo
                        ld      de,UBnkDrawCam0xLo
                        NineLDIInstrunctions                ; transfer 9 bytes
                        ret
; Now we have
;   * XX18(2 1 0) = (x_sign x_hi x_lo)
;   * XX18(5 4 3) = (y_sign y_hi y_lo)
;   * XX18(8 7 6) = (z_sign z_hi z_lo)
;
;--------------------------------------------------------------------------------------------------------
                        include "Universe/InverseXX16.asm"
;--------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------
;   XX12(1 0) = [x y z] . sidev  = (dot_sidev_sign dot_sidev_lo)  = dot_sidev
;   XX12(3 2) = [x y z] . roofv  = (dot_roofv_sign dot_roofv_lo)  = dot_roofv
;   XX12(5 4) = [x y z] . nosev  = (dot_nosev_sign dot_nosev_lo)  = dot_nosev
; Returns
;
;   XX12(1 0)            The dot product of [x y z] vector with the sidev (or _x)
;                        vector, with the sign in XX12+1 and magnitude in XX12
;
;   XX12(3 2)            The dot product of [x y z] vector with the roofv (or _y)
;                        vector, with the sign in XX12+3 and magnitude in XX12+2
;
;   XX12(5 4)            The dot product of [x y z] vector with the nosev (or _z)
;                        vector, with the sign in XX12+5 and magnitude in XX12+4
XXCURRENTN0equN1byN2div256: MACRO param1, param2, param3
                        ld      c,0
                        ld      a,param3                      ; 
                        bit     7,a
                        jr      z,.val2Pos
;HandleSignebits
                        neg
                        ld      c,$80
.val2Pos:               ld      e,a                         ; use e as var Q = value of XX15 [n] lo
                        ld      a,param2                        ; A = XX16 element
                        bit     7,a
                        jr      z,.val1Pos
;HandleSignebits
                        neg
                        ld      b,a
                        ld      a,c
                        xor     $80
                        ld      c,a
                        ld      a,b
.val1Pos:               ld      d,a
;AequAmulQdiv256:
                        mul
                        ld      a,c
                        bit     7,a
                        ld      a,d                         ; we get only the high byte which is like doing a /256 if we think of a as low                
                        jr      z,.resultPos
                        neg
.resultPos:             ld      (param1),a                      ; Q         ; result variable = XX16[n] * XX15[n]/256
                        ENDM
                
AequN1xorN2:            MACRO  param1,param2
                        ld      a,(param1)
                        xor     param2
                        ENDM

N0equN1byN2div256:      MACRO param1,param2,param3
                        ld      a,param3                        ; 
                        ld      e,a                         ; use e as var Q = value of XX15 [n] lo
                        ld      a,param2                        ; A = XX16 element
                        ld      d,a
                        mul
                        ld      a,d                         ; we get only the high byte which is like doing a /256 if we think of a as low                
                        ld      (param1),a                      ; Q         ; result variable = XX16[n] * XX15[n]/256
                        ENDM

 ; TESTEDOK
XX12DotOneRow:
XX12CalcX:              N0equN1byN2div256 varT, (hl), (UBnkXScaled)       ; T = (hl) * regXX15fx /256 
                        inc     hl                                  ; move to sign byte
XX12CalcXSign:          AequN1xorN2 UBnkXScaledSign,(hl)             ;
                        ld      (varS),a                            ; Set S to the sign of x_sign * sidev_x
                        inc     hl
XX12CalcY:              N0equN1byN2div256 varQ, (hl),(UBnkYScaled)       ; Q = XX16 * XX15 /256 using varQ to hold regXX15fx
                        ldCopyByte varT,varR                        ; R = T =  |sidev_x| * x_lo / 256
                        inc     hl
                        AequN1xorN2 UBnkYScaledSign,(hl)             ; Set A to the sign of y_sign * sidev_y
; (S)A = |sidev_x| * x_lo / 256  = |sidev_x| * x_lo + |sidev_y| * y_lo
STequSRplusAQ           push    hl
                        call    baddll38                            ; JSR &4812 \ LL38   \ BADD(S)A=R+Q(SA) \ 1byte add (subtract)
                        pop     hl
                        ld      (varT),a                            ; T = |sidev_x| * x_lo + |sidev_y| * y_lo
                        inc     hl
XX12CalcZ:              N0equN1byN2div256 varQ,(hl),(UBnkZScaled)       ; Q = |sidev_z| * z_lo / 256
                        ldCopyByte varT,varR                        ; R = |sidev_x| * x_lo + |sidev_y| * y_lo
                        inc     hl
                        AequN1xorN2 UBnkZScaledSign,(hl)             ; A = sign of z_sign * sidev_z
; (S)A= |sidev_x| * x_lo + |sidev_y| * y_lo + |sidev_z| * z_lo        
                        call    baddll38                            ; JSR &4812 \ LL38   \ BADD(S)A=R+Q(SA)   \ 1byte add (subtract)
; Now we exit with A = result S = Sign        
                        ret

; added where sign is separate byte
;;;XX12DotOneRowV2:        
;;;XX12CalcXV2:
;;;        ld      a,(hl)
;;;        ld      de,(UBnkXScaled)
;;;        ld      b,d
;;;        ld      d,a
;;;        mul
;;;        ld      a,e
;;;        ld      (varT),a
;;;XX12CalcXSignV2:
;;;        inc     hl
;;;        ld      a,(hl)
;;;        xor     b
;;;        ld      (varS),a
;;;XX12CalcYV2:
;;;        inc     hl
;;;        ld      de,(UBnkYScaled)
;;;        ld      b,d
;;;        ld      d,a
;;;        mul
;;;        ld      a,e
;;;        ld      (varQ),a
;;;        ld      a,(varT)
;;;        ld      (varR),a
;;;XX12CalcYSignV2:
;;;        inc     hl
;;;        ld      a,(hl)
;;;        xor     b
;;;        ld      (varS),a
;;;XX12CalcXPlusYV2:
;;;        push    hl
;;;        call    baddll38                            ; JSR &4812 \ LL38   \ BADD(S)A=R+Q(SA) \ 1byte add (subtract)
;;;        pop     hl
;;;        ld      (varT),a                            ; var S already holds sign
;;;       ret


;-- LL51---------------------------------------------------------------------------------------------------------------------------
;TESTED OK
XX12EquXX15DotProductXX16:
XX12EquScaleDotOrientation:                         ; .LL51 \ -> &4832 \ XX12=XX15.XX16  each vector is 16-bit x,y,z
                        ld      bc,0                                ; LDX, LDY 0
                        ld      hl,UBnkTransmatSidevX     
                        call    XX12DotOneRow
                        ld      (UBnkXX12xLo),a
                        ld      a,(varS)
                        ld      (UBnkXX12xSign),a
                        ld      hl,UBnkTransmatRoofvX     
                        call    XX12DotOneRow
                        ld      (UBnkXX12yLo),a
                        ld      a,(varS)
                        ld      (UBnkXX12ySign),a
                        ld      hl,UBnkTransmatNosevX     
                        call    XX12DotOneRow
                        ld      (UBnkXX12zLo),a
                        ld      a,(varS)
                        ld      (UBnkXX12zSign),a
                        ret
;--------------------------------------------------------------------------------------------------------
                        include "Universe/CopyXX12ScaledToXX18.asm"
;--------------------------------------------------------------------------------------------------------
                        include "Universe/CopyXX18toXX15.asm"
;--------------------------------------------------------------------------------------------------------
                        include "Universe/CopyXX18ScaledToXX15.asm"
;--------------------------------------------------------------------------------------------------------
                        include "Universe/CopyXX12ToScaled.asm"
;--------------------------------------------------------------------------------------------------------
                        include "Universe/DotProductXX12XX15.asm"
;--------------------------------------------------------------------------------------------------------
; scale Normal. IXL is xReg and A is loaded with XX17 holds the scale factor to apply
                        include "Universe/ScaleNormal.asm"
;--------------------------------------------------------------------------------------------------------
                        include "Universe/ScaleObjectDistance.asm"
;--------------------------------------------------------------------------------------------------------
; Copy ship pos to camera work vector
ShipPosToXX18:          ld  hl,UBnKxlo
                        ld  de,UBnkDrawCam0xLo
                        ld  bc,9
                        ldir
                        ret
; Backface cull        
; is the angle between the ship -> camera vector and the normal of the face as long as both are unit vectors soo we can check that normal z > 0
; normal vector = cross product of ship ccordinates 
;
CopyFaceToXX15:         ld      a,(hl)                      ; get Normal byte 0                                                                    ;;;     if visibility (bits 4 to 0 of byte 0) > XX4
                        ld      b,a                                                    ;;;      
                        and     $80
                        ld      (UBnkXScaledSign),a           ; write Sign bits to x sign                                                            ;;;
                        ld      a,b
                        sla     a                           ; move y sign to bit 7                                                                 ;;;   copy sign bits to XX12
                        ld      b,a
                        and     $80
                        ld      (UBnkYScaledSign),a           ;                                                                                      ;;;
                        ld      a,b
                        sla     a                           ; move y sign to bit 7                                                                 ;;;   copy sign bits to XX12
                        and     $80
                        ld      (UBnkZScaledSign),a           ;                                                                                      ;;;
                        inc     hl                          ; move to X ccord
                        ld      a,(hl)                      ;                                                                                      ;;;   XX12 x,y,z lo = Normal[loop].x,y,z
                        ld      (UBnkXScaled),a                                                                                                    ;;;
                        inc     hl                                                                                                                 ;;;
                        ld      a,(hl)                      ;                                                                                      ;;;
                        ld      (UBnkYScaled),a                                                                                                    ;;;
                        inc     hl                                                                                                                 ;;;
                        ld      a,(hl)                      ;                                                                                      ;;;
                        ld      (UBnkZScaled),a     
                        ret
               
CopyFaceToXX12:         ld      a,(hl)                      ; get Normal byte 0                                                                    ;;;     if visibility (bits 4 to 0 of byte 0) > XX4
                        ld      b,a                         ; save sign bits to b
                        and     $80
                        ld      (UBnkXX12xSign),a           ; write Sign bits to x sign                                                            ;;;
                        ld      a,b
                        sla     a                           ; move y sign to bit 7                                                                 ;;;   copy sign bits to XX12
                        ld      b,a        
                        and     $80
                        ld      (UBnkXX12ySign),a           ;                                                                                      ;;;
                        ld      a,b
                        sla     a                           ; move y sign to bit 7                                                                 ;;;   copy sign bits to XX12
                        and     $80
                        ld      (UBnkXX12zSign),a           ;                                                                                      ;;;
                        inc     hl                          ; move to X ccord
                        ld      a,(hl)                      ;                                                                                      ;;;   XX12 x,y,z lo = Normal[loop].x,y,z
                        ld      (UBnkXX12xLo),a                                                                                                    ;;;
                        inc     hl                                                                                                                 ;;;
                        ld      a,(hl)                      ;                                                                                      ;;;
                        ld      (UBnkXX12yLo),a                                                                                                    ;;;
                        inc     hl                                                                                                                 ;;;
                        ld      a,(hl)                      ;                                                                                      ;;;
                        ld      (UBnkXX12zLo),a     
                        ret
      
;--------------------------------------------------------------
; Original loginc in EE29 (LL9 4 of 12)
; Enters with XX4 = z distnace scaled to 1 .. 31
; get number of faces * 4      FaceCntX4
; return if no faces
; get Face Normal scale factor FaceScale (XX17)
; get ship pos z hi     (XX18)
; While Z hi <> 0
;    FaceScale = FaceScale + 1           (XX17)
;    Ship pos y = ship pos y / 2         (XX18)
;    ship pos x = ship pos x / 2         (XX18)
;    ship pos z = ship pos z / 2         (XX18)
; Loop
; Copy Ship Pos (XX18) to Scaled         (XX15)
; Get Dot Product of Scaled (XX15) and XX16 (pre inverted) into XX12
; Copy XX12 into XX18
; For each face
;     Get Face sign and visibility distance byte 
;     if normal visibility range  < XX4
;        Get Face data into XX12
;        if FaceScale (XX17) >= 4                           
;            Copy Ship Pos (XX18) to scaled (XX15)                                                                  ::LL143
;        else
;           Copy FaceScale scaled to X  (XX17)
;LabelOverflowLoop:
;           Copy FaceData (XX12) to Scaled (XX15)                                                                   ::LL92
;           While X >= 0
;              X--                                                                                                  ::LL93
;              if  x >= 0
;                  XX15x = XX15x / 2
;                  XX15y = XX15y / 2
;                  XX15y = XX15y / 2
;           loop 
;           AddZ = FaceData (XX12)z +  ShipPos (XX18)z                                                              ::LL94
;           if A > 256 (i.e. was overflow)
;               ShipPos (XX18)x,y & z = ShipPos(XX18)x,y & z / 2 (Divide each component by 2)
;               X = 1
;               Goto LabelOverflowLoop
;           else
;              Scaled (XX15) Z = AddZ
;           endif
;           AddX = FaceData (XX12)x +  ShipPos (XX18)x
;           if A > 256 (i.e. was overflow)
;               ShipPos (XX18)x,y & z = ShipPos(XX18)x,y & z / 2 (Divide each component by 2)
;               X = 1
;               Goto LabelOverflowLoop
;           else
;              Scaled (XX15) X = AddX
;           endif
;           AddY = FaceData (XX12)y +  ShipPos (XX18)y
;           if A > 256 (i.e. was overflow)
;               ShipPos (XX18)x,y & z = ShipPos(XX18)x,y & z / 2 (Divide each component by 2)
;               X = 1
;               Goto LabelOverflowLoop
;           else
;              Scaled (XX15) Y = AddY
;           endif
;        endif
;        calculate dot product XX12.XX15  (XX15x * XX12x /256 + XX15y * XX12y /256 + XX15z * XX12z /256)        ::LL89
;        if dot product < 0
;           set face visible
;        else
;           set face invisible
;        end if
;     else
;       Set FaceVisibility to true
;     end if
; Next Face     

ScaleDownXX15byIXH:     dec     ixh
                        ret     m
                        ld      hl,UBnkXScaled
                        srl     (hl)                        ; XX15  \ xnormal lo/2 \ LL93+3 \ counter X
                        inc     hl                          ; looking at XX15 x sign now
                        inc     hl                          ; looking at XX15 y Lo now
                        srl     (hl)                        ; XX15+2    \ ynormal lo/2
                        inc     hl                          ; looking at XX15 y sign now
                        inc     hl                          ; looking at XX15 z Lo now
                        srl     (hl)
                        jp      ScaleDownXX15byIXH
                        ret

DivideXX18By2:          ld      hl,UBnkDrawCam0xLo
                        srl     (hl)                        ; XX18  \ xnormal lo/2 \ LL93+3 \ counter X
                        inc     hl                          ; looking at XX18 x sign now
                        inc     hl                          ; looking at XX18 y Lo now
                        srl     (hl)                        ; XX18+2    \ ynormal lo/2
                        inc     hl                          ; looking at XX18 y sign now
                        inc     hl                          ; looking at XX18 z Lo now
                        srl     (hl)
                        ret

;line of sight vector = [x y z] + face normal vector

;               [ [x y z] . sidev + normal_x ]   [ normal_x ]
;  visibility = [ [x y z] . roofv + normal_y ] . [ normal_y ]
;               [ [x y z] . nosev + normal_z ]   [ normal_z ]
;
;--------------------------------------------------------------
; line of sight (eye outwards dot face normal vector < 0
; So lin eof sight = vector from 0,0,0 to ship pos, now we need to consider teh ship's facing
; now if we add teh veector for teh normal(times magnitude)) to teh ship position we have the true center of the face
; now we can calcualt teh dot product of this caulated vector and teh normal which if < 0 is goot. this means we use rot mat not inverted rotmat.

RotateXX15ByTransMatXX16:
                        ld      hl,UBnkTransmatSidevX               ; process orientation matrix row 0
                        call    XX12ProcessOneRow
                        ld      b,a                                 ; get 
                        ld      a,l
                        or      b
                        ld      (UBnkXX12xSign),a                   ; a = result with sign in bit 7
                        ld      a,l
                        ld      (UBnkXX12xLo),a                     ; that is result done for

                        ld      hl,UBnkTransmatRoofvX               ; process orientation matrix row 0
                        call    XX12ProcessOneRow
                        ld      b,a                                 ; get 
                        ld      a,l
                        or      b
                        ld      (UBnkXX12ySign),a                   ; a = result with sign in bit 7
                        ld      a,l
                        ld      (UBnkXX12yLo),a                     ; that is result done for
                 
                        ld      hl,UBnkTransmatNosevX               ; process orientation matrix row 0
                        call    XX12ProcessOneRow
                        ld      b,a                                 ; get 
                        ld      a,l
                        or      b
                        ld      (UBnkXX12zSign),a                   ; a = result with sign in bit 7
                        ld      a,l
                        ld      (UBnkXX12zLo),a                     ; that is result done for
                        ret


CurrentNormIdx  DB 0
BackFaceCull:
SomeFacesVisible:   
;debug:jp debug                       
EE29:                                      
; DEBUG  force for now
;                        ld     a,MaxVisibility                 ; max visibility                                               ;;;; default max visibility
;                        ld     (LastNormalVisible),a           ; XX4                                                          ;;;;                                    
;
; DEBUG        
        call    ShipPosToXX18; 
        ReturnIfMemisZero FaceCtX4Addr                                  ; get number of faces * 4      FaceCntX4 &  return if no faces
        ld      (varXX20),a                
        ;DEBUGcall    ScaleObjectDistance                                     ; get Face Normal scale factor FaceScale into XX17
        ld      a,c                                                     ; return and setup XX17 with the adjusted Q
        ld      (varXX17),a                 
      ;  call    CopyXX18ScaledToXX15                                    ; Copy Ship Pos (XX18) to Scaled         (XX15)
        call    CopyRotmatToTransMat                                    ; Get rotation matrix into tranlation matrix
        call    ScaleXX16Matrix197  ; JSUT A TODO DEBUG TEST            ; scaling just tidies it up as per point calcs
      
 
        ld      hl,UBnkHullNormals                                                                                                 ;;; V = address of Normal start
        ld      (varV),hl  
        ld      a,(FaceCtX4Addr)                                        ; For each face
        srl     a                                                       ;
        srl     a                                                       ;
        ld      b,a                                                     ;
        xor     a
        ld      (CurrentNormIdx),a                                                   ; used to increment up face incdex as b decrements
ProcessNormalsLoop:                                                     ;
        push    hl
        push    bc
        ld      a,(hl)                                                  ;     Get Face sign and visibility distance byte 
        and     $1F                                                     ;     if normal visibility range  < XX4
        ;JumpIfAGTENusng c,FaceVisible                                   ; commented out for debuggging the skip 

        call    CopyFaceToXX15                                          ;        Get Face data into XX12
        ld      a,(UBnkXScaledSign)    
        call    XX12EquNodeDotOrientation        
        ld      a,(UBnkXX12zSign)
        test    $80
        jp      nz, FaceVisible                                         ;        if dot product < 0 set face visible
;        jp      FaceNotVisible
                                 ;        if dot product < 0 set face visible
FaceNotVisible:                                                         ;        else
        ld          a,(CurrentNormIdx)
        call        SetFaceAHidden                                      ;           set face invisible
        jp          ProcessNormalLoopEnd                                ;        end if
FaceVisible:
        ld          a,(CurrentNormIdx)
        call        SetFaceAVisible
ProcessNormalLoopEnd:
        ld          hl, CurrentNormIdx
        inc         (hl)                    ; move index pointer up by one
        pop         bc
        pop         hl                      ; get normal data pointer back
        ld          a,4
        add         hl,a                    ; move to next normal entry
        ld          (varV),hl               ; save as we need it again
        dec         b
        jp          nz,ProcessNormalsLoop
        ret                                 ; If Y >= XX20 all normals' visibilities set, onto Transpose. return
;--------------------------------------------------------------------------------------------------------
; Process edges
; .....................................................
TransposeNodeVal:   MACRO arg0?
        ldCopyByte  UBnK\0sgn,Ubnk\1PointSign           ; UBnkXSgn => XX15+2 x sign
        ld          bc,(UBnkXX12\0Lo)                   ; c = lo, b = sign   XX12XLoSign
        xor         b                                   ; a = UBnkKxsgn (or XX15+2) here and b = XX12xsign,  XX12+1 \ rotated xnode h                                                                             ;;;           a = a XOR XX12+1                              XCALC
        jp          m,NodeNegative\1                                                                                                                                                            ;;;           if sign is +ve                        ::LL52   XCALC
; XX15 [0,1] = INWK[0]+ XX12[0] + 256*INWK[1]                                                                                       ;;;          while any of x,y & z hi <> 0 
NodeXPositive\1:
        ld          a,c                                 ; We picked up XX12+0 above in bc Xlo
        ld          b,0                                 ; but only want to work on xlo                                                           ;;;              XX15xHiLo = XX12HiLo + xpos lo             XCALC
        ld          hl,(UBnK\0lo)                       ; hl = XX1 UBNKxLo
        ld          h,0                                 ; but we don;t want the sign
        add         hl,bc                               ; its a 16 bit add
        ld          (Ubnk\1Point),hl                    ; And written to XX15 0,1 
        xor         a                                   ; we want to write 0 as sign bit (not in original code)
        ld          (UbnkXPointSign),a
        jp          FinishedThisNode\1
; If we get here then _sign and vertv_ have different signs so do subtract
NodeNegative\1:        
LL52\1:                                                 ;
        ld          hl,(UBnK\0lo)                       ; Coord
        ld          bc,(UBnkXX12\0Lo)                   ; XX12
        ld          b,0                                 ; XX12 lo byte only
        sbc         hl,bc                               ; hl = UBnKx - UBnkXX12xLo
        jp          p,SetAndMop\1                       ; if result is positive skip to write back
NodeXNegSignChange\1:        
; If we get here the result is 2'c compliment so we reverse it and flip sign
        call        negate16hl                          ; Convert back to positive and flip sign
        ld          a,(Ubnk\1PointSign)                 ; XX15+2
        xor         $80                                 ; Flip bit 7
        ld          (Ubnk\1PointSign),a                 ; XX15+2
SetAndMop\1:                             
        ld          (UBnK\0lo),hl                       ; XX15+0
FinishedThisNode\1
                    ENDM
                    
;------------------------------------------------------------------------------------------------------------------------------
CopyByteAtNextHL:   MACRO targetaddr
                    inc         hl                                  ; vertex byte#1
                    ld          a,(hl)                              ;
                    ld          (targetaddr),a                     ; XX15+2 = (V),Y
                    ENDM
;--LL52 to LL55-----------------------------------------------------------------------------------------------------------------                    

TransposeXX12NodeToXX15:
        ldCopyByte  UBnKxsgn,UbnkXPointSign           ; UBnkXSgn => XX15+2 x sign
        ld          bc,(UBnkXX12xLo)                   ; c = lo, b = sign   XX12XLoSign
        xor         b                                   ; a = UBnkKxsgn (or XX15+2) here and b = XX12xsign,  XX12+1 \ rotated xnode h                                                                             ;;;           a = a XOR XX12+1                              XCALC
        jp          m,NodeNegativeX                                                                                                                                                            ;;;           if sign is +ve                        ::LL52   XCALC
; XX15 [0,1] = INWK[0]+ XX12[0] + 256*INWK[1]                                                                                       ;;;          while any of x,y & z hi <> 0 
NodeXPositiveX:
        ld          a,c                                 ; We picked up XX12+0 above in bc Xlo
        ld          b,0                                 ; but only want to work on xlo                                                           ;;;              XX15xHiLo = XX12HiLo + xpos lo             XCALC
        ld          hl,(UBnKxlo)                       ; hl = XX1 UBNKxLo
        ld          h,0                                 ; but we don;t want the sign
        add         hl,bc                               ; its a 16 bit add
        ld          (UbnkXPoint),hl                    ; And written to XX15 0,1 
        xor         a                                   ; we want to write 0 as sign bit (not in original code)
        ld          (UbnkXPointSign),a
        jp          FinishedThisNodeX
; If we get here then _sign and vertv_ have different signs so do subtract
NodeNegativeX:        
LL52X:                                                 ;
        ld          hl,(UBnKxlo)                       ; Coord
        ld          bc,(UBnkXX12xLo)                   ; XX12
        ld          b,0                                 ; XX12 lo byte only
        sbc         hl,bc                               ; hl = UBnKx - UBnkXX12xLo
        jp          p,SetAndMopX                       ; if result is positive skip to write back
NodeXNegSignChangeX:        
; If we get here the result is 2'c compliment so we reverse it and flip sign
        call        negate16hl                          ; Convert back to positive and flip sign
        ld          a,(UbnkXPointSign)                 ; XX15+2
        xor         $80                                 ; Flip bit 7
        ld          (UbnkXPointSign),a                 ; XX15+2
SetAndMopX:                             
        ld          (UBnKxlo),hl                       ; XX15+0
FinishedThisNodeX:

LL53:

        ldCopyByte  UBnKysgn,UbnkYPointSign           ; UBnkXSgn => XX15+2 x sign
        ld          bc,(UBnkXX12yLo)                   ; c = lo, b = sign   XX12XLoSign
        xor         b                                   ; a = UBnkKxsgn (or XX15+2) here and b = XX12xsign,  XX12+1 \ rotated xnode h                                                                             ;;;           a = a XOR XX12+1                              XCALC
        jp          m,NodeNegativeY                                                                                                                                                            ;;;           if sign is +ve                        ::LL52   XCALC
; XX15 [0,1] = INWK[0]+ XX12[0] + 256*INWK[1]                                                                                       ;;;          while any of x,y & z hi <> 0 
NodeXPositiveY:
        ld          a,c                                 ; We picked up XX12+0 above in bc Xlo
        ld          b,0                                 ; but only want to work on xlo                                                           ;;;              XX15xHiLo = XX12HiLo + xpos lo             XCALC
        ld          hl,(UBnKylo)                       ; hl = XX1 UBNKxLo
        ld          h,0                                 ; but we don;t want the sign
        add         hl,bc                               ; its a 16 bit add
        ld          (UbnkYPoint),hl                    ; And written to XX15 0,1 
        xor         a                                   ; we want to write 0 as sign bit (not in original code)
        ld          (UbnkXPointSign),a
        jp          FinishedThisNodeY
; If we get here then _sign and vertv_ have different signs so do subtract
NodeNegativeY:        
LL52Y:                                                 ;
        ld          hl,(UBnKylo)                       ; Coord
        ld          bc,(UBnkXX12yLo)                   ; XX12
        ld          b,0                                 ; XX12 lo byte only
        sbc         hl,bc                               ; hl = UBnKx - UBnkXX12xLo
        jp          p,SetAndMopY                       ; if result is positive skip to write back
NodeXNegSignChangeY:        
; If we get here the result is 2'c compliment so we reverse it and flip sign
        call        negate16hl                          ; Convert back to positive and flip sign
        ld          a,(UbnkYPointSign)                 ; XX15+2
        xor         $80                                 ; Flip bit 7
        ld          (UbnkYPointSign),a                 ; XX15+2
SetAndMopY:                             
        ld          (UBnKylo),hl                       ; XX15+0
FinishedThisNodeY:
    

TransposeZ:
LL55:                                                   ; Both y signs arrive here, Onto z                                          ;;;
        ld          a,(UBnkXX12zSign)                   ; XX12+5    \ rotated znode hi                                              ;;;
        JumpOnBitSet a,7,NegativeNodeZ                    ; LL56 -ve Z node                                                           ;;;
        ld          a,(UBnkXX12zLo)                     ; XX12+4 \ rotated znode lo                                                 ;;;
        ld          hl,(UbnKzlo)                        ; INWK+6    \ zorg lo                                                       ;;;
        add         hl,a                                ; hl = INWKZ + XX12z                                                        ;;;
        ld          a,l
        ld          (varT),a                            ;                                                                           ;;;
        ld          a,h
        ld          (varU),a                            ; now z = hl or U(hi).T(lo)                                                 ;;;
        ret                                             ; LL57  \ Node additions done, z = U.T                                      ;;;
; Doing additions and scalings for each visible node around here                                                                    ;;;
NegativeNodeZ:
LL56:                                                   ; Enter XX12+5 -ve Z node case  from above                                  ;;;
        ld          hl,(UbnKzlo)                        ; INWK+6 \ z org lo                                                         ;;;
        ld          bc,(UBnkXX12zLo)                    ; XX12+4    \ rotated z node lo                                                 ......................................................
        ld          b,0                                 ; upper byte will be garbage
        ClearCarryFlag
        sbc         hl,bc                               ; 6502 used carry flag compliment
        ld          a,l
        ld          (varT),a                            ; t = result low
        ld          a,h
        ld          (varU),a                            ; u = result high
        jp          po,MakeNodeClose                    ; no overflow to parity would be clear
LL56Overflow:
        cp          0                                   ; is varU 0?
        jr          nz,NodeAdditionsDone                ; Enter Node additions done, UT=z
        ld          a,(varT)                            ; T \ restore z lo
        ReturnIfAGTENusng 4                              ; >= 4 ? zlo big enough, Enter Node additions done.
MakeNodeClose:
LL140:                                                  ; else make node close
        xor         a                                   ; hi This needs tuning to use a 16 bit variable
        ld          (varU),a                            ; U
        ld          a,4                                 ; lo
        ld          (varT),a                            ; T
        ret
;--LL49-------------------------------------------------------------------------------------------------------------------------                    
ProcessVisibleNode:
RotateNode:                                                                                                                         ;;;     
        call        XX12EquXX15DotProductXX16                                                                                       ;;;           call      XX12=XX15.XX16
LL52LL53LL54LL55
TransposeNode:      
        call        TransposeXX12NodeToXX15

; ......................................................                                                         ;;; 
NodeAdditionsDone:
Scale16BitTo8Bit:
LL57:                                                   ; Enter Node additions done, z=T.U set up from LL55
        ld          a,(varU)                            ; U \ z hi
        ld          hl,UbnkXPointHi
        or          (hl)                                ; XX15+1    \ x hi
        ld          hl,UbnkYPointHi
        or          (hl)                                ; XX15+4    \ y hi
AreXYZHiAllZero:
        jr          z,NodeScalingDone                   ; if X, Y, Z = 0  exit loop down once hi U rolled to 0
DivideXYZBy2:
        ShiftMem16Right1    UbnkXPoint                  ; XX15[0,1]
        ShiftMem16Right1    UbnkYPoint                  ; XX15[3,4]
        ld          a,(varU)                            ; U \ z hi
        ld          h,a
        ld          a,(varT)                            ; T \ z lo
        ld          l,a
        ShiftHLRight1
        ld          a,h
        ld          (varU),a
        ld          a,l
        ld          (varT),a                            ; T \ z lo
        jp          Scale16BitTo8Bit                    ; loop U
NodeScalingDone:
LL60:                                                   ; hi U rolled to 0, exited loop above.
ProjectNodeToScreen:
        ldCopyByte  varT,varQ                           ; T =>  Q   \ zdist lo
        ld          a,(UbnkXPointLo)                    ; XX15  \ rolled x lo
        ld          hl,varQ
        cp          (hl)                                ; Q
        JumpIfALTusng DoSmallAngle                      ; LL69 if xdist < zdist hop over jmp to small x angle
        call        RequAdivQ                           ; LL61  \ visit up  R = A/Q = x/z
        jp          SkipSmallAngle                      ; LL65  \ hop over small xangle
DoSmallAngle:                                           ; small x angle
LL69:
; TODO check if we need to retain BC as this trashes it
;Input: BC = Dividend, DE = Divisor, HL = 0
;Output: BC = Quotient, HL = Remainder
        ld      b,a
        call    DIV16UNDOC
        ld      a,c
        ld      (varR),a
 ;;;       call        RequAmul256divQ                     ; LL28  \ BFRDIV R=A*256/Q byte for remainder of division
SkipSmallAngle:
ScaleX:
LL65:                                                   ; both continue for scaling based on z
        ld          a,(UbnkXPointSign)                  ; XX15+2 \ sign of X dist
        JumpOnBitSet a,7,NegativeXPoint                 ; LL62 up, -ve Xdist, RU screen onto XX3 heap   
; ......................................................   
PositiveXPoint:
        ld          a,(varR)
        ld          l,a
        ld          a,(varU)
        ld          h,a
        ld          a,ScreenCenterX
        add         hl,a
        ex          de,hl
        jp          StoreXPoint
NegativeXPoint:
LL62:                                                   ; Arrive from LL65 just below, screen for -ve RU onto XX3 heap, index X=CNT ;;;
        ld          a,(varR)
        ld          l,a
        ld          a,(varU)
        ld          h,a
        ld          c,ScreenCenterX
        ld          b,0
        ClearCarryFlag
        sbc         hl,bc                               ; hl = RU-ScreenCenterX
        ex          de,hl      
StoreXPoint:                                            ; also from LL62, XX3 node heap has xscreen node so far.
        ld          (iy+0),e                            ; Update X Point
        ld          (iy+1),d                            ; Update X Point
        inc         iy
        inc         iy
; ......................................................   
LL66:
ProcessYPoint:
        xor         a                                   ; y hi = 0
        ld          (varU),a                            ; U
        ldCopyByte  varT,varQ                           ; Q \ zdist lo
        ld          a,(UbnkYPointLo)                    ; XX15+3 \ rolled y low
        ld          hl,varQ
        cp          (hl)                                ; Q
        JumpIfALTusng SmallYHop                         ; if ydist < zdist hop to small yangle
SmallYPoint:        
        call        RequAdivQ                           ; LL61  \ else visit up R = A/Q = y/z
        jp          SkipYScale                          ; LL68 hop over small y yangle
SmallYHop:
LL67:                                                   ; Arrive from LL66 above if XX15+3 < Q \ small yangle
        call        RequAmul256divQ                     ; LL28  \ BFRDIV R=A*256/Q byte for remainder of division
SkipYScale:
LL68:                                                   ; both carry on, also arrive from LL66, yscaled based on z
        ld          a,(UbnkYPointSign)                  ; XX15+5 \ sign of X dist
        bit         7,a
        jp          nz,NegativeYPoint                   ; LL62 up, -ve Xdist, RU screen onto XX3 heap   
PositiveYPoint:
        ld          a,(varR)
        ld          l,a
        ld          a,(varU)
        ld          h,a
        ld          a,ScreenHeightHalf
        add         hl,a
        ex          de,hl
        jp          LL50
NegativeYPoint:
LL70:                                                   ; Arrive from LL65 just below, screen for -ve RU onto XX3 heap, index X=CNT ;;;
        ld          a,(varR)
        ld          l,a
        ld          a,(varU)
        ld          h,a
        ld          c,ScreenHeightHalf
        ld          b,0
        ClearCarryFlag
        sbc         hl,bc                               ; hl = RU-ScreenCenterX
        ex          de,hl      
LL50:                                                   ; also from LL62, XX3 node heap has xscreen node so far.
        ld          (iy+0),e                            ; Update X Point
        ld          (iy+1),d                            ; Update X Point
        inc         iy
        inc         iy
        ret
;--------------------------------------------------------------------------------------------------------
;;;     Byte 0 = X magnitide with origin at middle of ship
;;;     Byte 1 = Y magnitide with origin at middle of ship      
;;;     Byte 2 = Z magnitide with origin at middle of ship          
;;;     Byte 3 = Sign Bits of Vertex 7=X 6=Y 5 = Z 4 - 0 = visibility beyond which vertix is not shown
CopyNodeToXX15:
        ldCopyByte  hl, UBnkXScaled                     ; Load into XX15                                                                     Byte 0;;;     XX15 xlo   = byte 0
        inc         hl
        ldCopyByte  hl, UBnkYScaled                     ; Load into XX15                                                                     Byte 0;;;     XX15 xlo   = byte 0
        inc         hl
        ldCopyByte  hl, UBnkZScaled                     ; Load into XX15                                                                     Byte 0;;;     XX15 xlo   = byte 0
        inc         hl
PopulateXX15SignBits: 
; Simplfied for debugging, needs optimising back to original DEBUG TODO
        ld          a,(hl)
        ld          c,a                                 ; copy sign and visibility to c
        ld          b,a
        and         $80                                 ; keep high 3 bits
        ld          (UBnkXScaledSign),a                 ; Copy Sign Bits                                                            ;;;     
        ld          a,b
        and         $40
        sla         a                                   ; Copy Sign Bits                                                            ;;;     
        ld          (UBnkYScaledSign),a                 ; Copy Sign Bits                                                            ;;;     
        ld          a,b
        and         $20
        sla         a                                   ; Copy Sign Bits                                                            ;;;     
        sla         a                                   ; Copy Sign Bits                                                            ;;;     
        ld          (UBnkZScaledSign),a                 ; Copy Sign Bits                                                            ;;;     
        ld          a,c                                 ; returns a with visibility sign byte
        and         $1F                                 ; visibility is held in bits 0 to 4                                                              ;;;     A = XX15 Signs AND &1F (to get lower 5 visibility)
        ld          (varT),a                            ; and store in varT as its needed later
        ret

;;;     Byte 4 = High 4 bits Face 2 Index Low 4 bits = Face 1 Index
;;;     Byte 5 = High 4 bits Face 4 Index Low 4 bits = Face 3 Index
;..............................................................................................................................
ProcessANode:                                           ; Start loop on Nodes for visibility, each node has 4 faces associated with ;;; For each node (point) in model                  ::LL48 
LL48GetScale:
        ld          a,(LastNormalVisible)               ; get Normal visible range into e before we copy node
        ld          e,a
        call        CopyNodeToXX15
LL48GetVertices:
LL48GetVertSignAndVisDist:
        JumpIfALTNusng e,NodeIsNotVisible               ; if XX4 > Visibility distance then vertext too far away , next vertex.                                             ;;;        goto LL50 (end of loop)
CheckFace1:                                                                                                                         ;;;     if all FaceVisile[point face any of idx1,2,3 or 4] = 0
        CopyByteAtNextHL varP                           ; vertex byte#4, first 2 faces two 4-bit indices 0:15 into XX2 for 2 of the ;;;     get point face idx from byte 4 & 5 of normal
        ld          d,a                                 ; use d to hold a as a temp                                                 ;;;
        and         $0F                                 ; face 1                                                                    ;;;
        push        hl                                  ; we need to save HL                                                        ;;;
        ldHLIdxAToA UbnkFaceVisArray                    ; visibility at face 1                                                Byte 4;;;
        pop         hl                                  ;                                                                           ;;;
        IfANotZeroGoto NodeIsVisible                    ; is face 1 visible                                                         ;;;
CheckFace2:                                                                                                                         ;;;
        ld          a,d                                                                                                             ;;;
        swapnib                                                                                                                     ;;;
        and         $0F                                 ; this is face 2                                                            ;;;
        IfANotZeroGoto NodeIsVisible                    ; is face 1 visible                                                         ;;;
CheckFace3:                                                                                                                         ;;;
        CopyByteAtNextHL varP                           ; vertex byte#4, first 2 faces two 4-bit indices 0:15 into XX2 for 2 of the ;;;     
        ld          d,a                                 ; use d to hold a as a temp                                                 ;;;
        and         $0F                                 ; face 1                                                                    ;;;     
        push        hl                                  ; we need to save HL                                                        ;;;
        ldHLIdxAToA UbnkFaceVisArray                  ; visibility at face 1                                                Byte 5;;;
        pop         hl                                  ;                                                                           ;;;
        IfANotZeroGoto NodeIsVisible                    ; is face 1 visible                                                         ;;;
CheckFace4:                                                                                                                         ;;;
        ld          a,d                                                                                                             ;;;
        swapnib                                                                                                                     ;;;
        and         $0F                                 ; this is face 2                                                            ;;;
        IfANotZeroGoto NodeIsVisible                    ; is face 1 visible                                                         ;;;
NodeIsNotVisible:                                                                                                                   ;;;
        ld          bc,4
        add         iy,bc                               ; if not visible then move to next element in array anyway                  ;;;
        ;;; Should we be loading FFFFFFFF into 4 bytes or just ignore?
        ret                                                                                                      ;;;        goto LL50 (end of loop)
NodeIsVisible:
LL49:
        call        ProcessVisibleNode                  ; Process node to determine if it goes on heap
        ret


ProjectNodeToEye:
	ld			bc,(UBnkZScaled)					; BC = Z Cordinate. By here it MUST be positive as its clamped to 4 min
	ld			a,c                                 ;  so no need for a negative check
	ld			(varQ),a		                    ; VarQ = z
    ld          a,(UBnkXScaled)                     ; XX15	\ rolled x lo which is signed
	call		DIV16Amul256dCUNDOC					; result in BC which is 16 bit TODO Move to 16 bit below not just C reg
    ld          a,(UBnkXScaledSign)                 ; XX15+2 \ sign of X dist
    JumpOnBitSet a,7,EyeNegativeXPoint             ; LL62 up, -ve Xdist, RU screen onto XX3 heap
EyePositiveXPoint:									; x was positive result
    ld          l,ScreenCenterX						; 
    ld          h,0
    add         hl,bc								; hl = Screen Centre + X
    jp          EyeStoreXPoint
EyeNegativeXPoint:                                 ; x < 0 so need to subtract from the screen centre position
    ld          l,ScreenCenterX                     
    ld          h,0
    ClearCarryFlag
    sbc         hl,bc                               ; hl = Screen Centre - X
EyeStoreXPoint:                                    ; also from LL62, XX3 node heap has xscreen node so far.
    ex          de,hl
    ld          (iy+0),e                            ; Update X Point TODO this bit is 16 bit aware just need to fix above bit
    ld          (iy+1),d                            ; Update X Point
EyeProcessYPoint:
	ld			bc,(UBnkZScaled)					; Now process Y co-ordinate
	ld			a,c
	ld			(varQ),a
    ld          a,(UBnkYScaled)                     ; XX15	\ rolled x lo
	call		DIV16Amul256dCUNDOC	                ; a = Y scaled * 256 / zscaled
    ld          a,(UBnkYScaledSign)                 ; XX15+2 \ sign of X dist
    JumpOnBitSet a,7,EyeNegativeYPoint             ; LL62 up, -ve Xdist, RU screen onto XX3 heap top of screen is Y = 0
EyePositiveYPoint:									; Y is positive so above the centre line
    ld          l,ScreenCenterY
    ClearCarryFlag
    sbc         hl,bc  							 	; hl = ScreenCentreY - Y coord (as screen is 0 at top)
    jp          EyeStoreYPoint
EyeNegativeYPoint:									; this bit is only 8 bit aware TODO FIX
    ld          l,ScreenCenterY						
    ld          h,0
    add         hl,bc								; hl = ScreenCenterY + Y as negative is below the center of screen
EyeStoreYPoint:                                    ; also from LL62, XX3 node heap has xscreen node so far.
    ex          de,hl
    ld          (iy+2),e                            ; Update Y Point
    ld          (iy+3),d                            ; Update Y Point
    ret
    
    
    
; Pitch and roll are 2 phases
; 1 - we apply our pitch and roll to the ship position
;       x -> x + alpha * (y - alpha * x)
;       y -> y - alpha * x - beta * z
;       z -> z + beta * (y - alpha * x - beta * z)
; which can be simplified as:
;       1. K2 = y - alpha * x
;       2. z = z + beta * K2
;       3. y = K2 - beta * z
;       4. x = x + alpha * y
; 2 - we apply our patch and roll to the ship orientation
;      Roll calculations:
;      
;        nosev_y = nosev_y - alpha * nosev_x_hi
;        nosev_x = nosev_x + alpha * nosev_y_hi
;      Pitch calculations:
;      
;        nosev_y = nosev_y - beta * nosev_z_hi
;        nosev_z = nosev_z + beta * nosev_y_hi


    
APPequAPPFlippedMulQ:  
    
ApplyMyRollToNosevY:    ld  a,(ALP1)                ; 
                        ld  (varQ),a                ; Set Q = alpha (the roll angle to rotate through)
                        ld  hl,(UBnkrotmatNosevY)
                        ld  (varR),hl               ; RS =  nosev_y
                        ld  a,(UBnkrotmatNosevX+1)  ; Set A = -nosev_x_hi
                        xor $80
                        call  madXAequQmulAaddRS   ; Set (A X) = Q * A + (S R) = = alpha * -nosev_x_hi + nosev_y
                        ld  hl,(varR)               
                        ld  (UBnkrotmatNosevY),hl   ; nosevY = RS  nosev_y = nosev_y - alpha * nosev_x_hi
                        ld hl,(UBnkrotmatNosevX)    ; Set (S R) = nosev_x
                        ld  (varR),hl
                        ld  a,(UBnkrotmatNosevY+1)  ;  Set A = nosev_y_hi
                        call madXAequQmulAaddRS     ; Set (A X) = Q * A + (S R)
                        ld  hl,(varR)               ; = alpha * nosev_y_hi + nosev_x and store (A X) in nosev_x, so this does: 
                        ld  (UBnkrotmatNosevX),hl   ; nosev_x = nosev_x + alpha * nosev_y_hi
                        ret
                        
ApplyMyRollToSidevY:    ld  a,(ALP1)
                        ld  (varQ),a                ; Set Q = alpha (the roll angle to rotate through)
                        ld  hl,(UBnkrotmatSidevY)
                        ld  (varR),hl               ; RS =  nosev_y
                        ld  a,(UBnkrotmatSidevX+1)  ; Set A = -nosev_x_hi
                        xor $80
                        call  madXAequQmulAaddRS    ; Set (A X) = Q * A + (S R) = = alpha * -nosev_x_hi + nosev_y
                        ld  hl,(varR)               
                        ld  (UBnkrotmatSidevY),hl   ; nosevY = RS  nosev_y = nosev_y - alpha * nosev_x_hi
                        ld hl,(UBnkrotmatSidevX)    ; Set (S R) = nosev_x
                        ld  (varR),hl
                        ld  a,(UBnkrotmatSidevY+1)  ;  Set A = nosev_y_hi
                        call madXAequQmulAaddRS     ; Set (A X) = Q * A + (S R)
                        ld  hl,(varR)               ; = alpha * nosev_y_hi + nosev_x and store (A X) in nosev_x, so this does: 
                        ld  (UBnkrotmatSidevX),hl   ; nosev_x = nosev_x + alpha * nosev_y_hi
                        ret    

ApplyMyRollToRoofvY:    ld  a,(ALP1)
                        ld  (varQ),a                ; Set Q = alpha (the roll angle to rotate through)
                        ld  hl,(UBnkrotmatRoofvY)
                        ld  (varR),hl               ; RS =  nosev_y
                        ld  a,(UBnkrotmatRoofvX+1)  ; Set A = -nosev_x_hi
                        xor $80
                        call  madXAequQmulAaddRS    ; Set (A X) = Q * A + (S R) = = alpha * -nosev_x_hi + nosev_y
                        ld  hl,(varR)               
                        ld  (UBnkrotmatRoofvY),hl   ; nosevY = RS  nosev_y = nosev_y - alpha * nosev_x_hi
                        ld hl,(UBnkrotmatRoofvX)    ; Set (S R) = nosev_x
                        ld  (varR),hl
                        ld  a,(UBnkrotmatRoofvY+1)  ;  Set A = nosev_y_hi
                        call madXAequQmulAaddRS     ; Set (A X) = Q * A + (S R)
                        ld  hl,(varR)               ; = alpha * nosev_y_hi + nosev_x and store (A X) in nosev_x, so this does: 
                        ld  (UBnkrotmatRoofvX),hl   ; nosev_x = nosev_x + alpha * nosev_y_hi
                        ret    
                 
                        


; (-a)-(-b)=  if ABS(a)> ABS(B), (ABS(a)-abs(b))*-1 Else (ABS(b)-abs(a))
; (+a)-(+b)=  if ABS(a) > ABS(B), ABS(a)- abs (B)   else (ABS(B) - abs(A) * -1
; (-a)-(+b)=  (ABS(a) + ABS(b)) * -1
; (+a)-(-b)=  ABS(a) + ABS(b)
AHLequUbnkYminusAHL:    ld      b,a
                        ex      de,hl
                        ld      hl,(UBnKylo)        ; hl = unsigned Y
                        ld      a,(UBnKysgn)        ; ahl = signed Y corrodinate
                        xor     b                   ; now we need to see if signs were different or same
                        JumpIfNegative .SignsDifferent
.SignsTheSame:          call    compare16HLDE
                        jr      c,.HLLessThanDE
.HLGreaterDE:           sub     hl,de               ; sub hl from de and leave sign the same
                        ld      a,b
                        jr      .WasResultZero
.HLLessThanDE:          ex      de,hl
                        sub     hl,de
                        xor     $80                  ; flip sign bit
                        jr      .WasResultZero
.SignsDifferent:        add     hl,de
                        JumpOnBitClear  b,7,.UbnkNegative
                        xor     a
                        jr      .WasResultZero
.UbnkNegative:          ld      a,$80
.WasResultZero:         ld      b,a                 ; but zero can result in -0
                        ld      a,h
                        or      l
                        ld      a,$80
                        ret     nz
.ResultWasZero:         xor     a
                        ret    

; 1. K2 = y - alpha * x
; 2. z = z + beta * K2
; 3. y = K2 - beta * z
; 4. x = x + alpha * y


; Test roll only so beta will be 0 therefore:
; 1. K2 = y - alpha * x
; 2. z = z + 0 * K2     so z in untouched
; 3. y = K2 * z
; 4. x = x + alpha * y

ApplyMyRollToPosition:  ld      a,(ALP1)            
                        ld      d,0
                        ld      e,a                 ; de = unsigned roll magnitude
                        ld      hl,(UBnKxlo)        ; hl = position X unsigned
                        ld      l,h
                        ld      h,0
                        call    mulDEbyHL          ; hl = de * hl
                        ld      a,(ALP2)
                        ld      b,a                 ; b = sign
                        ld      a,(UBnKxsgn)        ; a = position sign
                        xor     b                   ; xor so if opposite then 
                        and     $80                 ; so -*- = +, +*+ = + opposite signes = negative
                        call    AHLequUbnkYminusAHL
                        ld      (varKp1),hl
                        ld      (varKp3),a          ; Kp = y - alph * x as 16 bit + sign bit
.ZEquZPlusBetaMulK2:    nop                         ; for now as beta is not conisdered
.YEquK2MinusBetaMulZ:   ld      hl,(varKp1)
                        ld      (UBnKylo),hl
                        ld      a,(varKp3)
                        ld      (UBnKysgn),a        ; for now as beta = 0
.XequXPlusAlphaMulY:    ld      a,(ALP1)            
                        ld      d,0
                        ld      e,a                 ; de = unsigned roll magnitude
                        ld      hl,(UBnKylo)        ; hl = position X unsigned
                        ld      l,h
                        ld      h,0
                        call    mulDEbyHL          ; hl = de * hl
                        ld      a,(ALP2)
                        ld      b,a                 ; b = sign
                        ld      a,(UBnKysgn)        ; a = position sign
                        xor     b                   ; xor so if opposite then 
                        and     $80                 ; so -*- = +, +*+ = + opposite signes = negative                
                        ld      c,a
                        ex      de,hl
                        ld      hl,(UBnKxlo) 
                        ld      a,(UBnKxsgn)
                        or      h
                        ld      h,a
                        ld      a,b
                        or      d
                        ld      d,a
                        call    ADDHLDESignedv3
                        ld      (UBnKxlo), hl
                        ld      a,h
                        and     $80
                        ld      (UBnKxsgn), a
                        ret
;----------------------------------------------------------------------------------------------------------------------------------
ApplyMyRollAndPitch:    ld      a,(ALP1)
                        cp      0
                        jr      z,.NoRotation
                        call    ApplyMyRollToPosition
        ;                call    ApplyMyRollToNosevY
        ;                call    ApplyMyRollToSidevY
        ;                call    ApplyMyRollToRoofvY
.NoRotation:            ret
; .....................................................
; Process Nodes does the following:
; for each node:
;     see if node > 
PNXX20DIV6          DB      0
PNVERTEXPTR         DW      0   ; DEBUG WILL USE LATER
PNNODEPRT           DW      0   ; DEBUG WILL USE LATER
PNLASTNORM          DB      0
ProcessNodes:
    xor     a
    ld      (UbnkLineArrayLen),a
    call    CopyRotmatToTransMat             ;#01; Load to Rotation Matrix to XX16, 16th bit is sign bit
    call    ScaleXX16Matrix197               ;#02; Normalise XX16
    call    LoadCraftToCamera                ;#04; Load Ship Coords to XX18
    call    InverseXX16                      ;#11; Invert rotation matrix
    ld      hl,UBnkHullVerticies
    ld      a,(VertexCtX6Addr)               ; get Hull byte#8 = number of vertices *6                                   ;;;
GetActualVertexCount:
    ld      c,a                              ; XX20 also c = number of vertices * 6 (or XX20)
    ld      c,a                              ; XX20 also c = number of vertices * 6 (or XX20)
    ld      d,6
    call    asm_div8                         ; asm_div8 C_Div_D - C is the numerator, D is the denominator, A is the remainder, B is 0, C is the result of C/D,D,E,H,L are not changed"
    ld      b,c                              ; c = number of vertices
    ld      iy,UBnkNodeArray
LL48:   
PointLoop:	
	push	bc                                  ; save counters
	push	hl                                  ; save verticies list pointer
	push	iy                                  ; save Screen plot array pointer
    ld      a,b
    ;break
    call    CopyNodeToXX15                      ; copy verices at hl to xx15
	ld		a,(UBnkXScaledSign)
	call    XX12EquNodeDotOrientation
	call    TransposeXX12ByShipToXX15
	call	ScaleNodeTo8Bit					    ; scale to 8 bit values, why don't we hold the magnitude here?x
	pop		iy                                  ; get back screen plot array pointer
	call    ProjectNodeToEye                     ; set up screen plot list entry
   ; ld      hl,UbnkLineArrayLen
  ;  inc     (hl)                                ; another node done
ReadyForNextPoint:
	push	iy                                  ; copy screen plot pointer to hl
	pop		hl
	ld		a,4
	add		hl,a
	push	hl                                  ; write it back at iy + 4
	pop		iy								    ; and put it in iy again
	pop		hl                                  ; get hl back as vertex list
	ld		a,6
	add 	hl,a                                ; and move to next vertex
	pop		bc                                  ; get counter back
	djnz	PointLoop
; ......................................................   
    ret                                         
;-LL49-----------------------------------------------------------------------------------------------------------------------------
;  Entering Here we have the following:
;  XX15(1 0) = vertex x-coordinate but sign not populated
;  XX15(3 2) = vertex y-coordinate but sign not populated
;  XX15(5 4) = vertex z-coordinate but sign not populated
;
;  XX16(  1 0)sidev_x   (3 2)roofv_x   (5 4)nosev_x
;  XX16(  7 6)sidev_y   (9 8)roofv_y (11 10)nosev_y
;  XX16(13 12)sidev_z (15 14)roofv_z (17 16)nosev_z
;--------------------------------------------------------------------------------------------------------
AddLaserBeamLine:
; this code is a bag of shit and needs re-writing
GetGunVertexNode:
        ld          a,(GunVertexAddr)                   ; Hull byte#6, gun vertex*4 (XX0),Y
        ld          hl,UBnkNodeArray                    ; list of lines to read
        add         hl,a                                ; HL = address of GunVertexOnNodeArray
        ld          iyl,0
MoveX1PointToXX15:
        ld          c,(hl)                              ; 
        inc         hl
        ld          b,(hl)                              ; bc = x1 of gun vertex
        inc         hl
        ld          (UBnkX1),bc
        inc         c
        ret         z                                   ; was c 255?
        inc         b
        ret         z                                   ; was c 255?
MoveY1PointToXX15:
        ld          c,(hl)                              ; 
        inc         hl
        ld          b,(hl)                              ; bc = y1 of gun vertex
        inc         hl
        ld          (UBnkY1),bc
SetX2PointToXX15:
        ld          bc,0                                ; set X2 to 0
        ld          (UBnkX2),bc
        ld          a,(UbnKzlo)
        ld          c,a
SetY2PointToXX15:
        ld          (UBnkY2),bc                         ; set Y2to 0
        ld          a,(UBnKxsgn)
        JumpOnBitClear a,7,LL74SkipDec
LL74DecX2:
        ld          a,$FF
        ld          (UBnkX2Lo),a                        ; rather than dec (hl) just load with 255 as it will always be that at this code point
LL74SkipDec:        
        call        ClipXX15XX12Line                    ; LL145 \ clip test on XX15 XX12 vector, returns carry 
        jr          c,CalculateNewLines                 ; LL170 clip returned carry set so not visibile if carry set skip the rest (laser not firing)
; Here we are usign hl to replace VarU as index        
        ld          hl,(varU16)
        ld          a,(UBnKx1Lo)
        ld          (hl),a
        inc         hl
        ld          a,(UbnKy1Lo)
        ld          (hl),a
        inc         hl
        ld          a,(UBnkX2Lo)
        ld          (hl),a
        inc         hl
        ld          a,(UbnKy2Lo)
        ld          (hl),a
        inc         iyl                                 ; iyl holds as a counter to iterations
        inc         hl
        inc         iyl                                 ; ready for next byte
        ld          (varU16),hl
        ret
;--------------------------------------------------------------------------------------------------------
getVertexNodeAtAToX1Y1:                                 ; a = byteoffset to node array as its pre computed to x4 bytes
        ld          hl,UBnkNodeArray                    ; hl = edgelist  current pointer
        add         hl,a                                ; hl = address of Node
        ld          a,(hl)                              ; get edge list nbr 1 edge
;SI THIS NEEDED ?       inc         hl                                  ; prep to read next edge
        ld          de,UBnkX1
        ldi                                             ; x1 lo
        ldi                                             ; x1 hi
        ldi                                             ; y1 lo
        ldi                                             ; y1 hi
        ret
;--------------------------------------------------------------------------------------------------------
getVertexNodeAtAToX2Y2:                                 ; a = byteoffset to node array as its pre computed to x4 bytes
        ld          hl,UBnkNodeArray                    ; hl = edgelist  current pointer
        add         hl,a                                ; hl = address of Node
        ld          a,(hl)                              ; get edge list nbr 1 edge
;SI THIS NEEDED ?       inc         hl                                  ; prep to read next edge
        ld          de,UBnkX2
        ldi                                             ; x1 lo
        ldi                                             ; x1 hi
        ldi                                             ; y1 lo
        ldi                                             ; y1 hi
        ret
;--------------------------------------------------------------------------------------------------------
GetFaceAtA:         MACRO
                    ld          hl,UbnkFaceVisArray
                    add         hl,a
                    ld          a,(hl)                              ; get face visibility
                    ENDM
; Goes through each edge in to determine if they are on a visible face, if so load start and end to line array as clipped lines

PLEDGECTR           DB          0

PrepLines:
EdgeTotal:
ProcessLines:
LL72:
; FOR NOW BRUTE FORCE IF OFF SCREEN

; TODO add in onced DOEXP is finished
;        ld          a,(UBnkexplDsp)                     ; INWK+31  \ display/exploding state|missiles
;        JumpOnBitClear  a,5,EE31                        ; bit5 of mask, if zero no explosion
;        or          8
;        ld          (UBnkexplDsp),a                     ; else else set bit3 to erase old line
;        jp          DOEXP                               ; erase using Do Explosion and use implicit return
;EE31:                                                   ; no explosion
;        JumpOnBitClear  a,3,LL74                        ; clear is hop to do New lines
;        call        ClearLine                           ; LL155    \ else erase lines in XX19 heap at LINEstr down
;        ld          a, $08                              ; set bit 3 of a and fall into LL74
;
;--------------------------------------------------------------------------------------------------------
InitialiseLineRead:  
        ;break
        ldWriteZero UbnkLineArrayLen                    ; current line array index = 0
        ldWriteZero UbnkLineArrayBytes                  ; UbnkLineArrayBytes= nbr of bytes of lines laoded = array len * 4
        ldWriteZero PLEDGECTR
        ld          a,(EdgeCountAddr)
        ld          ixh,a                               ; ixh = XX17 = Total number of edges to traverse
        ld          iyl,0                               ; ixl = current edge index
        ld          hl,UbnkLineArray                    ; head of array
        ld          (varU16),hl                         ; store current line array pointer un varU16
        ldCopyByte  EdgeCountAddr, XX17                 ; XX17  = total number of edges to traverse edge counter
        ld          a,(UBnkexplDsp)                     ; get explosion status
        JumpOnBitClear a,6,CalculateNewLines            ; LL170 bit6 of display state clear (laser not firing) \ Calculate new lines
        and         $BF                                 ; else laser is firing, clear bit6.
        ld          (UBnkexplDsp),a                     ; INWK+31
;   TODO commentedout as teh subroutine is a mess   call        AddLaserBeamLine                    ; add laser beam line to draw list
; NOw we can calculate hull after including laser line        
CalculateNewLines:
LL170:                                                  ;(laser not firing) \ Calculate new lines   \ their comment
CheckEdgesForVisibility:        
        ld          hl,UBnkHullEdges
        ; TODO change heap to 3 separate arrays and break them down during copy of ship hull data
        ld          (varV),hl                           ; V \ is pointer to where edges data start
        ld          a,(LineX4Addr)
        ld          b,a                                 ; nbr of bytes of edge data
LL75Loop:                                               ; count Visible edges
IsEdgeInVisibilityRange:
        ld          hl,(varV)
        push        hl
        pop         iy
        IFDEF NOBACKFACECULL
            jp          VisibileEdge; DEBUGTODO
        ENDIF
        ld          a,(LastNormalVisible)               ; XX4 is visibility range
        ld          d,a                                 ; d holds copy of XX4
; Get Edge Byte 0
        ld          a,(IY+0)                            ; edge data byte#0 is visibility distance
        JumpIfALTNusng d,LL78EdgeNotVisible             ; XX4   \ visibility LLx78 edge not visible
EdgeMayBeVisibile:
; Get Edge Byte 1
IsFace1Visibile:                                        ; edges have 2 faces to test
        ld          a,(IY+1)                            ; (V),Y \ edge data byte#1 bits 0 to 3 face 1 4 to 7 face 2
        ld          c,a                                 ;  c = a copy of byte 1
        and         $0F                                 ;
        GetFaceAtA
;       jp  VisibileEdge; DEBUG BODGE TEST TODO
        IfANotZeroGoto VisibileEdge                     ; LL70 visible edge
IsFace2Visibile:
        ld          a,c                                 ; restore byte 1 from c register
        swapnib                                         ; 
        and         $0F                                 ; swap high byte into low byte
        push        hl
        GetFaceAtA
        pop         hl
        IfAIsZeroGoto LL78EdgeNotVisible                ; edge not visible
VisibileEdge:                                           ; Now we need to node id from bytes 2 - start and 3 - end
;LL79--Visible edge--------------------------------------
; Get Edge Byte 2
        ld          a,(IY+2)                            ; get Node id
        call        getVertexNodeAtAToX1Y1              ; get the points X1Y1 from node
        ld          a,(IY+3)
        call        getVertexNodeAtAToX2Y2              ; get the points X2Y2 from node
        call        CLIP
        jr          c,LL78EdgeNotVisible                ; LL78 edge not visible
LL80:                                                   ; ll80 \ Shove visible edge onto XX19 ship lines heap counter U
        ld          de,(varU16)                         ; clipped edges heap address
        ld          hl,UBnkNewX1
        FourLDIInstrunctions
        ld          (varU16),de                         ; update U16 with current address
        ld          hl,UbnkLineArrayLen                 ; we have loaded one line
        inc         (hl)
        ld          a,(hl)
        JumpIfAGTENusng LineArraySize,CompletedLineGeneration   ; have we hit max lines for a model hop over jmp to Exit edge data loop
; If we hit here we skip the write of line arryay u16
LL78EdgeNotVisible:                                     ; also arrive here if Edge not visible, loop next data edge.
LL78:
        ld          hl,(varV)                           ; varV is current edge address
        ld          a,4
        add         hl,a
        ld          (varV),hl
        ld          hl,PLEDGECTR                        ;
        inc         (hl)                                ;
        ld          a,(hl)                              ; current edge index ++
        JumpIfANEMemusng XX17,LL75Loop                  ; compare with total number of edges
CompletedLineGeneration:        
LL81:
LL81SHPPT:                                              ; SHPPT ship is a point arrives here with Acc=2, bottom entry in heap
        ld          a,(UbnkLineArrayLen)                ; UbnkLineArrayLen = nbr of lines loaded 
        sla         a
        sla         a                                   ; multiple by 4 to equal number of bytes
        ld          (UbnkLineArrayBytes),a              ; UbnkLineArrayBytes= nbr of bytes of lines laoded = array len * 4
ExitEdgeDataLoop:
        ret

UnivBankSize  EQU $ - StartOfUniv
