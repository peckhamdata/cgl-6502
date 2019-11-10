screen_left:    ldx #$00
                lda #$00
                sta $02
                lda #$04
                sta $03
row_loop:       ldy #$00
col_loop:       inc $02
                lda ($02),y
                dec $02
                sta ($02),y
                iny
                cpy #$27
                bne col_loop
                lda #$20
                sta ($02),y
                lda $02
                adc #$27
                sta $02
                bcc next_row
                inc $03
next_row:       inx
                cpx #$19
                bne row_loop
                rts