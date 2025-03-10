
galactic_cursor_sprite				equ	0
galactic_cursor_sprite1				equ	galactic_cursor_sprite+1
galactic_cursor_sprite2				equ	galactic_cursor_sprite1+2

galactic_hyper_sprite				equ	galactic_cursor_sprite2+1
;galactic_hyper_sprite1				equ galactic_hyper_sprite+1
;galactic_hyper_sprite2				equ	galactic_hyper_sprite1+1

local_cursor_sprite					equ	galactic_hyper_sprite+1
local_cursor_sprite1				equ	local_cursor_sprite+1
local_cursor_sprite2				equ	local_cursor_sprite1+1

local_hyper_sprite					equ	local_cursor_sprite2+1
local_hyper_sprite1					equ	local_hyper_sprite+1
local_hyper_sprite2					equ	local_hyper_sprite1+2

reticlule_sprite1                   equ	local_hyper_sprite2+1
reticlule_sprite2                   equ	reticlule_sprite1+1
reticlule_sprite3                   equ	reticlule_sprite2+1
reticlule_sprite4                   equ reticlule_sprite3+1

laser_sprite1                       equ	reticlule_sprite4+1
laser_sprite2                       equ	laser_sprite1    +1
laser_sprite3                       equ	laser_sprite2    +1
laser_sprite4                       equ laser_sprite3    +1
laser_sprite5                       equ	laser_sprite4    +1
laser_sprite6                       equ	laser_sprite5    +1
laser_sprite7                       equ	laser_sprite6    +1
laser_sprite8                       equ laser_sprite7    +1
laser_sprite9                       equ	laser_sprite8    +1
laser_sprite10                      equ	laser_sprite9    +1
laser_sprite11                      equ	laser_sprite10   +1
laser_sprite12                      equ laser_sprite11   +1
laser_sprite13                      equ	laser_sprite12   +1
laser_sprite14                      equ	laser_sprite13   +1
laser_sprite15                      equ	laser_sprite14   +1
laser_sprite16                      equ laser_sprite15   +1
compass_sun                         equ laser_sprite16   +1
compass_station                     equ compass_sun      +1
targetting_sprite1                  equ compass_station  +1
targetting_sprite2                  equ targetting_sprite1   +1

glactic_pattern_1					equ 0
glactic_hyper_pattern_1             equ 2
local_present_cursor                equ 4
local_hyper_pattern                 equ 7
reticule_pattern_1                  equ 10
reticule_pattern_2                  equ 11
laser_pattern_1                     equ 12
laser_pattern_2                     equ 13
laser_pattern_3                     equ 14
laser_pattern_4                     equ 15
laser_pattern_5                     equ 16
targetting_pattern                  equ 23
lock_pattern                        equ 24

compass_sun_infront                 equ 17
compass_sun_behind                  equ 18
compass_station_infront             equ 19
compass_station_behind              equ 20
spritecursoroffset					equ 17
spriteborderoffset                  equ 32

HideSprite:                 MACRO   spritenbr
                            nextreg		SPRITE_PORT_INDEX_REGISTER,spritenbr
                            nextreg		SPRITE_PORT_ATTR3_REGISTER,$00
                            ENDM

; " sprite_big BC = rowcol, D = sprite nbr , E= , pattern"
sprite_big:
.SetAnchor:	                ld		a,d                                 ; a = sprite nbr, bug fix?
                            push	af									; save id for next few
                            push	de
                            nextreg	SPRITE_PORT_INDEX_REGISTER,a		; set up sprite id
; write out X position bits 1 to 8
                            ld		a,c
                            ld      hl,spritecursoroffset
                            add		hl,a                                ; hl = full x position
                            ld		a,l
                            nextreg	SPRITE_PORT_ATTR0_REGISTER,a		; Set up lower x cc
; write out Y position bits 1 to 8
                            ex		de,hl								; de = full x position
                            ld		a,b
                            ld      hl,spritecursoroffset
                            add		hl,a
                            ld		a,l                                 ; hl = full y position
                            nextreg	SPRITE_PORT_ATTR1_REGISTER,a		; lower y coord on screen
; write out MSB of X as its an anchor  
                            ld		a,d									; de = MSB of X (hl bit 0)
                            nextreg	SPRITE_PORT_ATTR2_REGISTER,a		; lower y
; write out sprite pattern
                            pop		de                                  ; de = pattern and sprite nbr
                            ld		a,e
                            or		%11000000							; 
                            nextreg	SPRITE_PORT_ATTR3_REGISTER,a		; visible 5 bytes pattern e
