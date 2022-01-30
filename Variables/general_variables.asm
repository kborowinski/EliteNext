;	PAGE 0 Map to variable anmes
;	PAGE 0 Map to variable anmes
;
;
;
;	06		T1
;	07
;	08		SC1					Screen Hi
;	09							XX16 Matrix
;	0A							XX16+1
;	0B							XX16+2
;	0C							XX16+3
;	0D                          XX16+4
;	0E                          XX16+5
;	0F							XX16+6
;	10		varP				XX16+7
;	11		varP				XX16+8
;	12                          XX16+9
;	13                          XX16+10
;	14							XX16+11
;	15                          XX16+12
;	16                          XX16+13
;	17                          XX16+14
;	17                          XX16+14
;	18                          XX16+15
;	19
;	1A
;	1B
;	1C
;	1D
;	1E							XX0
;	1F                          XX0+1
;	20		INF                 XX0+2
;	21      INF+1               XX0+3
;	22      varV                XX0+4
;	23      varV +1             XX0+5
;	24		XXlo                XX0+6
;	25		XXHi                
;	26		YYlo                
;	27		YYHi                
;	28
;	29		
;	2A		BETA (pitch done)
;	2B		BET1 lower7 magnitude
;	2C		XC
;	2D		YC
;	2E		QQ22				Outer Hyperspace Countdown
;	2E		QQ22				Outer Hyperspace Countdown
;	2F		QQ22+1				Inner Hyperspace Countdown
;	30		ECM Active
;	31		ALP1
;	32		ALP2
;	33		ALP2FLIP

;	36		Z1					XX15+2yscaled
;	37		                    XX15+3ysign
;	38		                    XX15+4zscaled
;	39							XX15+5zsign	
;	3A		XX12				xplot for star
;	3B		
;	3C		
;	3D		
;	3E		
;	3F		
;	40		varKlo
;	41		varKmid
;	42		varKHi
;	43		varKVeryHi+Sign
;	44		
;	45		MSTG				MissileTarget
;	46		INWK				; Inner working space of 37 bytes
;	47		INWK
;	48		INWK
;	49		INWK
;	4A		INWK
;	4B		INWK
;	4C		INWK
;	4D		INWK
;	4E		INWK
;	4F		INWK+9
;	50		INWK
;	51		INWK
;	52		INWK
;	53		INWK
;	54		INWK
;	55		INWK
;	56		INWK
;	57		INWK
;	58		INWK
;	59		INWK
;	5A		INWK
;	5B		INWK
;	5C		INWK
;	5D		INWK
;	5E		INWK
;	5F		INWK
;	60		INWK
;	61		INWK
;	62		INWK
;	63		INWK
;	64		INWK
;	65		INWK31				 clear exploding/display state|missiles 
;	66		INWK
;	67		INWK				XX19
;	68		INWK
;	69		INWK
;	6A		INWK36
;	6B		
;	6C		QQ15				Current Seed
;	6D		QQ15+1 
;	6E		QQ15+2
;	6F		QQ15+3
;	70		QQ15+4
;	71		
;	72		XX18   xlo			QQ17
;	73		XX18+1 xhi
;	74		XX18+2 xsgn
;	75		XX18   ylo
;	76		XX18+1 yhi
;	77		XX18+2 ysgn
;	78		XX18   zlo
;	79		XX18+1 zhi
;	7A		XX18+2 zsgn
;	7B		BET2				Pitch Sign
;	7C		BET2FLIP
;	7D		DELTA
;	7E		DELT4Lo
;	7F		DELT4Hi
;	80		
;	81		varQ
;	82		varR
;	83		varS
;	84		XSAV
;	85		YSAV
;	86		XX17
;	87		MenuIdMax		QQ11
;	88		ZZDust
;	89		
;	8A		MCNT			Move Count
;	8B		ALPHA
;	8C		TYPE
;	8D		
;	8E		DockedFlag		QQ12
;	8F		
;	96		XX4				Nbr of Normals Visible
;   
;   9F      POINT
;	D0
;	D1		varT
;array list of each face during draw flagged visible or not
;	D2      XX2				
;	D3      XX2+1
;	D4      XX2+2
;	D5      XX2+3
;	D6      XX2+4
;	D7      XX2+5
;	D8      XX2+6
;	D9      XX2+7
;	DA      XX2+8
;	DB      XX2+9
;	DC      XX2+10
;	DD      XX2+11
;	DE      XX2+12
;	DF		XX2+13
;	E0		XX2+14
;	E1		XX2+15
;	E2
;	E3
;	E4
;	E5
;	E6
;	E7
;	E8
;	E9
;	EA
;	EB
;	EC
;	ED
;	EE
;	8F

