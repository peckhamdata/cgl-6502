// http://www.6502.org/source/general/memory_move.html

copy_delay:		.byte $ff

copy_mem:       ldy #$0
                ldx copy_mem_dest_length_hi
                beq !next+
!loop:          
				txa
				pha
				ldx copy_delay
!loop_i:  	    beq !next+
				dex
				jmp !loop_i-	
!next:  	    pla
				tax
				lda copy_mem_source_lo
				sta $02
				lda copy_mem_source_hi
				sta $03
				lda ($02),y
				pha
				lda copy_mem_dest_lo
				sta $02
				lda copy_mem_dest_hi
				sta $03
				pla
				sta ($02),y
                iny
                bne !loop-
                inc copy_mem_source_hi
                inc copy_mem_dest_hi
                dex
                bne !loop-
!next:          ldx copy_mem_dest_length_lo
                beq !next+
!loop:          lda copy_mem_source_lo
				sta $02
				lda copy_mem_source_hi
				sta $03
				lda ($02),y
				pha
				lda copy_mem_dest_lo
				sta $02
				lda copy_mem_dest_hi
				sta $03
				pla
				sta ($02),y
                iny
                dex
                bne !loop-
!next:          rts

// ; Move memory down
// ;
// ; FROM = source start address
// ;   TO = destination start address
// ; SIZE = number of bytes to move
// ;
// MOVEDOWN LDY #0
//          LDX SIZEH
//          BEQ MD2
// MD1      LDA (FROM),Y ; move a page at a time
//          STA (TO),Y
//          INY
//          BNE MD1
//          INC FROM+1
//          INC TO+1
//          DEX
//          BNE MD1
// MD2      LDX SIZEL
//          BEQ MD4
// MD3      LDA (FROM),Y ; move the remaining bytes
//          STA (TO),Y
//          INY
//          DEX
//          BNE MD3
// MD4      RTS

copy_mem_dest_lo:   .byte 0
copy_mem_dest_hi:   .byte 0

copy_mem_dest_length_lo:   .byte 0
copy_mem_dest_length_hi:   .byte 0

copy_mem_source_lo:   .byte 0
copy_mem_source_hi:   .byte 0
