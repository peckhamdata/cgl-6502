test_curve:     // test_set_t: t = i / n_seg
                lda #$03
                sta curve_index
                lda #$10
                sta curve_num_segments
                jsr curve_set_t
                lda curve_t
                cmp #$03        // Scaled integer for .3
                bne !fail+
                lda #green
                jmp !result+
!fail:          lda #red
!result:        sta $d020

                // test_set_t1: t1 = 1.0 - t
                jsr curve_set_t1
                lda curve_t1
                cmp #$07
                bne !fail+
                lda #green
                jmp !result+
!fail:          lda #red
!result:        sta $d020
                // test_set_a_b_c
                jsr curve_set_a_b_c
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
                jsr curve_set_x_y
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

            // test_plot_curve

                rts