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