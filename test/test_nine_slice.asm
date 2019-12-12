expected_9s_buffer:
    // 0123456789012345678901234567890123456789
.text "                                        "
.text " 12223                 2        2       "
.text " 45556         13      5        5       "
.text " 45556         79      8        5   2   "
.text " 45556                          5   8   "
.text " 45556       13                 5       "
.text " 78889       46        123      5       "
.text "             46        456      5       "
.text "             79        456      8       "
.text "   4555555556          456          5   "
.text "                       789              "

test_nine_slice_chars: .text "123456789"

// test_nine_slice_x: .byte $01, $0f, $20, $17, $04, $09, $17, $24, $0c, $24
// test_nine_slice_y: .byte $01, $02, $01, $06, $09, $24, $01, $03, $05, $09
// test_nine_slice_w: .byte $05, $02, $01, $03, $0a, $01, $01, $01, $02, $01 
// test_nine_slice_h: .byte $06, $02, $08, $05, $01, $01, $03, $02, $04, $01

test_nine_slice_x: .byte $00, $01, $03, $05, $07, $0a, $0d, $0f, $10, $12, $13, $17, $1a, $1f, $1e, $24
test_nine_slice_y: .byte $07, $05, $04, $07, $08, $07, $02, $03, $01, $05, $00, $01, $02, $03, $00, $05
test_nine_slice_w: .byte $09, $02, $03, $02, $04, $04, $03, $04, $02, $06, $03, $04, $04, $05, $02, $04
test_nine_slice_h: .byte $03, $05, $06, $03, $02, $03, $08, $07, $09, $05, $0a, $09, $08, $07, $0a, $05

test_nine_slice:
            ldx #$00
!loop:      lda test_nine_slice_x,x
            sta nine_slice_x
            lda test_nine_slice_y,x
            adc #$05
            sta nine_slice_y

            lda test_nine_slice_w,x
            sta nine_slice_w
            lda test_nine_slice_h,x
            sta nine_slice_h
            lda #$28
            sta plot_buffer_x
            lda #$0b
            sta plot_buffer_y 
            lda #$00
            sta plot_buffer_lo
            lda #$04
            sta plot_buffer_hi
            inc nine_slice_color

            jsr nine_slice_plot

            ldy #$00
!wait:      lda #$ff
            cmp $d012
            bne !wait-
            iny
            cpy #$20
            bne !wait-

            inx
            cpx #$10
            bne !loop-
            rts  