; write out msb of y in h must be bit 0 only
                            ld		a,%00000000							; big unified composite
                            or		h									; MSB Y
                            nextreg	SPRITE_PORT_ATTR4_REGISTER,a		; visible 5 bytes pattern e
.BigSprite1:                pop		af
                            inc		a
                            push	af
                            nextreg		SPRITE_PORT_INDEX_REGISTER,a
                            ld		a,16
                            nextreg		SPRITE_PORT_ATTR0_REGISTER,a	; lower x
                            xor 	a
                            nextreg		SPRITE_PORT_ATTR1_REGISTER,a	; lower y
                            nextreg		SPRITE_PORT_ATTR2_REGISTER,a	; relative setup
                            ld		a,%11000001							; relative and 4 bytes of data, pattern 1
                            nextreg		SPRITE_PORT_ATTR3_REGISTER,a
                            ld		a,%01000001							; big unified composite
                            nextreg	SPRITE_PORT_ATTR4_REGISTER,a		; visible 5 bytes pattern e
.BigSprite2:                pop		af
                            inc		a
                            nextreg		SPRITE_PORT_INDEX_REGISTER,a
                            xor		a
                            nextreg		SPRITE_PORT_ATTR0_REGISTER,a	; lower x
                            ld		a,16
                            nextreg		SPRITE_PORT_ATTR1_REGISTER,a	; lower y
                            xor		a
                            nextreg		SPRITE_PORT_ATTR2_REGISTER,a	; relative setup
                            ld		a,%11000010							; relative and 4 bytes of data, pattern 2
                            nextreg		SPRITE_PORT_ATTR3_REGISTER,a
                            ld		a,%01000001							; big unified composite
                            nextreg	SPRITE_PORT_ATTR4_REGISTER,a		; visible 5 bytes pattern e
                            ret	
	
; for a sinle sprite within 256x192 area    
sprite_single:          ld		a,d                                 ; a = sprite nbr, bug fix?
                        push    de
                        nextreg	SPRITE_PORT_INDEX_REGISTER,a		; set up sprite id
; write out X position bits 1 to 8
                        ld		a,c                                 ; a = column (c)
                        ld      hl,spriteborderoffset
                        add		hl,a                                ; hl = full x position
                        ex		de,hl								; de = full x position
                        ld		a,e
                        nextreg	SPRITE_PORT_ATTR0_REGISTER,a		; Set up lower x cc
; write out Y position bits 1 to 8
                        ld		a,b                                 ; a = row
                        ld      hl,spriteborderoffset
                        add		hl,a
                        ld		a,l                                 ; hl = full y position
                        nextreg	SPRITE_PORT_ATTR1_REGISTER,a		; lower y coord on screen
; write out MSB of X as its an anchor  
                        ld		a,d									; de = MSB of X (hl bit 0)
                        nextreg	SPRITE_PORT_ATTR2_REGISTER,a		; lower y
; write out sprite pattern
                        pop     de
                        ld		a,e
                        or		%10000000							; 
                        nextreg	SPRITE_PORT_ATTR3_REGISTER,a		; visible 5 bytes pattern e
; write out extended attribute
                        ld      a,%00000000                         ; its a single sprite
                        or      h
                        nextreg	SPRITE_PORT_ATTR4_REGISTER,a
                        ret
; ">sprite_galactic_cursor BC = rowcol"    
sprite_galactic_cursor:     ld		d,galactic_cursor_sprite
                            ld		e,0
                            ld		a,b
                            add		a,galactic_chart_y_offset
                            ld		b,a	
                            call	sprite_big
                            ret
	
; "> sprite_galactic_hyper_cursorBC = rowcol"
sprite_galactic_hyper_cursor:ld		a,b
                            add		a,galactic_chart_hyper_offset
                            ld		b,a	
                            ld		d,galactic_hyper_sprite
                            ld		e,3
                            call	sprite_single ; sprite_big:
                            ret
; moves hyperspace cursor to target system x position
sprite_ghc_move:            ld		a,galactic_hyper_sprite
                            nextreg	SPRITE_PORT_INDEX_REGISTER,a		; set up sprite id
; write out X position bits 1 to 8
                            ld		a,c
                            ld      hl,galactic_chart_hyper_x_offset
                            add		hl,a                                ; hl = full x position
                            ld		a,l
                            nextreg	SPRITE_PORT_ATTR0_REGISTER,a		; Set up lower x cc
