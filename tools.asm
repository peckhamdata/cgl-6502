// Compare two buffers

compare_buffers:   	ldx #$00
					stx cmp_res
!loop_y:	       	ldy #$00
!loop_x:    		lda expected_plot_buffer_lo
		            sta $02
		            lda expected_plot_buffer_hi
		            sta $03
		            lda ($02),y
		            sta cmp_tmp
		            lda actual_plot_buffer_lo
		            sta $02
		            lda actual_plot_buffer_hi
		            sta $03
		            lda ($02),y
		            cmp cmp_tmp
		            bne !fail+
		            iny
		            cpy buffers_x
		            bne !loop_x-
		            clc
		            lda actual_plot_buffer_lo
		            adc buffers_x
		            sta actual_plot_buffer_lo
		            bcc !cont+
		            inc actual_plot_buffer_hi
!cont:      		clc
		            lda expected_plot_buffer_lo
		            adc buffers_x
		            sta expected_plot_buffer_lo
		            bcc !cont+
		            inc expected_plot_buffer_hi
!cont:      		inx
		            cpx buffers_y
		            bne !loop_y-
		            lda #$00
		            sta cmp_res
		            jmp !exit+
!fail:              lda #$01
      				sta cmp_res
!exit:      		rts

cmp_res: .byte 0
cmp_tmp: .byte 0

expected_plot_buffer_lo:      .byte 0
expected_plot_buffer_hi:      .byte 0

actual_plot_buffer_lo:      .byte 0
actual_plot_buffer_hi:      .byte 0

buffers_x:	.byte 0
buffers_y:	.byte 9