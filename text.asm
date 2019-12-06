
text_src:   .byte $00, $00

text_plot:  ldy #$00
            lda text_src
            sta $02
            lda text_src+1
            sta $03
!next:      lda ($02),y
            sta p0
            iny
            lda ($02),y
            sta p1
            iny
            lda ($02),y
            sta plot_char
!loop:      
            jsr plot_point
            inc p0
            lda text_src
            sta $02
            lda text_src+1
            sta $03
            iny
            lda ($02),y
            sta plot_char
            cmp #$5c // control character
            bne !loop-
            iny
            lda ($02),y
            cmp #$0e
            bne !next+
            iny
            iny
            jmp !next-
!next:      cmp #$30
            beq !exit+
            dey
            jmp !loop-
!exit:      rts