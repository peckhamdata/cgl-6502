test_curve: 

            // test_set_t

                //   t = i / n_seg
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

            // test_set_t1

            // test_set_a_b_c

            // test_set_x_y

            // test_shift_right

            // test_plot_curve

                rts