; write out Y position bits 1 to 8
                            ex		de,hl								; de = full x position
                            srl		b			    					; row is row / 2
                            ld      a,b
                            ld      hl,galactic_chart_hyper_y_offset
                            add		hl,a
                            ld		a,l                                 ; hl = full y position
                            nextreg	SPRITE_PORT_ATTR1_REGISTER,a		; lower y coord on screen
; write out MSB of X as its an anchor  
                            ld		a,d									; de = MSB of X (hl bit 0)
                            nextreg	SPRITE_PORT_ATTR2_REGISTER,a		; lower y
; write out msb of y in h must be bit 0 only
                            ld		a,%00000000							; big unified composite
                            or		d									; MSB Y
                            nextreg	SPRITE_PORT_ATTR4_REGISTER,a		; visible 5 bytes pattern e
                            ret


sprite_lhc_move:            ld		a,local_hyper_sprite
                            nextreg	SPRITE_PORT_INDEX_REGISTER,a		; set up sprite id
; write out X position bits 1 to 8
                            ld		a,c
                            ld      hl,spritecursoroffset
                            add		hl,a                                ; hl = full x position
                            ld		a,l
                            nextreg	SPRITE_PORT_ATTR0_REGISTER,a		; Set up lower x cc
; write out Y position bits 1 to 8
                            ex		de,hl								; de = full x position
                            ld		a,b
                            ld      hl,spritecursoroffset
                            add		hl,a
                            ld		a,l                                 ; hl = full y position
                            nextreg	SPRITE_PORT_ATTR1_REGISTER,a		; lower y coord on screen
; write out MSB of X as its an anchor  
                            ld		a,d									; de = MSB of X (hl bit 0)
                            nextreg	SPRITE_PORT_ATTR2_REGISTER,a		; lower y
; write out msb of y in h must be bit 0 only
                            ld		a,%00000000							; big unified composite
                            or		d									; MSB Y
                            nextreg	SPRITE_PORT_ATTR4_REGISTER,a		; visible 5 bytes pattern e
                            ret

; "sprite_local_cursor BC = rowcol"
sprite_local_cursor:        ld		d,local_cursor_sprite
                            ld		e,local_present_cursor
                            call	sprite_big
                            ret

; "sprite_local_hyper_cursor BC = rowcol"
sprite_local_hyper_cursor:  ld		d,local_hyper_sprite
                            ld		e,local_hyper_pattern
                            call	sprite_big
                            ret	

compass_offset              equ 2
ScannerX                    equ 128
ScannerY                    equ 171 
SunScanCenterX              equ 92
SunScanCenterY              equ 171 
PlanetScanCenterX           equ 164
PlanetScanCenterY           equ 171

    
compass_sun_move:       ld		a,compass_sun
                        nextreg	SPRITE_PORT_INDEX_REGISTER,a		; set up sprite id
; write out X position bits 1 to 8
                        ld      a, SunScanCenterX-compass_offset
                        add     a,c
                        nextreg	SPRITE_PORT_ATTR0_REGISTER,a		; Set up lower x cc
; write out Y position bits 1 to 8
                        ld      a, SunScanCenterY-compass_offset
                        sub     b
                        nextreg	SPRITE_PORT_ATTR1_REGISTER,a		; lower y coord on screen
                        ret    

compass_station_move:   ld		a,compass_station
                        nextreg	SPRITE_PORT_INDEX_REGISTER,a		; set up sprite id
; write out X position bits 1 to 8
                        ld      a, PlanetScanCenterX-compass_offset
                        add     a,c
                        nextreg	SPRITE_PORT_ATTR0_REGISTER,a		; Set up lower x cc
; write out Y position bits 1 to 8
                        ld      a, PlanetScanCenterY-compass_offset
                        sub     b
                        nextreg	SPRITE_PORT_ATTR1_REGISTER,a		; lower y coord on screen
                        ret    
                        
ReticuleCentreX         EQU (256/2)+32 -1
ReticuleCentreY         EQU (192/2)+32 -1
ReticuleOffset          EQU 8

TargetetingCentreX1     EQU ReticuleCentreX -32
TargetetingCentreX2     EQU ReticuleCentreX +16
TargetetingCentreY      EQU ReticuleCentreY -7
    
