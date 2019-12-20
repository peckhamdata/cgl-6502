fill_mem_char:	.byte $00
fill_mem_size:  .byte $00
fill_mem_from:  .byte $00, $00

fill_mem:	ldy fill_mem_size
			lda fill_mem_from
			sta $02
			lda fill_mem_from+1
			sta $03
			lda fill_mem_char
!loop:		sta ($02),y
			dey
			bne !loop-
			rts