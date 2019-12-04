p0:                 .byte $0
p1:                 .byte $0

plot_buffer_lo:     .byte $00
plot_buffer_hi:     .byte $04
plot_buffer_x:      .byte $28
plot_buffer_y:      .byte $18

plot_point: 
            txa
            pha
            tya
            pha

            clc
            lda p0
            cmp plot_buffer_x
            bcs !exit+

            clc
            lda p1
            cmp plot_buffer_y    
            bcs !exit+

            lda plot_buffer_x
            sta num2

//------------------------
// 8bit * 8bit = 16bit multiply
// By White Flame
// Multiplies "num1" by "num2" and stores result in .A (low byte, also in .X) and .Y (high byte)
// uses extra zp var "num1Hi"

// .X and .Y get clobbered.  Change the tax/txa and tay/tya to stack or zp storage if this is an issue.
//  idea to store 16-bit accumulator in .X and .Y instead of zp from bogax

// In this version, both inputs must be unsigned
// Remove the noted line to turn this into a 16bit(either) * 8bit(unsigned) = 16bit multiply.

            lda #$00
            tay
            sty num1+1  // remove this line for 16*8=16bit multiply
            beq enterLoop

doAdd:      clc
            adc p1
            tax

            tya
            adc num1+1
            tay
            txa

!loop:
            asl p1
            rol num1+1
enterLoop:  // accumulating multiply entry point (enter with .A=lo, .Y=hi)
            lsr num2
            bcs doAdd
            bne !loop-
            tya
            adc plot_buffer_hi
            sta $03
            clc
            txa
            adc plot_buffer_lo
            sta $02
            bcc !next+
            inc $03
!next:      ldy p0
            lda #$3a
            sta ($02),y

!exit:      pla
            tay
            pla
            tax
            rts

