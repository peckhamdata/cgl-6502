// Transfer data from a buffer to the right hand edge of the screen

// Given a buffer of data

.var buffer_length=10
.var buffer_width=10

test_screen_buffer:

// When the left hand column of the buffer is transfered to the right hand column
// of the screen

// Then the buffer is shifted left one column

        ldx #$00
!ol:    ldy #$00
!loop:  lda #<buffer
        sta $02
        lda #>buffer
        sta $03
        ldy #$00
        lda ($02),y
        sta tmp
        lda #<expected_buffer
        sta $02
        lda #>expected_buffer
        sta $03
        lda ($02),y
        cmp tmp
        bne !fail+
        iny
        cpy #buffer_width
        bne !loop-
        lda $02
        adc #buffer_width
        sta $02
        bcc !cont+
        inc $03
!cont:  inx
        cpx #buffer_length
        bne !ol-
!pass:  lda #green
        jmp !exit+
!fail:  lda #red
!exit:  sta $d020

// And the left hand buffer contents is on the screen

        lda #<screen_right
        sta $02
        lda #>screen_right
        sta $03
        ldx #$00
!loop:  lda expected_screen,x
        ldy #$00
        cmp ($02),y
        bne !fail+
        clc
        lda $02
        adc #$28
        sta $02
        bcc !cont+
        inc $03
!cont:  inx
        cpx #$19
        bne !loop-      
!pass:  lda #green
        jmp !exit+
!fail:  lda #red
!exit:  sta $d020
        rts

tmp: .byte 0

buffer: .text "abcdefghij"
        .text "bcdefghijk"
        .text "cdefghijkl"
        .text "defghijklm"
        .text "efghijklmn"
        .text "fghijklmno"
        .text "ghijklmnop"
        .text "hijklmnopq"
        .text "ijklmnopqr"
        .text "jklmnopqrs"

expected_screen: .text "abcdefghijklmnopqrstuvwxy"

expected_buffer: .text "bcdefghij "
                 .text "cdefghijk "
                 .text "defghijkl "
                 .text "efghijklm "
                 .text "fghijklmn "
                 .text "ghijklmno "
                 .text "hijklmnop "
                 .text "ijklmnopq "
                 .text "jklmnopqr "
                 .text "klmnopqrs "
