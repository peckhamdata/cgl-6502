* = $1000

        // lda #$01
        // sta $8000

!start: ldx #$00
!loop:  stx $e810
        lda $e812
        sta ($8000),x
        and #%00000001
        beq !exit+
        inx
        cpx #$0a
        bne !loop-
        jmp !start-
!exit:  stx $8010
        rts        
