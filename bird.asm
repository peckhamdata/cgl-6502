// bird

        .var screen=$0400

:BasicUpstart2(start)

start:	ldx #$00
!loop:	jsr screen_left
		inx
		cpx #$8
		bne !loop-
		rts

.import source "screen_left.asm"
