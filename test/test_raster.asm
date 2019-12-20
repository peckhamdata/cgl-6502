// Hello World with raster interrupt colour band
// cobbled together from many examples and sources

test_raster:

  .var BORDER=$d020    // Screen border colour
  .var SCREEN=$d021    // Screen background colour

  .var BANDTOP=10      // Raster line to start band
  .var BANDEND=160     // Bottom raster line to switch back

irqinit:
  lda #$00
  sta BORDER
  sei             // Suspend interrupts during init

  lda #$7f        // Disable CIA
  sta $dc0d
  sta $dd0d       // No cursor / no keyboard

  lda $d01a       // Enable raster interrupts
  ora #$01
  sta $d01a

  lda $d011       // High bit of raster line cleared, we're
  and #$7f        // only working within single byte ranges
  sta $d011

  lda #BANDTOP    // We want an interrupt at the top line
  sta $d012

  lda #<bg    // Push low and high byte of our routine into
  sta $0314       // IRQ vector addresses
  lda #>bg
  sta $0315

  cli             // Enable interrupts again

rts

colors: .byte $06, $0e, $06, $0e, $06, $0e, $03, $0e, $03, $0a, $03, $0a, $07, $0a, $07, $00
line:   .byte 100, 130, 135, 150, 157, 165, 170, 175, 190, 197, 202, 210, 215, 220, 250, 10
index:  .byte $00

bg:

  ldx index
  inx
  cpx #16         
  bne !next+
  ldx #$00
!next:  lda line,x     // Next IRQ is for the change back at the bottom
  sta $d012
  stx index

  lda colors,x    // Set up to change colour to white
  // sta BORDER      // Set border and screen
  sta SCREEN

  lda #$ff        // Acknowlege IRQ 
  sta $d019

  jmp $ea7e       // restores the registers from stack and then an rti. 
  jmp $ea31       // Return to normal IRQ handler