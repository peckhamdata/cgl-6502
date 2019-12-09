// Cycle through the sprite animation

test_figure:    lda #$00
                sta $d020
                sta $d021
                lda #$01
                sta $d015
                lda #$00
                sta $d000
                lda #$a0
                sta $d001
                ldy #$00
!start:         ldx #$c1

!loop:          stx $07F8
wait:           lda #$ff
                cmp $d012
                bne wait
                iny
                cpy #$10
                bne wait
                ldy #$00
                inc $d000
                bne !continue+
                lda $d010
                eor #%00000001
                sta $d010
!continue:      inx
                cpx #$c7
                bne !loop-
                jmp !start-
                rts