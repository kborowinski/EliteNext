	ld		hl,23
	ld		de,43
	ld		bc,$0000
	call	ADDHLDESignBC; XX12ProcessCalcHLPlusDESignBC
	
	ld		hl,23
	ld		de,43
	ld		bc,$0080
	call	ADDHLDESignBC
	
	ld		hl,23
	ld		de,43
	ld		bc,$8000
	call	ADDHLDESignBC
	
	ld		hl,23
	ld		de,43
	ld		bc,$8080
	call	ADDHLDESignBC	
	
	ld		hl,43
	ld		de,23
	ld		bc,$0000
	call	ADDHLDESignBC	
	
	ld		hl,43
	ld		de,23
	ld		bc,$0080
	call	ADDHLDESignBC	
	
	ld		hl,43
	ld		de,23
	ld		bc,$8000
	call	ADDHLDESignBC	
	
	ld		hl,43
	ld		de,23
	ld		bc,$8080
	call	ADDHLDESignBC	
	
	ld		hl,150
	ld		de,12
	ld		bc,$0000
	call	ADDHLDESignBC	
	
	ld		hl,150
	ld		de,12
	ld		bc,$0080
	call	ADDHLDESignBC	
	
	ld		hl,150
	ld		de,12
	ld		bc,$8000
	call	ADDHLDESignBC	
	
	ld		hl,150
	ld		de,12
	ld		bc,$8080
	call	ADDHLDESignBC	
	