varAxis1	DW 	0				; address of first axis in a rotation action
varAxis2	DW	0				; address of 2nd axis in a roation action
; Variables to simulate 6502 registers until code fixed
; These must be here in this order as reading Y and X can then be a 16 bit read
regX		DB	0               ; using 16 bit read into BC this would go into C
regY		DB	0               ; using 16 bit read into BC this would go into B
regA		DB	0


varGPLoopA	DB	0				; General Purpose innermost loop variable
INF			DW	0				; page 0 &20 Used to get address from UNIV array
INF28		DW	0				; page 0 &20 Used to get address from UNIV array



;XX16		DS	16				; 16 byte Matrix

P0INWK							; page 0 & 46
p0INWK31						; page 0 & 65
P0INWK36						; PAGE 0 &6A 

XX4			DB	0				; XX4 page 0 &96 last Normal Found to be visible
LastNormalVisible	equ	XX4
varXX4              equ XX4



PATG		DB	0				; 6502 &03C9     
SLSP 		DW	0				; &03B0 \ SLSP \ ship lines pointer


;UNIV		DS FreeListSize*2	; Array of Universe Pointers
;HULLINDEX	DS ShipTypeSize*2	; hull index for table at XX21= &5600 XX21-1,Y

; Present System Variables

RandomSeed				DB	43			; 00 DEBUG JUST SOME START VALUES
RandomSeed1				DB	32	; 01
RandomSeed2				DB	12			; 02
RandomSeed3				DB	66			; 03

varT1					DB	0				; 06
SClo					DB 0				; 07
SChi					DB 0				; 08
varP					DB 0 				; 10	XX16+7
varPhi					DB 0 				; 11	XX16+8
varPhi2					DB 0 				; 12	XX16+9
varPp1                  equ varPhi
varPp2                  equ varPhi2
UnivPointerLo			DB	0				; 20		INF                 XX0+2
UnivPointerHi			DB	0				; 21      INF+1               XX0+3
UnivPointer				equ	UnivPointerLo     
varV					DB 0				; 22                          XX0+4
varVHi					DB 0				; 23                          XX0+5
varXXlo                 DB 0                ; 24		
varXXHi                 DB 0                ; 25		
varXX					equ	varXXlo
YYlo                    DB 0                ; 26		
YYHi                    DB 0                ; 27		
varYY					equ	YYlo
											;	28
											;	29		
;PlayerShipPositionData - Must be contiguous for setup
SpaceStationSafeZone    DB  0               ; Flag to determine if we are in safe zone
BETA 					DB	0               ; 2A        (pitch done)		
JSTY                    DB  0               ; Joystick analog
BET1 					DB	0               ; 2B        lower7 magnitude	
BET2                    DB  0               ;            climb sign
BET2FLIP				DB	0				; 7C		BET 2 pitch Sign negated
BET1MAXC                DB  31              ; max climb
BET1MAXD                DB  -31             ; max dive
XC						DB	0               ; 2C
YC						DB 	0               ; 2D
InnerHyperCount			DB 	0				; 2F QQ22+1
OuterHyperCount			DB 	0				; 2E QQ22
HyperCircle             DB  0
ECMActive				DB 	0				; 30		ECM Active flag
ECMLoopA                DB  0
ECMLoopB                DB  0
JSTX                    DW  0               ;           Joystick analog value
ALPHA					DB	0				; 8D        Alpha with bit 7 sign
ALP1					DB 	0				; 31		ALP1	Roll magnitude Also Apha
ALP2					DB  0				; 32		ALP2	Roll Sign
ALP2FLIP				DB  0				; 33		ALP2	negated roll sign
ALP1MAXR                DB  31               ;   Maximum roll, added becuase we may allow different ship types
ALP1MAXL                DB  -31             ;   Maximum roll, added becuase we may allow different ship types

EventCounter    		DB 	0				; 8A
MissJumpFlag            DB  0
ExtraVesselsCounter     DB  0
JunkCount				DB  0				; $033E
PlayerMisJump			DB	0				; $0341 witchspace misjump
CopCount                DB  0 
PirateCount             DB  0
BadnessStatus           DB  0

