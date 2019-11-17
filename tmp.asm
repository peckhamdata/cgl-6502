

vars:
pts_x:                  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
pts_y:                  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

divisor:                .byte $00       
                        .byte $00       
dividend:               .byte $00       
                        .byte $00
remainder:              .byte $00       
                        .byte $00
result:                 .byte $00       
                        .byte $00

pts_x_lo:               .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
pts_x_hi:               .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
pts_y_lo:               .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
pts_y_hi:               .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

a_lo:                   .byte $00
a_hi:                   .byte $00

b_lo:                   .byte $00
b_hi:                   .byte $00

c_lo:                   .byte $00
c_hi:                   .byte $00

t1_lo:                  .byte $00
t1_hi:                  .byte $00

t_lo:                   .byte $00       
t_hi:                   .byte $00       

// num1:                   .byte $00
// num1Hi:                 .byte $00
// num2:                   .byte $00
                        .byte $00

n_seg_lo:               .byte $0a
n_seg_hi:               .byte $00

i:                      .byte $01       

p1_x:                   .byte 1
p2_x:                   .byte 15
p3_x:                   .byte 35

p1_y:                   .byte 0
p2_y:                   .byte 8
p3_y:                   .byte 13

bang:          // Blat everthing
                ldx #$00
                lda #$00
!loop:          sta (vars),x
                inx
                cpx #$4e
                bne !loop-

                // For i = 0 To n_seg
                lda #$00
                sta $d020
                sta $d021

                ldx #$00

                //   t = i / n_seg
!loop:          lda #$00
                sta dividend+1
                stx dividend

                lda n_seg_lo
                sta divisor
                lda n_seg_hi
                sta divisor+1

                jsr divide

                lda remainder
                sta t_lo
                lda remainder+1
                sta t_hi
                // t1 = 1.0 - t
                sec
                lda #$0a
                sbc t_lo
                sta t1_lo

                lda #$00
                sbc t1_hi
                sta t1_hi

                //   a = Pow(t1, 2)
                // https://www.youtube.com/watch?v=EmsbsInpLHs
                lda t1_lo
                sta num1
                sta num2
                jsr multiply
                sta a_lo
                sty a_hi
                //   b = 2.0 * t * t1
                lda t_lo
                sta num1
                lda t_hi
                sta num1Hi
                lda t1_lo
                sta num2
                lda t1_hi
                sta num2+1
                jsr multiply
                sta num1
                sty num1Hi
                lda #$02
                sta num2
                lda #$00
                sta num2+1
                jsr multiply
                sta b_lo
                sty b_hi
                //   c = Pow(t, 2)
                lda t_lo
                sta num1
                sta num2
                lda t_hi
                sta num1Hi
                sta num2+1
                jsr multiply
                sta c_lo
                sty c_hi
                // X
                lda a_lo
                sta num1
                lda p1_x
                sta num2
                lda #$00
                sta num1Hi
                sta num2+1
                jsr multiply
                sta pts_x_lo,x
                tya
                sta pts_x_hi,x

                lda b_lo
                sta num1
                lda p2_x
                sta num2
                lda #$00
                sta num1Hi
                sta num2+1
                jsr multiply
                adc pts_x_lo,x
                sta pts_x_lo,x
                tya
                adc pts_x_hi,x
                sta pts_x_hi,x

                lda c_lo
                sta num1
                lda p3_x
                sta num2
                lda #$00
                sta num1Hi
                sta num2+1
                jsr multiply
                adc pts_x_lo,x
                sta pts_x_lo,x
                tya
                adc pts_x_hi,x
                sta pts_x_hi,x
                // Y
                lda a_lo
                sta num1
                lda p1_y
                sta num2
                lda #$00
                sta num1Hi
                sta num2+1
                jsr multiply
                adc pts_y_lo,x
                sta pts_y_lo,x
                tya
                adc pts_y_hi,x
                sta pts_y_hi,x

                lda b_lo
                sta num1
                lda p2_y
                sta num2
                lda #$00
                sta num1Hi
                sta num2+1
                jsr multiply
                adc pts_y_lo,x
                sta pts_y_lo,x
                tya
                adc pts_y_hi,x
                sta pts_y_hi,x

                lda c_lo
                sta num1
                lda p3_y
                sta num2
                lda #$00
                sta num1Hi
                sta num2+1
                jsr multiply
                adc pts_y_lo,x
                sta pts_y_lo,x
                tya
                adc pts_y_hi,x
                sta pts_y_hi,x

                // shift result right to get plot co-ords

                lda pts_x_lo,x
                sta dividend
                lda pts_x_hi,x
                sta dividend+1
                lda #$64
                sta divisor
                lda #$00
                sta divisor+1
                jsr div16
                lda dividend
                sta pts_x,x

                lda pts_y_lo,x
                sta dividend
                lda pts_y_hi,x
                sta dividend+1
                lda #$64
                sta divisor
                lda #$00
                sta divisor+1
                jsr div16
                lda dividend
                sta pts_y,x

                inx
                cpx n_seg_lo
                beq !done+
                jmp !loop-
