
curve_p1_x:         .byte 1
curve_p2_x:         .byte 15
curve_p3_x:         .byte 35

curve_p1_y:         .byte 0
curve_p2_y:         .byte 8
curve_p3_y:         .byte 13

curve_num_segments: .byte $09
                    .byte $00

curve_vars:
curve_pts_x:         .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
curve_pts_y:         .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

curve_pts_x_lo:     .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
curve_pts_x_hi:     .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
curve_pts_y_lo:     .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
curve_pts_y_hi:     .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

curve_t:            .byte $00
                    .byte $00
curve_t1:           .byte $00
                    .byte $00

curve_a:            .byte $00
                    .byte $00
curve_b:            .byte $00
                    .byte $00
curve_c:            .byte $00
                    .byte $00

curve_plot_char:    .byte $3a
curve_fill_char:    .byte $00
curve_is_filled:    .byte $00
curve_fill_color:   .byte $08

.macro curve_set_t() {        
                    lda #$00
                    sta dividend+1
                    stx dividend

                    lda curve_num_segments
                    sta divisor
                    lda curve_num_segments+1
                    sta divisor+1

                    jsr divide

                    lda remainder
                    sta curve_t
                    lda remainder+1
                    sta curve_t+1
}

.macro curve_set_t1() {
                    sec
                    lda #$0a
                    sbc curve_t
                    sta curve_t1

                    lda #$00
                    sbc curve_t+1
                    sta curve_t1+1
}

.macro curve_set_a_b_c() {
                    //   a = Pow(t1, 2)
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
}

.macro curve_set_x_y() {
                    // X
                    lda curve_a
                    sta num1
                    lda curve_p1_x
                    sta num2
                    lda #$00
                    sta num1+1
                    sta num2+1
                    jsr multiply
                    sta curve_pts_x_lo,x
                    tya
                    sta curve_pts_x_hi,x

                    lda curve_b
                    sta num1
                    lda curve_p2_x
                    sta num2
                    lda #$00
                    sta num1+1
                    sta num2+1
                    jsr multiply
                    adc curve_pts_x_lo,x
                    sta curve_pts_x_lo,x
                    tya
                    adc curve_pts_x_hi,x
                    sta curve_pts_x_hi,x

                    lda curve_c
                    sta num1
                    lda curve_p3_x
                    sta num2
                    lda #$00
                    sta num1+1
                    sta num2+1
                    jsr multiply
                    adc curve_pts_x_lo,x
                    sta curve_pts_x_lo,x
                    tya
                    adc curve_pts_x_hi,x
                    sta curve_pts_x_hi,x
                    // Y
                    lda curve_a
                    sta num1
                    lda curve_p1_y
                    sta num2
                    lda #$00
                    sta num1+1
                    sta num2+1
                    jsr multiply
                    adc curve_pts_y_lo,x
                    sta curve_pts_y_lo,x
                    tya
                    adc curve_pts_y_hi,x
                    sta curve_pts_y_hi,x

                    lda curve_b
                    sta num1
                    lda curve_p2_y
                    sta num2
                    lda #$00
                    sta num1+1
                    sta num2+1
                    jsr multiply
                    adc curve_pts_y_lo,x
                    sta curve_pts_y_lo,x
                    tya
                    adc curve_pts_y_hi,x
                    sta curve_pts_y_hi,x

                    lda curve_c
                    sta num1
                    lda curve_p3_y
                    sta num2
                    lda #$00
                    sta num1+1
                    sta num2+1
                    jsr multiply
                    adc curve_pts_y_lo,x
                    sta curve_pts_y_lo,x
                    tya
                    adc curve_pts_y_hi,x
                    sta curve_pts_y_hi,x
}

.macro curve_shift_right() {
                    lda curve_pts_x_lo,x
                    sta dividend
                    lda curve_pts_x_hi,x
                    sta dividend+1
                    lda #$64
                    sta divisor
                    lda #$00
                    sta divisor+1
                    jsr div16
                    lda dividend
                    sta curve_pts_x,x

                    lda curve_pts_y_lo,x
                    sta dividend
                    lda curve_pts_y_hi,x
                    sta dividend+1
                    lda #$64
                    sta divisor
                    lda #$00
                    sta divisor+1
                    jsr div16
                    lda dividend
                    sta curve_pts_y,x
}

curve_plot:         ldx #$00
                    lda #$00
!loop:              sta (curve_vars),x
                    inx
                    cpx #$47
                    bne !loop-

                    ldx #$00
!loop:          
                    curve_set_t()
                    curve_set_t1()
                    curve_set_a_b_c()
                    curve_set_x_y()
                    curve_shift_right()
                    inx
                    cpx curve_num_segments 
                    beq !done+
                    jmp !loop-
!done:              ldx #$00
                    dec curve_num_segments     
!loop:  
                    lda (curve_pts_x),x
                    sta x0          
                    lda (curve_pts_x+1),x
                    sta x1          
                    lda (curve_pts_y),x
                    sta y0          
                    lda (curve_pts_y+1),x
                    sta y1
                    jsr init_line
                    jsr plot_line
                    inx
                    cpx curve_num_segments      
                    beq !done+
                    jmp !loop-
!done:              rts
