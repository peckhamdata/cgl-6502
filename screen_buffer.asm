buffer_lo: .byte 0
buffer_hi: .byte 0
screen_lo: .byte 0
screen_hi: .byte 0
char:      .byte 0
screen_buffer:  

        txa
        pha
        ldx #$00
        ldy #$00
        lda #<screen_right
        sta screen_lo
        lda #>screen_right
        sta screen_hi
!loop:        
        lda buffer_lo
        sta $02
        lda buffer_hi
        sta $03
        lda ($02),y
        sta char
        clc
        lda $02
        adc #buffer_width
        sta $02
        bcc !cont+
        inc $03
!cont:  sta buffer_lo
        lda $03
        sta buffer_hi
        lda screen_lo
        sta $02
        lda screen_hi
        sta $03
        lda char
        sta ($02),y
        clc
        lda $02
        adc #$28
        sta screen_lo
        bcc !cont+
        inc screen_hi
!cont:  inx
        cpx #$19
        bne !loop-
        pla
        tax      
        rts
