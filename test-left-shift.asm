
        // Screen Colour
        .var white=1
        lda #white
        sta $d020
        sta $d021
this:   jmp this

		// given a row of the screen looks like this:

		orginal: .text "thequickbrownfoxjumpedoverthelazydogTHEQUICKBROWNFOXJUMPEDOVERTHELAZYDOG12345678"

		// when we move it left

		//  then we expect it to look like this:

		expected: .text "hequickbrownfoxjumpedoverthelazydogTHEQUICKBROWNFOXJUMPEDOVERTHELAZYDOG12345678 "

		// border goes red if it fails, green if it passes