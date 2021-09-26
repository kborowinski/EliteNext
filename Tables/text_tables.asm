StatusLaserName1	DB	"Pulse",0
StatusLaserName2	DB	"Beam",0
StatusLaserName3    DB  "Military",0
StatusLaserName4    DB  "Mining",0
StatusLaserName5    DB  "Custom",0

StatusLaserNameIdx	DW	StatusLaserName1,StatusLaserName2,StatusLaserName3,StatusLaserName4,StatusLaserName5
StatusLaserNameIdxLen EQU $ - StatusLaserNameIdx

ConditionName1		DB "Docked",0
ConditionName2		DB "Green",0
ConditionName3		DB "Yellow",0
ConditionName4		DB "Red",0

ConditionNameIdx	DW ConditionName1,ConditionName2,ConditionName3,ConditionName4
ConditionNameIdxLen EQU $ - ConditionNameIdx

StatusDiagrams		DB "ABOUSEITILETSTONLONUTHNOALLEXEGEZACEBISOUSESARMAINDIREA?ERATENBERALAVETIEDORQUANTEISRION",0

RankingTable		DW	$0000,$0008,$0010,$0020,$0040,$0080,$0200,$0A00,$1900,$4900,$FFFF

RankingName1		DB 	"Harmless",0
RankingName2		DB 	"Mostly Harmless",0
RankingName3		DB 	"Poor",0
RankingName4		DB 	"Average",0
RankingName5		DB 	"Above Average",0
RankingName6		DB 	"Competent",0
RankingName7		DB 	"Dangerous",0
RankingName8		DB 	"Deadly",0
RankingName9		DB 	"---- E L I T E ---",0
RankingName10		DB 	"Skollobsgod",0
RankingName11		DB 	"Nutter",0

RankingNameIdx		dw RankingName1,RankingName2,RankingName3,RankingName4,RankingName5,RankingName6,RankingName7,RankingName8,RankingName9,RankingName10,RankingName11
RankingNameIdxLen EQU $ - RankingNameIdx


getTableText:
; ">getTableText, hl = indexlist, a = textnbr, returns with hl = porinter to head of text"
; ">Note for ranking first 2 bytes are target rank"
	push	de								; save DE as we will likley need it in caller
	add		hl,a							; 0 based ref, and its 2 bytes
	add		hl,a
	ld		e,(hl)
	inc		hl
	ld		d,(hl)							; de = indexed address
	ex		de,hl							; flip it to hl
	pop		de								; retrieve de
	ret										; return with hl as start entry


;               CF      ZF      Result
;               -----------------------------------
;               0       0       HL > DE
;               0       1       HL == DE
;               1       0       HL < DE
;               1       1       Impossible
getRankIndex:
; ">getRank, de = kill count, returns a = index,hl destroyed"
; ">Note for ranking first 2 bytes are target rank"
	ld		a,d
	or		e
	cp		0
	ret		z								; quicks skip for 0 kills
	xor 	a
	ld		hl,RankingTable
.testLoop:
	ld		c,(hl)
	inc		hl
	ld		b,(hl)							; bc = ranking
	push	hl
	ld		h,b
	ld		l,c
	call	compare16HLDE
	jr		c,.HLLTDE
.HLGTEDE									; Found the correct rank
	pop		hl
	inc		hl								; move to next value
	inc		hl
	inc		a								; we canloop forever as if kills was $FFFF then hits nutter rank but also +1 = 0000 as its 16 bit
	jr		.testLoop
.HLLTDE:									; HL < Kills so found correct rank
	pop		hl
	ret
