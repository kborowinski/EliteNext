;-- XX16 --------------------------------------------------------------------------------------------------------------------------
PBnkTransmatSidevX          DW  0               ; XX16+0
PBnkTransmatSidev           EQU PBnkTransmatSidevX
PBnkTransmatSidevY          DW 0                ; XX16+2
PBnkTransmatSidevZ          DW 0                ; XX16+2
PBnkTransmatRoofvX          DW 0
PBnkTransmatRoofv           EQU PBnkTransmatRoofvX
PBnkTransmatRoofvY          DW 0                ; XX16+2
PBnkTransmatRoofvZ          DW 0                ; XX16+2
PBnkTransmatNosevX          DW 0
PBnkTransmatNosev           EQU PBnkTransmatNosevX
PBnkTransmatNosevY          DW 0                ; XX16+2
PBnkTransmatNosevZ          DW 0                ; XX16+2
PBnkTransmatTransX          DW 0
PBnkTransmatTransY          DW 0
PBnkTransmatTransZ          DW 0
PlanetXX16                      equ PBnkTransmatSidev
;-- XX16Inv --------------------------------------------------------------------------------------------------------------------------
PBnkTransInvRow0x0          DW 0
PBnkTransInvRow0x1          DW 0
PBnkTransInvRow0x2          DW 0
PBnkTransInvRow0x3          DW 0
PBnkTransInvRow1y0          DW 0
PBnkTransInvRow1y1          DW 0
PBnkTransInvRow1y2          DW 0
PBnkTransInvRow1y3          DW 0
PBnkTransInvRow2z0          DW 0
PBnkTransInvRow2z1          DW 0
PBnkTransInvRow2z2          DW 0
PBnkTransInvRow2z3          DW 0

PlanetXX16Inv             equ PBnkTransInvRow0x0
