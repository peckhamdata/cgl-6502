screen_left:    ldx #$00
                lda #$00
                sta $02
                lda #$04
                sta $03
shift_col:      ldy #$00
shift_line:     inc $02
shift_2:        lda ($02),y
                dec $02
shift_3:        sta ($02),y
                iny
                cpy #$27
                bne shift_line
                lda #$20
                sta ($02),y
                lda $02
                adc #$27
                sta $02
                bcc shift_cont
                inc $03
shift_cont:     inx
                cpx #$19
                bne shift_col
                rts