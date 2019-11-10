screen_left:    ldy #$00
shift_line:     lda screen+1,y
                sta screen,y
                iny
                cpy #$28
                bne shift_line
                rts