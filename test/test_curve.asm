test_curve: 
                // test_set_t: t = i / n_seg
                ldx #$03
                lda #$0a
                sta curve_num_segments
                curve_set_t()
                lda curve_t
                cmp #$03        // Scaled integer for .3
                bne !fail+
                lda #green
                jmp !result+
!fail:          lda #red
!result:        sta $d020
                // test_set_t1: t1 = 1.0 - t
                curve_set_t1()
                lda curve_t1
                cmp #$07
                bne !fail+
                lda #green
                jmp !result+
!fail:          lda #red
!result:        sta $d020
                // test_set_a_b_c
                curve_set_a_b_c()
                lda curve_a
                cmp #$31
                bne !fail+
                lda curve_b
                cmp #$2a
                bne !fail+
                lda curve_c
                cmp #$09
                bne !fail+
                lda #green
                jmp !result+
!fail:          lda #red
!result:        sta $d020
                // test_set_x_y
                ldx #$03
                curve_set_x_y()
                lda curve_pts_x_lo,x
                cmp #$e2
                bne !fail+
                lda curve_pts_x_hi,x
                cmp #$03
                bne !fail+
                lda curve_pts_y_lo,x
                cmp #$c5
                bne !fail+
                lda curve_pts_y_hi,x
                cmp #$01
                bne !fail+
                lda #green
                jmp !result+
!fail:          lda #red
!result:        sta $d020
                // test_shift_right
                curve_shift_right()
                lda curve_pts_x,x
                cmp #$09
                bne !fail+
                lda curve_pts_y,x
                cmp #$04
                bne !fail+
                lda #green
                jmp !result+
!fail:          lda #red
!result:        sta $d020

                // test_plot_curve
                lda #$0a
                sta curve_num_segments

                lda #<actual_curve_buffer
                sta plot_buffer_lo
                lda #>actual_curve_buffer
                sta plot_buffer_hi
                lda #$1d
                sta plot_buffer_x
                lda #$0b
                sta plot_buffer_y            

                jsr curve_plot
                lda #<expected_curve_buffer
                sta expected_plot_buffer_lo
                lda #>expected_curve_buffer
                sta expected_plot_buffer_hi

                lda #<actual_curve_buffer
                sta actual_plot_buffer_lo
                lda #>actual_curve_buffer
                sta actual_plot_buffer_hi
                lda #$1d
                sta buffers_x
                lda #$04
                sta buffers_y
                jsr compare_buffers
                lda cmp_res
                bne !fail+
                lda #green
                jmp !result+
    !fail:      lda #red
    !result:    sta $d020
                rts

// test curve with plot buffer offset for large difference between mid and start/end points

 expected_curve_buffer: .text " ::                          "
                        .text "   :                         "
                        .text "    ::                       "
                        .text "      ::                     "
                        .text "        ::::                 "
                        .text "            ::               "
                        .text "              ::             "
                        .text "                ::::         "
                        .text "                    ::::     "
                        .text "                        :::: "
                        .text "                            :"

.byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
.byte $ff, $ff, $ff, $ff, $ff

 actual_curve_buffer:   .text "                             "
                        .text "                             "
                        .text "                             "
                        .text "                             "
                        .text "                             "
                        .text "                             "
                        .text "                             "
                        .text "                             "
                        .text "                             "
                        .text "                             "
                        .text "                             "
