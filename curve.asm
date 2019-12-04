curve_index:        .byte $00
curve_num_segments: .byte $00
                    .byte $00
curve_t:            .byte $00
                    .byte $00

curve_set_t:        lda #$00
                    sta dividend+1
                    lda curve_index
                    sta dividend

                    lda curve_num_segments
                    sta divisor
                    lda curve_num_segments+1
                    sta divisor+1

                    jsr divide

                    lda remainder
                    sta curve_t
                    lda remainder+1
                    sta curve_t+1
                    rts