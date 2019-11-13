
// Given:

test_plot_line: lda #$00
                sta steep
                lda #$0a
                sta x0
                lda #$0e
                sta y0
                lda #$01
                sta x1
                lda #$02
                sta y1
                clc
                lda #<actual_line_buffer
                sta plot_buffer_lo
                lda #>actual_line_buffer
                sta plot_buffer_hi
                lda #$09
                sta plot_buffer_x
                lda #$0e
                sta plot_buffer_y            

                // Given ^^^

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