MAXMESSAGES             EQU 5
MESSAGETIMELIMIT        EQU 20
MESSAGESIZE             EQU 33
MESSAGELINE             EQU $0001

MessageCount            DB 0                ; used for enquing messages later
MessageCurrent          DB 0
MessageIndex            DW MAXMESSAGES
MessageQueue            DS MAXMESSAGES * MESSAGESIZE
MessageTimeout          DB MAXMESSAGES
MissileTarget			DW 0				; 45
IndexedWork				DS	37				; General purpose work space when doing temp arrays

; MOVED TO Universe XX19					DB	0				; page 0 &67
; MOVED TO Universe XX20					DB	0				; page 0 &67 also used as XX19+1 for XX19 being a word
NormalCountCopyBy4		equ	XX20			; Also used for normal * 4 holding variable
XX21					DB  0				; this may be part of XX20/xx21 accordign to spawn new shipXX21		DW	0				; Ah XX21 is hull pointer  hull pointer lo as it can;t hold HULLINDX as 16bit array
;XX21 is the pointer table to the pages for ship types. this will be repalaced by paging so just need an equate for first page


SystemSeed				DS  5				;	6C		QQ15	Current Galaxy Seed
											;	6D		QQ15+1 
											;	6E		QQ15+2
											;	6F		QQ15+3
											;	70		QQ15+4
											;	71		QQ15+5
QQ17					DB	0				;   72
XX18xlo                 DB  0               ;	72		XX18   xlo
XX18xhi                 DB  0               ;	73		XX18+1 xhi
XX18xsg                 DB  0               ;	74		XX18+2 xsgn
XX18ylo                 DB  0               ;	75		XX18   ylo
XX18yhi                 DB  0               ;	76		XX18+1 yhi
XX18ysg                 DB  0               ;	77		XX18+2 ysgn
XX18zlo                 DB  0               ;	78		XX18   zlo
XX18zhi                 DB  0               ;	79		XX18+1 zhi
XX18zsg                 DB  0               ;	7A		XX18+2 zsgn

SHIPMAXSPEED            DB  40              ; variable to facilitate ship editing later
DELTA					DB 	0				; 7D 		DELTA  \ bpl -2 inserted here to stall from title code if byte check fails
DELT4Lo					DB 	0				; 7E
DELT4Hi					DB 	0				; 7F
DELTA4                  equ                 DELT4Lo

				
; Not thise must be in this order else 16 bit fetches will fail
varU                    DB  0               ;   80
varQ					DB  0 				;	81		
varR					DB  0 				;	82		
varS					DB  0 				;	83		
varRS                   equ varR

varU16                  DW  0               ; 16 bit variant on varU as I can't use above for this

XSAV					DB	0				; 84	   XSAV usef for nearby ship count outer
YSAV                    DB  0               ; 85
XX17					DB	0				; 86
RequiredScale			equ  XX17			; use to hold calculated scale in drawing ship
varXX17                 equ  XX17
ScreenChanged           DB  0
ScreenIndex             DB  0 
CursorKeysPressed       DB  0               ; mapping of the current key presses
                                            ; 7    6    5    4     3    2        1    0
                                            ; Up   Down Left Right Home Recentre 
InvertedYAxis           DB  0
MenuIdMax				DB	0				;	87		MenuIdMax		QQ11
											; Bit 7 Set  ShortRangeChart    $80
											; Bit 6 Set  Galactic Chart     $40
											; Bit 5 Set  Market Place       $20
											; Bit 4 Set  Status Screen      $10
											; Bit 3 Set  Display Inventory  $08
                                            ; Bit 2 Set  Planet Data        $04
                                            ; View bit combinations if the ones above not matched
                                            ; bits 1 0
                                            ;      1 1  Front view , i.e. $03
                                            ;      1 0  Aft View          $02
                                            ;      0 1  Left View         $01
                                            ;      0 0  Right view        $00
											; Bit 0 Set  Data On System
											; 0  Space View (Not a menu)
ZZDust					DB	0				;	88		ZZDust (Poss 16 bit need to check)
XX13                    DB  0               ;   89
TYPE					DB	0				; 8C used for ship type in drawing
;Docked flag = 00 = in free space
;              FF = Docked
;              FE = transition
;              FD = Setup open space and transition to not docked
;              FC = Hyperspace manimation
;              FB = Hyperspace complete
DockedFlag				DB	0				; 8E - 
GamePaused              DB  0
varSWAP                 DB  0               ; 90 , general purpose swap variable
varCNT                  DB  0               ; 93