sprite_reticule:        ld      a,reticlule_sprite1                 ; LEFT ARM
                        nextreg SPRITE_PORT_INDEX_REGISTER,a        ; select left hand side
                        ld      a,ReticuleCentreX -16 - ReticuleOffset
                        nextreg	SPRITE_PORT_ATTR0_REGISTER,a		; Set up lower x pos as 136 (104 + 32 border)
                        ld		a,ReticuleCentreY 
                        nextreg	SPRITE_PORT_ATTR1_REGISTER,a		; lower y coord on screen
                        xor     a
                        nextreg	SPRITE_PORT_ATTR2_REGISTER,a		; attribute 2
                        ld      a,reticule_pattern_2 | %10000000
                        nextreg	SPRITE_PORT_ATTR3_REGISTER,a		; visible 5 bytes pattern left reticule
.rightReticule          ld      a,reticlule_sprite2                 ; RIGHT ARM
                        nextreg SPRITE_PORT_INDEX_REGISTER,a        ; select left hand side
                        ld      a,ReticuleCentreX + ReticuleOffset
                        nextreg	SPRITE_PORT_ATTR0_REGISTER,a		; Set up lower x pos as 136 (104 + 32 border)
                        ld		a,ReticuleCentreY
                        nextreg	SPRITE_PORT_ATTR1_REGISTER,a		; lower y coord on screen
                        ld      a,%00001000
                        nextreg	SPRITE_PORT_ATTR2_REGISTER,a		; attribute 2 including mirroring horizontal
                        ld      a,reticule_pattern_2 | %10000000
                        nextreg	SPRITE_PORT_ATTR3_REGISTER,a		; visible 5 bytes pattern left reticule
.topReticule            ld      a,reticlule_sprite3
                        nextreg SPRITE_PORT_INDEX_REGISTER,a        ; select left hand side
                        ld      a,ReticuleCentreX
                        nextreg	SPRITE_PORT_ATTR0_REGISTER,a		; Set up lower x pos as 136 (104 + 32 border)
                        ld		a,ReticuleCentreY-16 - ReticuleOffset
                        nextreg	SPRITE_PORT_ATTR1_REGISTER,a		; lower y coord on screen
                        xor     a
                        nextreg	SPRITE_PORT_ATTR2_REGISTER,a		; attribute 2 
                        ld      a,reticule_pattern_1 | %10000000
                        nextreg	SPRITE_PORT_ATTR3_REGISTER,a		; visible 5 bytes pattern left reticule
.bottomReticule         ld      a,reticlule_sprite4
                        nextreg SPRITE_PORT_INDEX_REGISTER,a        ; select left hand side
                        ld      a,ReticuleCentreX
                        nextreg	SPRITE_PORT_ATTR0_REGISTER,a		; Set up lower x pos as 136 (104 + 32 border)
                        ld		a,ReticuleCentreY + ReticuleOffset
                        nextreg	SPRITE_PORT_ATTR1_REGISTER,a		; lower y coord on screen
                        ld      a,%00000100
                        nextreg	SPRITE_PORT_ATTR2_REGISTER,a		; attribute 2 including mirroring vertical
                        ld      a,reticule_pattern_1 | %10000000
                        nextreg	SPRITE_PORT_ATTR3_REGISTER,a		; visible 5 bytes pattern left reticule
                        ret

laserbasex              equ 6
laserbasey              equ 14  
    
ShowSprite              MACRO   spritenbr, patternnbr
                        ld      a, spritenbr
                        nextreg SPRITE_PORT_INDEX_REGISTER,a
                        ld      a,patternnbr | %10000000
                        nextreg	SPRITE_PORT_ATTR3_REGISTER,a
                        ENDM
                        
LeftLaser:              MACRO   xoffset, yoffset, spriteL, patternL
                        ld      a, spriteL
                        nextreg SPRITE_PORT_INDEX_REGISTER,a        ; select left hand side
                        ld      a,((laserbasex + xoffset) *8) + 32 
                        nextreg	SPRITE_PORT_ATTR0_REGISTER,a		; Set up lower x pos as 136 (104 + 32 border)
                        ld		a,((laserbasey -yoffset) * 8) + 32 -1
                        nextreg	SPRITE_PORT_ATTR1_REGISTER,a		; lower y coord on screen
                        xor     a
                        nextreg	SPRITE_PORT_ATTR2_REGISTER,a		; attribute 2
                        ld      a, patternL | %00000000             ; hidden by default
                        nextreg	SPRITE_PORT_ATTR3_REGISTER,a		 
                        ENDM
    
