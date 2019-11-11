// Roll a region of memory such as a buffer one column to the left
// This could replace the dedicated screen left shifter too

region_lo:  .byte 0
region_hi:  .byte 0
region_x:   .byte 0
region_y:   .byte 0

region_left:    txa
                pha
                ldx #$00
                lda region_lo
                sta $02
                lda region_hi
                sta $03
!row_loop:      ldy #$01
!col_loop:      lda ($02),y
                dey
                sta ($02),y
                iny
                iny
                cpy region_x
                bne !col_loop-
                lda #$20
                dey
                sta ($02),y
                clc
                lda $02
                adc region_x
                sta $02
                bcc !next_row+
                inc $03
!next_row:      inx
                cpx region_y
                bne !row_loop-
                pla
                tax
                rts