* = $1000

        lda #$01
        sta $8000

!start: ldx #$00
!loop:  stx $e810
        lda $e812
        sta ($8000),x
        inx
        cpx #$0a
        bne !loop-
        jmp !start-
