nine_slice_x: .byte $00
nine_slice_y: .byte $00
nine_slice_w: .byte $00
nine_slice_h: .byte $00

offset:		  .byte $00, $00

// nine_slice_chars: .byte $a0, $a0, $a0
// 				  .byte $a0, $a0, $a0
// 				  .byte $a0, $a0, $a0

// nine_slice_chars: .byte $46, $46, $46
// 				  .byte $42, $7e, $d4
// 				  .byte $42, $7e, $d4

nine_slice_chars: .byte $4f, $77, $50
				  .byte $74, $20, $67
				  .byte $4c, $6f, $7a

nine_slice_h_tmp: .byte $00
nine_slice_w_tmp: .byte $00

nine_slice_color: .byte $06

nine_slice_plot:	txa
					pha

					// Go to offset
					lda nine_slice_y
					sta num1
					lda plot_buffer_x
					sta num2
					jsr multiply
					clc
					adc nine_slice_x
					bcc !next+
					iny
!next:				sta offset
					sty offset+1
					clc
					lda plot_buffer_lo
					adc offset
					sta $02
					bcc !next+
					inc offset+1
!next:				lda plot_buffer_hi
					adc offset+1
					sta $03

					lda nine_slice_w
					sta nine_slice_w_tmp
					dec nine_slice_w_tmp
					lda nine_slice_h
					sta nine_slice_h_tmp
					dec nine_slice_h_tmp
					ldx #$00
					ldy #$00
!outer_loop:
					tya
					pha
					// If the shape is only one wide we use the middle x chars
					lda nine_slice_w
					cmp #$01
					bne !next+
					inx
!next:				// If the shape is only one hight we use the middle y chars
					lda nine_slice_h
					cmp #$01
					bne !next+
					inx
					inx
					inx
!next:
					ldy #$00
!loop:				lda nine_slice_chars,x
					sta ($02),y
					// Do color - need to make this optional for the PET
					// lda $03
					// pha
				 //    clc	
					// adc plot_color_difference
					// sta $03
					// lda nine_slice_color
					// sta ($02),y
					// pla
					// sta $03
					iny
					cpy #$01
					bne !next+
					inx
!next:				cpy nine_slice_w_tmp
					bne !next+
					inx
!next:				cpy nine_slice_w
					bne !loop-

					pla
					tay
					iny
					cpy #$01
					beq !else+
					cpy nine_slice_h_tmp
					beq !else+
					dex
					dex
					jmp !next+
!else:				inx	
					lda nine_slice_h
					cmp #$02
					bne !next+
					inx
					inx
					inx				
!next:					
					cpy nine_slice_h
					beq !exit+
					lda $02
					clc
					adc #$28
					sta $02
					bcc !next+
					inc $03
!next:				
					jmp !outer_loop-
!exit:
					pla
					tax
					rts