RightLaser:             MACRO   xoffset, yoffset, spriteL, patternL
                        ld      a, spriteL
                        nextreg SPRITE_PORT_INDEX_REGISTER,a        ; select left hand side
                        ld      a,(((30-laserbasex) - xoffset) *8) + 32 -2
                        nextreg	SPRITE_PORT_ATTR0_REGISTER,a		; Set up lower x pos as 136 (104 + 32 border)
                        ld		a,((laserbasey -yoffset) * 8) + 32 -1
                        nextreg	SPRITE_PORT_ATTR1_REGISTER,a		; lower y coord on screen
                        ld      a,%00001000
                        nextreg	SPRITE_PORT_ATTR2_REGISTER,a		; attribute 2
                        ld      a, patternL | %00000000             ; hidden by default
                        nextreg	SPRITE_PORT_ATTR3_REGISTER,a		 
                        ENDM
                    
  
show_compass_sun_infront:ShowSprite  compass_sun, compass_sun_infront
                         ret
                         
show_compass_sun_behind: ShowSprite  compass_sun, compass_sun_behind
                         ret

show_compass_station_infront: ShowSprite  compass_station, compass_station_infront
                         ret

show_compass_station_behind:  ShowSprite  compass_station, compass_station_behind
                         ret
    
sprite_laser:           LeftLaser  0,0,laser_sprite1 ,laser_pattern_1
                        LeftLaser  2,0,laser_sprite2 ,laser_pattern_2
                        LeftLaser  4,1,laser_sprite3 ,laser_pattern_3
                        LeftLaser  6,1,laser_sprite4 ,laser_pattern_4
                        LeftLaser  8,2,laser_sprite5 ,laser_pattern_5
                        RightLaser 0,0,laser_sprite9 ,laser_pattern_1
                        RightLaser 2,0,laser_sprite10,laser_pattern_2
                        RightLaser 4,1,laser_sprite11,laser_pattern_3
                        RightLaser 6,1,laser_sprite12,laser_pattern_4
                        RightLaser 8,2,laser_sprite13,laser_pattern_5
                        ret                           
                        ; Need simple show updates just to update the show attribute

sprite_laser_show:      ShowSprite laser_sprite1 ,laser_pattern_1
                        ShowSprite laser_sprite2 ,laser_pattern_2
                        ShowSprite laser_sprite3 ,laser_pattern_3
                        ShowSprite laser_sprite4 ,laser_pattern_4
                        ShowSprite laser_sprite5 ,laser_pattern_5
                        ShowSprite laser_sprite9 ,laser_pattern_1
                        ShowSprite laser_sprite10,laser_pattern_2
                        ShowSprite laser_sprite11,laser_pattern_3
                        ShowSprite laser_sprite12,laser_pattern_4
                        ShowSprite laser_sprite13,laser_pattern_5
                        ret

sprite_galactic_hide:   HideSprite galactic_cursor_sprite
                        HideSprite galactic_cursor_sprite1
                        HideSprite galactic_cursor_sprite2
                        ret	
	
sprite_galactic_hyper_hide:
                        HideSprite galactic_hyper_sprite
                         ;nextreg		SPRITE_PORT_INDEX_REGISTER,galactic_hyper_sprite1
;                        nextreg		SPRITE_PORT_ATTR3_REGISTER,$00
;                        nextreg		SPRITE_PORT_INDEX_REGISTER,galactic_hyper_sprite2
;                        nextreg		SPRITE_PORT_ATTR3_REGISTER,$00
                        ret
	
sprite_local_hide:      HideSprite local_cursor_sprite
                        HideSprite local_cursor_sprite1
                        HideSprite local_cursor_sprite2
                        ret
	
sprite_local_hyper_hide:HideSprite local_hyper_sprite
                        HideSprite local_hyper_sprite1
                        HideSprite local_hyper_sprite2
                        ret

sprite_reticule_hide:   HideSprite reticlule_sprite1
                        HideSprite reticlule_sprite2
                        HideSprite reticlule_sprite3
                        HideSprite reticlule_sprite4
                        ret

                            
