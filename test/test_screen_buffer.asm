// Transfer data from a buffer to the right hand edge of the screen

// Given a buffer of data

.var buffer_length=$19
.var buffer_width=$0a

test_screen_buffer:

// When the left hand column of the buffer is transfered to the right hand column
// of the screen
        lda #<buffer
        sta buffer_lo
        lda #>buffer
        sta buffer_hi
        jsr screen_buffer

// Then the left hand buffer contents is on the screen

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

// Then the buffer is shifted left one column

        lda #<buffer
        sta region_lo
        lda #>buffer
        sta region_hi
        lda #$0a
        sta region_x
        lda #$19
        sta region_y
        jsr region_left
        ldx #$00
!ol:    ldy #$00
!loop:  lda #<buffer
        sta $02
        lda #>buffer
        sta $03
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
        cpy #$a //  buffer_width
        bne !loop-
        lda $02
        clc
        adc buffer_width
        sta $02
        bcc !cont+
        inc $03
!cont:  inx
        cpx buffer_length
        bne !ol-
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
        .text "klmnopqrst"
        .text "lmnopqrstu"
        .text "mnopqrstuv"
        .text "nopqrstuvw"
        .text "opqrstuvwx"
        .text "pqrstuvwxy"
        .text "qrstuvwxyz"
        .text "rstuvwxyza"
        .text "stuvwxyzab"
        .text "tuvwxyzabc"
        .text "uvwxyzabcd"
        .text "vwxyzabcde"
        .text "wxyzabcdef"
        .text "xyzabcdefg"
        .text "yzabcdefgh"
        .text "zabcdefghi"

expected_screen: .text "abcdefghijklmnopqrstuvwxy"

expected_buffer: 
        .text "bcdefghij "
        .text "cdefghijk "
        .text "defghijkl "
        .text "efghijklm "
        .text "fghijklmn "
        .text "ghijklmno "
        .text "hijklmnop "
        .text "ijklmnopq "
        .text "jklmnopqr "
        .text "klmnopqrs "
        .text "lmnopqrst "
        .text "mnopqrstu "
        .text "nopqrstuv "
        .text "opqrstuvw "
        .text "pqrstuvwx "
        .text "qrstuvwxy "
        .text "rstuvwxyz "
        .text "stuvwxyza "
        .text "tuvwxyzab "
        .text "uvwxyzabc "
        .text "vwxyzabcd "
        .text "wxyzabcde "
        .text "xyzabcdef "
        .text "yzabcdefg "
        .text "zabcdefgh "
        .text "abcdefghi "
