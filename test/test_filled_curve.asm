test_filled_curve:

                lda #$0b
                sta curve_num_segments

                lda #$01
                sta curve_p1_x
                lda #$05     // #$13
                sta curve_p2_x
                lda #$20 // #$27
                sta curve_p3_x

                lda #$29
                sta curve_p1_y
                lda #$00
                sta curve_p2_y
                lda #$29
                sta curve_p3_y

                lda #$00 // <actual_curve_buffer
                sta plot_buffer_lo
                lda #$04 // #>actual_curve_buffer
                sta plot_buffer_hi
                lda #$28
                sta plot_buffer_x
                lda #$18
                sta plot_buffer_y            
                lda #$d4
                sta plot_char
                sta curve_fill_char
                lda #$01
                sta curve_is_filled
                jsr curve_plot

                lda #$0a
                sta curve_p1_x
                lda #$20     // #$13
                sta curve_p2_x
                lda #$27 // #$27
                sta curve_p3_x

                lda #$7e
                sta plot_char
                sta curve_fill_char

                lda #$29
                sta curve_p1_y
                lda #$04
                sta curve_p2_y
                lda #$29
                sta curve_p3_y

                jsr curve_plot

                lda #<expected_filled_curve_buffer
                sta expected_plot_buffer_lo
                lda #>expected_filled_curve_buffer
                sta expected_plot_buffer_hi

                lda plot_buffer_lo
                sta actual_plot_buffer_lo
                lda plot_buffer_hi
                sta actual_plot_buffer_hi
                lda plot_buffer_x
                sta buffers_x
                lda plot_buffer_y
                sta buffers_y
                jsr compare_buffers
                lda cmp_res
                bne !fail+
                lda #green
                jmp !result+
    !fail:      lda #red
    !result:    sta $d020
                rts

expected_filled_curve_buffer:
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
.text "                                        "
.text "     :                                  "
.text "    :::                                 "
.text "   :::::                                "
.text "   :::::                                "
.text "  :::::::                               "
.text "  :::::::                               "
.text "  :::::::                               "
.text " :::::::::                              "
.text " :::::::::                              "
.text " :::::::::                              "
.text " :::::::::                              "       
.text " ::::::::::                             "
.text " ::::::::::                             "