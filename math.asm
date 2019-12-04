// divison spike - https://codebase64.org/doku.php?id=base:16bit_division_16-bit_result

dividend:       .byte $00
                .byte $00

divisor:        .byte $00
                .byte $00

remainder:      .byte $00
                .byte $00

result:         .byte $00
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
