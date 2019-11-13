test_init_line: nop

// Given:

// steep = False
// x0 = 10
// y0 = 15
// x1 = 1
// y1 = 2

// When we initialise a line

// Then we should get:

expected_steep: .byte 1
expected_x0: .byte 2
expected_y0: .byte 1
expected_y1: .byte 10
expected_x1: .byte 15
expected_delta_x: .byte 13
expected_delta_y: .byte 9
expected_error: .byte 6 // .5 (!)
expected_y_step: .byte 1

test_plot_line: clc

                lda #<actual_line_buffer
                sta plot_buffer_lo
                lda #>actual_line_buffer
                sta plot_buffer_hi
                lda #$09
                sta plot_buffer_x
                lda #$0e
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
                        .text ":        "
                        .text ":        "
                        .text " :       "
                        .text " :       "
                        .text "  :      "
                        .text "   :     "
                        .text "   :     "
                        .text "    :    "
                        .text "     :   "
                        .text "      :  "
                        .text "      :  "
                        .text "       : "

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