varK					DB	0				; 40
varKp1					DB	0				; 41
varKp2					DB	0				; 42
varKp3					DB	0				; 43

varK2                   DB  0               ; 9B
varK2p1                 DB  0               ; 9C K2 plus 1
varK2p2                 DB  0               ; 9D K2 plus 2
varK2p3                 DB  0               ; 9E K2 plus 3

Point                   DB  0               ; 9F      POINT

varT					DB	0				; D1

varVector9ByteWork      DS  9

varK3					DS	4				; D2
varK3p2					DB	0				; 42
varK3p3					DB	0				; 43
varK3p1					equ varK3+1			; D3
varK4					DS	4				; E0
varK4p1					equ varK4+1			; D3

;PlayerData:
PlayerForwardSheild0	DB	0 ; ????? 
PlayerForwardSheild1    DB	0
PlayerForwardSheild2    DB	0


;Heap

HeapStart				DS	2				; &0100 XX3 50 bytes for now
HeapData				DS	50
; Contains 				X 16 bit, Y 16 bit
;RuntimeData:
HeapHead				equ HeapStart

; For the UniverseSlot list, for an optimisation the type slot will be the ship type, e.g. ship type this will optimise searching for a station or star
; bit 7 will be set for a sun or planet so we can only ever have 128 types of ship, in relality there are about 3 types
; note this is ship type as it space station, transporter, pirate etc not model of ship
; This replaces FRIN
; slot 0 always equals the planet
; slot 1 is the space station or sun depending on if we are in the space station safe zone)
UniverseSlotList		DS UniverseListSize		; &0311 for 12 bytes Array of Free Index - Now array of while universe pages are occupied
UniverseSlotCount       DS UniverseListSize * 2 ; To be implemented, keeps a count of each slot type, may merge into slot list and set as a DW
CurrentUniverseAI       DB  0               ; used to cycle ships in each iterations of main loop
SelectedUniverseSlot    DB  0    
;SpaceStationPresent		DB	0				; flag to determine if we are within space station safe zone

SUN						DB	0				; &031D Actually MANY -1? As we can only have 1?
MANY					DB	0				; &031E array of ship types???
						DB	0				; &0321	Speculative?
						DB	0				; &0322	Speculative?
						DB	0				; &0323	Speculative?
						DB	0				; &0324	Speculative?
						DB	0				; &0325	Speculative?
						DB	0				; &0326	Speculative?
						DB	0				; &0327	Speculative?
