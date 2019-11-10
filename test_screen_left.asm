
        // Screen Colour
        .var white=1
        .var green=5
        .var red=2
        lda #white
        sta $d020
        sta $d021

        // given a screen of lines that look like original

        ldx #$00
        lda #$00
        sta $02
        lda #$04
        sta $03
col:    ldy #$00
line:   lda original,y
        sta ($02),y
        iny
        cpy #$28
        bne line
        lda $02
        adc #$27
        sta $02
        bcc cont
        inc $03
cont:   inx
        cpx #$19
        bne col

        // when we move the screen left
        jsr screen_left
        //  then we expect each row to look like expected
        lda #$00
        sta $02
        lda #$04
        sta $03
        ldx #$00
com1:   ldy #$00
comp:   lda ($02),y
        cmp expected,y
        bne fail
        iny
        cpy #$28
        bne comp
        lda $02
        adc #$27
        sta $02
        bcc cont2
        inc $03
cont2:  inx
        cpx #$19
        bne com1
        // border goes red if it fails, green if it passes
pass:   lda #green
        jmp report
fail:   lda #red
report: sta $d020
        rts
        // *=$4000 "Data"
original: .text "thequickbrownfoxjumpedoverthelazydog1234"
expected: .text "hequickbrownfoxjumpedoverthelazydog1234 "
