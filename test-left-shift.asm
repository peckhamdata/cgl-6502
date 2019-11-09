
        // Screen Colour
        .var white=1
        .var green=5
        .var red=2
        .var screen=$0400
        lda #white
        sta $d020
        sta $d021

		// given a row of the screen looks like original

		ldy #$00
loop:	lda original,y
		sta screen,y
		iny
		cpy #$28
		bne loop

		// when we move it left

		//  then we expect it to look like expected

		ldy #$00
comp:	lda screen,y
		cmp expected,y
		bne fail
		iny
		cpy #$28
		bne comp
		// border goes red if it fails, green if it passes
pass:	lda #green
		jmp report
fail:	lda #red
report:	sta $d020
		rts
		// *=$4000 "Data"
original: .text "thequickbrownfoxjumpedoverthelazydogTHEQUICKBROWNFOXJUMPEDOVERTHELAZYDOG12345678"
 
expected: .text "hequickbrownfoxjumpedoverthelazydogTHEQUICKBROWNFOXJUMPEDOVERTHELAZYDOG12345678 "
