// divison spike - https://codebase64.org/doku.php?id=base:16bit_division_16-bit_result

dividend:       .byte $00
                .byte $00

divisor:        .byte $00
                .byte $00

remainder:      .byte $00
                .byte $00

result:         .byte $00
                .byte $00

num1:           .byte $00
                .byte $00

num2:           .byte $00
                .byte $00

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
!loop:
                asl dividend
                rol dividend+1
                rol
                cmp divisor
                bcc no_sub
                sbc divisor
                inc dividend
no_sub:
                dex
                bne !loop-
                pla
                tax
                rts

divide:         txa
                pha
                lda #$00        // preset remainder to 0
                sta remainder
                sta remainder+1
                ldx #16         // repeat for each bit: ...

!loop:          asl dividend    // dividend lb & hb*2, msb -> Carry
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
                bne !loop-
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
                 sty num1+1  // remove this line for 16*8=16bit multiply
                 beq !enterLoop+

!doAdd:
                 clc
                 adc num1
                 pha

                 tya
                 adc num1+1
                 tay
                 pla

!loop:
                 asl num1
                 rol num1+1
!enterLoop:  // accumulating multiply entry point (enter with .A=lo, .Y=hi)
                 lsr num2
                 bcs !doAdd-
                 bne !loop-
                 rts

// ; General 8bit * 8bit = 8bit multiply
// ; by White Flame 20030207

// ; Multiplies "num1" by "num2" and returns result in .A
// ; Instead of using a bit counter, this routine early-exits when num2 reaches zero, thus saving iterations.


// ; Input variables:
// ;   num1 (multiplicand)
// ;   num2 (multiplier), should be small for speed
// ;   Signedness should not matter

// ; .X and .Y are preserved
// ; num1 and num2 get clobbered

mult8:          lda #$00
                beq !enter_loop+

!do_add:        clc
                adc num1

!loop:          asl num1
!enter_loop: // ;For an accumulating multiply (.A = .A + num1*num2), set up num1 and num2, then enter here
                lsr num2
                bcs !do_add-
                bne !loop-

end:            rts

// ; 15 bytes