TransporterPresent		DB	0				; &0328	MANY + 10 (or #SHU + 1)
						DB	0				; &0329	MANY + 11 Speculative?
				        DB	0				; &032A	MANY + 12 Speculative?
				        DB	0				; &032B	MANY + 13 Speculative?
				        DB	0				; &032C	MANY + 14 Speculative?
				        DB	0				; &032D	MANY + 15 Speculative?
				        DB	0				; &032E	MANY+COPS #COP Confirmed in code
				        DB	0				; &032F	MANY + 17 Speculative?
				        DB	0				; &0330	MANY + 18 Speculative?
				        DB	0				; &0331	MANY + 19 Speculative?
						DB	0				; &0332	MANY + 20 Speculative?
				        DB	0				; &0333	MANY + 21 Speculative?
				        DB	0				; &0334	MANY + 22 Speculative?
				        DB	0				; &0335	MANY + 23 Speculative?
				        DB	0				; &0336	MANY + 24 Speculative?
				        DB	0				; &0337	MANY + 25 Speculative?
				        DB	0				; &0338	MANY + 26 Speculative?
				        DB	0				; &0339	MANY + 27 Speculative?
				        DB	0				; &033A	MANY + 28 Speculative?
				        DB	0				; &033B	MANY + 29 Speculative?
				        DB	0				; &033C	MANY + 30 Thargoids 
				        DB	0				; &033D	MANY + 31 Constrictor?
CabinTemp				DB	0				; $0342
MissileArmedStatus		DB	0				; 0344 MSAR  
View					DB	0				; 0345 Index for laser mount and screen view, 1 = front 2 = aft = 4 left 8 = right
GunTemperature			DB	0				; 0347	GNTMP 
HyperSpaceFX			DB	0				; 0348 HFX (probabyl BBC specific
ExtraVessels			DB	0				; 0349 EV Use d by cops, extra vessels still to spawn?
Delay					DB	0				; 034A Delay general purpose eg. spawing EV or when printign messages
MessageForDestroyed		DB	0				; 034B Message flag for item + destroyed
JoystickX				DB	0				; 034C JSTX  
JoystickY				DB	0				; 034D JSTY
XSAV2 					DB	0				; 034E used to temporary save 6502 X reg
YSAV2 					DB	0				; 034F used to temporary save 6502 Y reg
CommanderName			DS  8				; 0350 - 3057 Commander Name
CommanderName0			DB	0				; Sneaky little 0 to allow use of print name directly
;036C to D???
DampingKeys				DS  7				; 0387 - 038D
;  #&6 Does K toggle keyboard/joystick control -  03CD certainly makes keyboard not work anymore.
;  #&5 Does J reverse both joystick channels
;  #&4 Does Y reverse joystick Y channel			03CB
;  #&2 Does X toggle startup message display ? PATG?	03C9
;  #&3 Does F toggle flashing information			03CA
;  #&1 Does A toggle keyboard auto-recentering ?
;  #&0 Caps-lock toggles keyboard flight damping
NbrMissiles				DB	0				; 038B	Does this clash with Dampingkeys?
FugitiveInnocentStatus	DB	0				; 038C	FIST
StockAvaliabiliy		DS 	16				; 038D - 039C Stock inventory in station
AlienItemsAvaliability  DB	0				; 039D
RandomMarketSeed		DB	0				; 039E   \ QQ26	\ random byte for each system vist (for market)
KillTally  				DW	0				; 039F - 03A0 \ TALLY   \ kills lo hi
COMP     				DB	0				; 03A1 2nd competion byte used for save integrity checks?
											;
MCH						DB	0				; 03A4  \ MCH  \ old message to erase
ForeShield				DB	0				; 03A5
AftShield				DB	0				; 03A6
PlayerEnergy			DB	0				; 03A7
CompassX				DB	0				; 03A8
CompassY				DB	0				; 03A9
MarketPrice				DB	0				; 03AA QQ24
MaxStockAvaliable		DB  0				; 03AB   \ QQ25     \ max available
SystemEconomy			DB  0				; 03AC \ QQ28   \ the economy byte of present system (0 is Rich Ind.)
CargoItem				DB	0				; 03AD (I think its item type just scooped) QQ29
ShipLineStackPointer	DW	0				; 03B0 & 03B1 ship Lines pointer reset to top LS% = &0CFF (make DW for z80 and direct hl pointer)
											; this is ship lines stack pointer so may be redundant with paging
											; LS = line stack so we will have one for now to remove later
COK						DB	0				; 0366 Competition Byte what ? Does some file check and accelleration check
DisplayEcononmy			DB	0				; 03B8
DisplayGovernment		DB  0				; 03B9 Is it target? 03B9 \ QQ4	 \ Government, 0 is Anarchy.
DisplayTekLevel			DB	0				; 03BA   \ QQ5	\ Tech
DisplayPopulation		DW	0				; 03BB \ QQ6  \ population*10
DisplayProductivity		DW	0				; 03BD \ QQ7   \ productivity*10
Distance          		DW	0				; 03BE \ QQ8 distince in 0.1LY units
DisplayRadius			DW	0
; --- Used in creation of sun and planet----;
PlanetXPos     DS  1
PlanetYPos     DS  1
PlanetZPos     DS  1
PlanetType     DS  1
SunXPos        DS  1
SunYPos        DS  1
SunZPos        DS  1
; --- Galaxy Data --------------------------;
Galaxy      			DB	0				; 0367 Galaxy (incremented with galactiv drive
WorkingSeeds			DS	6
PresentSystemSeeds		DS	6				; 03B2 - 03B7
GalaxySeeds				DS	6				; 035B - 0360 QQ21
PresentSystemX			DB	0				; 0359 - 035A QQ0 X Y
PresentSystemY			DB  0
TargetPlanetX			DB	0               ; 03C1
TargetPlanetY			DB	0               ; 03C2
GovPresentSystem		DB	0				; 03AE Govenment 
TekPresentSystem		DB	0				; 03AF Technology
;SRCTargetPlanetX		DB	0               ; Used for short range chart cursor
;SRCTargetPlanetY		DB	0               ; then divided down to target planet for compatibilit with galactic chart routines
NumberOfStarsNOSTM		DB	0				; 03C3 NOSTM  \ number of stars, dust.

CompassColor			DB	0				; 03C5
SoundToggle				DB	0				; 03C6
KeyboardRecenterToggle	DB	0				; 03C8
PATGMask				DB	0				; &03C9    \ PATG	\ Mask to scan keyboard X-key, for misjump
FlashToggle				DB  0				; 03CA \ FLH \ flash toggle
ReverseJoystick			DB	0				; 03CB \ JSTGY \ Y reverse joystick Y channel
JoystickToggle			DB	0				; 03CD  \ JSTK    \ K toggle keyboard/joystick
DigitalJoystick			DB	0				; 03CE \ JDB   \ . = toggle between keyboard and bitpaddle
DiskReadFailFlag		DB	0				; 03CF \ CATF \ Disk catalog fail flag										

; Working Data

;UniverseTable			DS	26				; 1741  \ address pointers for 13 ships INF on pages &9. 37 bytes each.
; $0900 =	EQUW page9+37* 0 \ copied to inner worskpace INWK on zero-page when needed
; $0925 =	EQUW page9+37* 1
; $094A =	EQUW page9+37* 2
; $096F =	EQUW page9+37* 3
; $0994 =	EQUW page9+37* 4
; $09B9 =	EQUW page9+37* 5
; $09DE =	EQUW page9+37* 6
; $0A03 =	EQUW page9+37* 7
; $0A28 =	EQUW page9+37* 8
; $0A4D =	EQUW page9+37* 9
; $0A72 =	EQUW page9+37*10
; $0A97 =	EQUW page9+37*11
; $0ABC =	EQUW page9+37*12 \ allwk up to &0ABC while heap for edges working down from &CFF. 



; 0b00 is start address of data to save 
; Now MissionData VarTP					DB	0				; 0358 TP? The Plan  \ mission uses lower 4 bits
											; Bit mask XXXX10XX - Thargoid plan mission

MissionData				DB	0				; &0B00	  \ look at data, first byte is TP mission bits

FileNameStringPointer	DW	0				;0C00	   \ pointer to filename string
CommanderLoadAddress	DW	0				;0C03
LengthOfFile			DW	0				;0C0B
SaveDataEndAddress		DW	0				;&0C0F	      \ &0C00 is end address of data to save

EdgesBuffer				DS 50
EdgesBufferSP			equ	$				; Was $0CFF			; Heap pointer for edges buffer
ShipLinesBufferSP		equ EdgesBufferSP	; was $0CFF

ShipLineStack			DS  70			; For now but will be in the page later										
ShipLineStackTop		equ $ - ShipLineStack	

LSO						DS 	$C0				;0E00 Line Buffer Solar of 192 lines (may be 191 in reality)
; LSX vector overlaps with LSO
LSX2					DB	0				; &0EC0	    \ LSX2 bline buffer size?
LSY2					DB	0           	; &0F0E	    \ LSY2

; Star Positions are 16 bit 3d coordinates
varDust                 DS  MaxNumberOfStars * 6
varDustSceen            DS  MaxNumberOfStars * 2 ; To optimise star list to wipe from screen
varStarX                DB  0
varStarY                DB  0
varDustX                DS MaxNumberOfStars *2
varDustY                DS MaxNumberOfStars *2
varDustZ                DS MaxNumberOfStars *2

FShieldStart            equ $8410
AShieldStart            equ $8D10
FuelStart               equ $9410

EnergyBar4Start         equ $A5D5
EnergyBar3Start         equ $ADD5
EnergyBar2Start         equ $B5D5
EnergyBar1Start         equ $BDD5
; 70 /2 = 35 values
;                            0                             1                             2                             3                  
;                            0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6
FuelMapping             DB  01,02,02,03,04,04,05,06,06,07,08,09,10,10,11,12,13,14,14,15,16,16,17,19,20,21,21,22,23,24,25,26,27,28,30,31,31
SpeedoStart             equ $84D1
;                            0                             1                             2                             3                             4
;                            0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7  8  9  0
SpeedoMapping           DB  01,02,02,03,04,04,05,06,06,07,08,09,10,10,11,12,13,14,14,15,16,16,17,18,19,20,20,21,22,23,24,24,25,26,26,27,28,28,29,30,31

DialMiddleXPos          equ $E1 
RollMiddle              equ $8CE0  
PitchMiddle             equ $94E0   

                        
ResetPlayerShip:        ZeroThrottle
                        ZeroPitch
                        ZeroRoll
                        ClearMissileTarget
                        ClearECM
                        ChargeEnergyAndShields
                        ret
                        