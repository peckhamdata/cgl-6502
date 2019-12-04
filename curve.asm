* = $3000
curve_a:            .byte $00
                    .byte $00
curve_b:            .byte $00
                    .byte $00
curve_c:            .byte $00
                    .byte $00
curve_index:        .byte $00
curve_num_segments: .byte $00
                    .byte $00
curve_t:            .byte $00
                    .byte $00
curve_t1:           .byte $00
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

curve_set_t1:       sec
                    lda #$0a
                    sbc curve_t
                    sta curve_t1

                    lda #$00
                    sbc curve_t+1
                    sta curve_t1+1
                    rts

curve_set_a_b_c:    //   a = Pow(t1, 2)
                    // https://www.youtube.com/watch?v=EmsbsInpLHs
                    lda curve_t1
                    sta num1
                    sta num2
                    jsr multiply
                    sta curve_a
                    sty curve_a+1
                    //   b = 2.0 * t * t1
                    lda curve_t
                    sta num1
                    lda curve_t+1
                    sta num1+1
                    lda curve_t1
                    sta num2
                    lda curve_t1+1
                    sta num2+1
                    jsr multiply
                    sta num1
                    sty num1+1
                    lda #$02
                    sta num2
                    lda #$00
                    sta num2+1
                    jsr multiply
                    sta curve_b
                    sty curve_b+1
                    //   c = Pow(t, 2)
                    lda curve_t
                    sta num1
                    sta num2
                    lda curve_t+1
                    sta num1+1
                    sta num2+1
                    jsr multiply
                    sta curve_c
                    sty curve_c+1
                    rts