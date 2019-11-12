num1Hi:             .byte $0
num2:               .byte $0

p0:                 .byte $0
p1:                 .byte $0
plot_headless:      .byte $0
plot_headless_x_lo: .byte $0
plot_headless_x_hi: .byte $0

plot_headless_y_lo: .byte $0
plot_headless_y_hi: .byte $0

plot_point: 
            txa
            pha
            tya
            pha

            lda plot_headless
            beq head
            lda plot_headless_x_lo
            sta $02
            lda plot_headless_x_hi
            sta $03
            ldy #$00
            lda p0
            sta ($02),y
            inc plot_headless_x_lo
            bcc !next+
            inc plot_headless_x_hi
!next:      lda plot_headless_y_lo
            sta $02
            lda plot_headless_y_hi
            sta $03
            ldy #$00
            lda p1
            sta ($02),y
            inc plot_headless_y_lo
            bcc !next+
            inc plot_headless_y_hi
!next:      jmp !exit+
head:       clc
            lda p0
            cmp #$28
            bcs !exit+

            clc
            lda p1
            cmp #$18    
            bcs !exit+

            lda #$28
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
            sty num1Hi  // remove this line for 16*8=16bit multiply
            beq enterLoop

doAdd:      clc
            adc p1
            tax

            tya
            adc num1Hi
            tay
            txa

            !loop:
            asl p1
            rol num1Hi
enterLoop:  // accumulating multiply entry point (enter with .A=lo, .Y=hi)
            lsr num2
            bcs doAdd
            bne !loop-

            sta $02
            tya
            adc #$04
            sta $03

            ldy p0
            lda #$3a
            sta ($02),y

!exit:      pla
            tay
            pla
            tax
            rts