sprite_targetting:      ld      a,targetting_sprite1                 ; LEFT ARM
                        nextreg SPRITE_PORT_INDEX_REGISTER,a        ; select left hand side
                        ld      a,TargetetingCentreX1
                        nextreg	SPRITE_PORT_ATTR0_REGISTER,a		; Set up lower x pos as 136 (104 + 32 border)
                        ld		a,TargetetingCentreY 
                        nextreg	SPRITE_PORT_ATTR1_REGISTER,a		; lower y coord on screen
                        xor     a
                        nextreg	SPRITE_PORT_ATTR2_REGISTER,a		; attribute 2
                        ld      a,targetting_pattern | %10000000
                        nextreg	SPRITE_PORT_ATTR3_REGISTER,a		; visible 5 bytes pattern left reticule
.right:                 ld      a,targetting_sprite2                ; RIGHT ARM
                        nextreg SPRITE_PORT_INDEX_REGISTER,a        ; select left hand side
                        ld      a,TargetetingCentreX2
                        nextreg	SPRITE_PORT_ATTR0_REGISTER,a		; Set up lower x pos as 136 (104 + 32 border)
                        ld		a,TargetetingCentreY
                        nextreg	SPRITE_PORT_ATTR1_REGISTER,a		; lower y coord on screen
                        ld      a,%00001000
                        nextreg	SPRITE_PORT_ATTR2_REGISTER,a		; attribute 2 including mirroring horizontal
                        ld      a,targetting_pattern | %10000000
                        nextreg	SPRITE_PORT_ATTR3_REGISTER,a		; visible 5 bytes pattern left reticule
                        ret

sprite_lock:            ld      a,targetting_sprite1                 ; LEFT ARM
                        nextreg SPRITE_PORT_INDEX_REGISTER,a        ; select left hand side
                        ld      a,TargetetingCentreX1
                        nextreg	SPRITE_PORT_ATTR0_REGISTER,a		; Set up lower x pos as 136 (104 + 32 border)
                        ld		a,TargetetingCentreY 
                        nextreg	SPRITE_PORT_ATTR1_REGISTER,a		; lower y coord on screen
                        xor     a
                        nextreg	SPRITE_PORT_ATTR2_REGISTER,a		; attribute 2
                        ld      a,lock_pattern | %10000000
                        nextreg	SPRITE_PORT_ATTR3_REGISTER,a		; visible 5 bytes pattern left reticule
.right:                 ld      a,targetting_sprite2                 ; RIGHT ARM
                        nextreg SPRITE_PORT_INDEX_REGISTER,a        ; select left hand side
                        ld      a,TargetetingCentreX2
                        nextreg	SPRITE_PORT_ATTR0_REGISTER,a		; Set up lower x pos as 136 (104 + 32 border)
                        ld		a,TargetetingCentreY
                        nextreg	SPRITE_PORT_ATTR1_REGISTER,a		; lower y coord on screen
                        ld      a,%00001000
                        nextreg	SPRITE_PORT_ATTR2_REGISTER,a		; attribute 2 including mirroring horizontal
                        ld      a,lock_pattern | %10000000
                        nextreg	SPRITE_PORT_ATTR3_REGISTER,a		; visible 5 bytes pattern left reticule
                        ret
                            
sprite_targetting_hide: HideSprite targetting_sprite1
                        HideSprite targetting_sprite2
                        ret

sprite_targetting_show: ShowSprite targetting_sprite1, targetting_pattern
                        ShowSprite targetting_sprite2, targetting_pattern
                        ret

sprite_laser_hide:      HideSprite laser_sprite1
                        HideSprite laser_sprite2
                        HideSprite laser_sprite3
                        HideSprite laser_sprite4
                        HideSprite laser_sprite5
                        HideSprite laser_sprite6
                        HideSprite laser_sprite7
                        HideSprite laser_sprite8
                        HideSprite laser_sprite9
                        HideSprite laser_sprite10
                        HideSprite laser_sprite11
                        HideSprite laser_sprite12
                        HideSprite laser_sprite13
                        HideSprite laser_sprite14
                        HideSprite laser_sprite15
                        HideSprite laser_sprite16
                        ret
    
sprite_compass_hide:    HideSprite compass_sun
                        HideSprite compass_station
                        ret

sprite_cls_cursors:     call	sprite_galactic_hide	
                        call	sprite_galactic_hyper_hide	
                        call	sprite_local_hide	
                        call	sprite_local_hyper_hide	
                        call    sprite_reticule_hide
                        call    sprite_laser_hide
                        call    sprite_compass_hide
                        call    sprite_targetting_hide
                        ret

init_sprites:           call		sprite_cls_cursors
                        nextreg 	SPRITE_LAYERS_SYSTEM_REGISTER,%01000011
                        ret
	