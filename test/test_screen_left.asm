
test_screen_left:

        // given a screen of lines that look like original

        ldx #$00
        lda #<screen
        sta $02
        lda #>screen
        sta $03
!col:   ldy #$00
!line:  lda original,y
        sta ($02),y
        iny
        cpy #$28
        bne !line-
        lda $02
        adc #$27
        sta $02
        bcc !cont+
        inc $03
!cont:  inx
        cpx #$19
        bne !col-

        // when we move the screen left
        jsr screen_left
        //  then we expect each row to look like expected
        lda #<screen
        sta $02
        lda #>screen
        sta $03
        ldx #$00
!col:   ldy #$00
!line:  lda ($02),y
        cmp expected,y
        bne fail
        iny
        cpy #$28
        bne !line-
        lda $02
        adc #$27
        sta $02
        bcc !cont+
        inc $03
!cont:  inx
        cpx #$19
        bne !col-
        // border goes red if it fails, green if it passes
pass:   lda #green
        jmp report
fail:   lda #red
report: sta $d020
        rts
original: .text "thequickbrownfoxjumpsoverthelazydog12345"
expected: .text "hequickbrownfoxjumpsoverthelazydog12345 "
