// Cycle through the sprite animation

test_figure:	lda #$01
				sta $d015
				lda #$a0
				sta $d000
				sta $d001
				ldy #$00
!start:			ldx #$c1	

!loop:			stx $07F8
wait:			lda #$ff
				cmp $d012
				bne wait
				iny
				cpy #$20
				bne wait
				ldy #$00
				inx
				cpx #$c7
				bne !loop-
				jmp !start-
				rts