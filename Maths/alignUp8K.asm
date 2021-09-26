;;----------------------------------------------------------------------------------------------------------------------
;; alignUp8K
;; align a 16-bit value up to the nearest 8K
;;
;; Input:
;;      HL = value
;;
;; Output:
;;      HL = aligned value
alignUp8K:
	push    af
	ld      a,l
	and     a               ; LSB == 0?
	jr      nz,.alreadyaligned
	ld      a,h
	and     $1f
	jr      nz,.alignup
   ; Value is already aligned
.alreadyaligned:
    pop     af
    ret
.alignup:
    ld      l,0
    ld      a,h
    and     $e0
    add     a,$20
    ld      h,a
    pop		af
	ret