!done:          
                ldx #$00
!loop:          lda (pts_x),x
                sta x0          
                lda (pts_x+1),x
                sta x1          
                lda (pts_y),x
                sta y0          
                lda (pts_y+1),x
                sta y1
                jsr init_line
                jsr plot_line
                inx
                cpx #$09        
                bne !loop-
                rts

// http://forums.nesdev.com/viewtopic.php?t=143
// ;;; div16
// ;   Given a 16-bit number in dividend, divides it by divisor and
// ;   stores the result in dividend.
// ;   out: A: remainder; X: 0; Y: unchanged
div16:
                txa
                pha
                ldx #16
                lda #0
!divloop:
                asl dividend
                rol dividend+1
                rol
                cmp divisor
                bcc no_sub
                sbc divisor
                inc dividend
no_sub:
                dex
                bne !divloop-
                pla
                tax
                rts


// divison spike - https://codebase64.org/doku.php?id=base:16bit_division_16-bit_result


divide:         txa
                pha
                lda #$00          // preset remainder to 0
                sta remainder
                sta remainder+1
                ldx #16         // repeat for each bit: ...

!divloop:       asl dividend    // dividend lb & hb*2, msb -> Carry
                rol dividend+1  
                rol remainder   // remainder lb & hb * 2 + msb from carry
                rol remainder+1
                lda remainder
                sec
                sbc divisor     // substract divisor to see if it fits in
                tay             // lb result -> Y, for we may need it later
                lda remainder+1
                sbc divisor+1
                bcc skip        // if carry=0 then divisor didn't fit in yet

                sta remainder+1 // else save substraction result as new remainder,
                sty remainder   
                inc result      // and INCrement result cause divisor fit in 1 times

skip:           dex
                bne !divloop-
                pla
                tax     
                rts

// https://codebase64.org/doku.php?id=base:8bit_multiplication_16bit_product

// ;------------------------
// ; 8bit * 8bit = 16bit multiply
// ; By White Flame
// ; Multiplies "num1" by "num2" and stores result in .A (low byte, also in .X) and .Y (high byte)
// ; uses extra zp var "num1Hi"

// ; .X and .Y get clobbered.  Change the tax/txa and tay/tya to stack or zp storage if this is an issue.
// ;  idea to store 16-bit accumulator in .X and .Y instead of zp from bogax

// ; In this version, both inputs must be unsigned
// ; Remove the noted line to turn this into a 16bit(either) * 8bit(unsigned) = 16bit multiply.

multiply:        
                 lda #$00
                 tay
                 sty num1Hi  // remove this line for 16*8=16bit multiply
                 beq !enterLoop+

!doAdd:
                 clc
                 adc num1
                 pha

                 tya
                 adc num1Hi
                 tay
                 pla

!loop:
                 asl num1
                 rol num1Hi
!enterLoop:  // accumulating multiply entry point (enter with .A=lo, .Y=hi)
                 lsr num2
                 bcs !doAdd-
                 bne !loop-
                 rts

// .import source "plot_point.asm"
// .import source "line.asm"

