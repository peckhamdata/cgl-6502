test_filled_curve:

                lda #$0b
                sta curve_num_segments

                lda #$01
                sta curve_p1_x
                lda #$13
                sta curve_p2_x
                lda #$27
                sta curve_p3_x

                lda #$29
                sta curve_p1_y
                lda #$00
                sta curve_p2_y
                lda #$29
                sta curve_p3_y

                lda #<actual_filled_curve_buffer
                sta plot_buffer_lo
                lda #>actual_filled_curve_buffer
                sta plot_buffer_hi
                lda #$28
                sta plot_buffer_x
                lda #$18
                sta plot_buffer_y            
                lda #$3a
                sta plot_char
                sta curve_fill_char
                lda #$01
                sta curve_is_filled
                lda #$0a
                sta plot_y_offset

                lda #$0f
                sta plot_color
                sta curve_fill_color

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

actual_filled_curve_buffer:
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
.text "                                        "

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
.text "                  ::::                  "
.text "               ::::::::::               "
.text "             ::::::::::::::             "
.text "           :::::::::::::::::            "
.text "          :::::::::::::::::::           "
.text "          ::::::::::::::::::::          "
.text "         ::::::::::::::::::::::         "
.text "        ::::::::::::::::::::::::        "
.text "       ::::::::::::::::::::::::::       "
.text "       ::::::::::::::::::::::::::       "
.text "      ::::::::::::::::::::::::::::      "
.text "     ::::::::::::::::::::::::::::::     "
.text "     ::::::::::::::::::::::::::::::     "
.text "    ::::::::::::::::::::::::::::::::    "
.text "    ::::::::::::::::::::::::::::::::    "
.text "    ::::::::::::::::::::::::::::::::    "