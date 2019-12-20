// fill block of memory with single value

// given

fill_orig_data: .text "there is text already on the screen            "
                .text "but                                            "
                .text "we want to clear it                            "

// when we clear it

test_fill_mem:
				lda #$20
				sta fill_mem_char
				lda #$8d
				sta fill_mem_size
				lda #<fill_orig_data
				sta fill_mem_from
				lda #>fill_orig_data
				sta fill_mem_from+1

				jsr fill_mem

// then it should be empty

				ldy fill_mem_size
				lda #<fill_orig_data
				sta $02
				lda #>fill_orig_data
				sta $03

!loop:			lda ($02),y
				cmp fill_mem_char
				bne !fail+
				dey
				bne !loop-
				lda #green
				jmp !result+
!fail:   	    lda #red
!result:		sta $d020
				rts