
// Given:

test_init_line: lda #$00
                sta steep
                lda #$0a
                sta x0
                lda #$0e
                sta y0
                lda #$01
                sta x1
                lda #$02
                sta y1

// When we initialise a line

                jsr init_line

// Then we should get:

                lda steep
                cmp expected_steep
                bne !fail+
                lda x0
                cmp expected_x0
                bne !fail+
                lda y0
                cmp expected_y0
                bne !fail+
                lda x1
                cmp expected_x1
                bne !fail+
                lda y1
                cmp expected_y1
                bne !fail+
                lda delta_x
                cmp expected_delta_x
                bne !fail+
                lda delta_y
                cmp expected_delta_y
                bne !fail+
                lda error
                cmp expected_error
                bne !fail+
                lda y_step
                cmp expected_y_step
                bne !fail+
                lda #green
                jmp !exit+

!fail:          lda #red
!exit:          sta $d020
                rts

expected_steep: .byte $01
expected_x0: .byte $02
expected_y0: .byte $01
expected_y1: .byte $0a
expected_x1: .byte $0e
expected_delta_x: .byte $0c // d
expected_delta_y: .byte $09
expected_error: .byte $06 // .5 (!)
expected_y_step: .byte $01

test_plot_line: clc
                lda #$00 // #<actual_line_buffer
                sta plot_buffer_lo
                lda #$04 //#>actual_line_buffer
                sta plot_buffer_hi
                lda #$28 // #$09
                sta plot_buffer_x
                lda #$19 // #$0e
                sta plot_buffer_y            

                // Given ^^^

                lda expected_steep
                sta steep
                lda expected_x0
                sta x0
                lda expected_y0
                sta y0
                lda expected_x1
                sta x1
                lda expected_y1
                sta y1
                lda expected_delta_x
                sta delta_x
                lda expected_delta_y
                sta delta_y
                lda expected_error
                sta error
                lda expected_y_step
                sta y_step
                // When we plot a line
                jsr plot_line
                // Then we should get
                lda #<expected_line_buffer
                sta expected_plot_buffer_lo
                lda #>expected_line_buffer
                sta expected_plot_buffer_hi

                lda #<actual_line_buffer
                sta actual_plot_buffer_lo
                lda #>actual_line_buffer
                sta actual_plot_buffer_hi

                lda #$09
                sta buffers_x
                lda #$0e
                sta buffers_y
                jsr compare_buffers
                lda cmp_res
                bne !fail+
                lda #green
                jmp !result+
    !fail:      lda #red
    !result:    sta $d020
                rts

 expected_line_buffer:  .text "         "
                        .text "         "
                        .text " :       "
                        .text " :       "
                        .text "  :      "
                        .text "  :      "
                        .text "   :     "
                        .text "    :    "
                        .text "     :   "
                        .text "     :   "
                        .text "      :  "
                        .text "       : "
                        .text "        :"
                        .text "        :"

 actual_line_buffer:    .text "         "
                        .text "         "
                        .text "         "
                        .text "         "
                        .text "         "
                        .text "         "
                        .text "         "
                        .text "         "
                        .text "         "
                        .text "         "
                        .text "         "
                        .text "         "
                        .text "         "
                        .text "         "
                        .text "         "
