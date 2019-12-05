test_circ:		
				lda #$04
				sta circ_radius
				lda #$05
				sta circ_x
				sta circ_y

                lda #<actual_circ_buffer
                sta plot_buffer_lo
                lda #>actual_circ_buffer
                sta plot_buffer_hi
                lda #$10
                sta plot_buffer_x
                lda #$0a
                sta plot_buffer_y

                jsr circ_plot
                lda #<expected_circ_buffer
                sta expected_plot_buffer_lo
                lda #>expected_circ_buffer
                sta expected_plot_buffer_hi

                lda #<actual_circ_buffer
                sta actual_plot_buffer_lo
                lda #>actual_circ_buffer
                sta actual_plot_buffer_hi
                lda #$10
                sta buffers_x
                lda #$09
                sta buffers_y
                jsr compare_buffers
                lda cmp_res
                bne !fail+
                lda #green
                jmp !result+
    !fail:      lda #red
    !result:    sta $d020
                rts

actual_circ_buffer:
.text "                "
.text "                "
.text "                "
.text "                "
.text "                "
.text "                "
.text "                "
.text "                "
.text "                "
.text "                "

.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff

expected_circ_buffer:	
 
.text "     :          "
.text "    : :         "
.text "  ::   ::       "
.text "  :     :       "
.text " :       :      "
.text ":        :      "
.text " :       :      "
.text "  :     :       "
.text "  ::   ::       "
.text "    :::         "
