actual_9s_buffer:
.text "                                        "
.text "                                        "
.text "                                        "
.text "                                        "
.text "                                        "
.text "                                        "
.text "                                        "
.text "                                        "
.text "                                        "
.text "                                        "
.text "                                        "

expected_9s_buffer:
    // 0123456789012345678901234567890123456789
.text "                                        "
.text " 12223                 2        2       "
.text " 45556         13      5        5       "
.text " 45556         79      8        5   2   "
.text " 45556                          5   8   "
.text " 45556      13                  5       "
.text " 78889      46         123      5       "
.text "            46         456      5       "
.text "            79         456      8       "
.text "  4555555556           456          5   "
.text "                       789              "

test_nine_slice_chars: .text "123456789"

test_nine_slice_x: .byte $01, $0f, $20, $17, $02, $09, $17, $24, $0c, $24
test_nine_slice_y: .byte $01, $02, $01, $06, $09, $24, $01, $03, $05, $09
test_nine_slice_w: .byte $05, $02, $01, $03, $0a, $01, $01, $01, $02, $01 
test_nine_slice_h: .byte $06, $02, $08, $05, $01, $01, $03, $02, $04, $01

test_nine_slice:

            ldx #$00
!loop:      lda test_nine_slice_chars,x
            sta nine_slice_chars,x
            inx
            cpx #$09
            bne !loop-


            ldx #$00
!loop:      lda test_nine_slice_x,x
            sta nine_slice_x
            lda test_nine_slice_y,x
            sta nine_slice_y

            lda test_nine_slice_w,x
            sta nine_slice_w
            lda test_nine_slice_h,x
            sta nine_slice_h
            lda #$28
            sta plot_buffer_x
            lda #$0b
            sta plot_buffer_y 
            lda #<actual_9s_buffer
            sta plot_buffer_lo
            lda #>actual_9s_buffer
            sta plot_buffer_hi

            jsr nine_slice_plot

            inx
            cpx #$0a
            bne !loop-

            lda #<expected_9s_buffer
            sta expected_plot_buffer_lo
            lda #>expected_9s_buffer
            sta expected_plot_buffer_hi

            lda plot_buffer_lo
            sta actual_plot_buffer_lo
            lda plot_buffer_hi
            sta actual_plot_buffer_hi
            lda #$28
            sta buffers_x
            lda #$06
            sta buffers_y
            jsr compare_buffers
            lda cmp_res
            bne !fail+
            lda #green
            jmp !result+
!fail:      lda #red
!result:    sta $d020

            rts  