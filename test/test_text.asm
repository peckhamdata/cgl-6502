// Given an x/y position and some text

message:    .byte $0f, $03
            .text "hello world\n"
            .byte $0a
            .byte $01, $00
            .text "how are you?\0"

// When we display that text

test_text:
            lda #<message
            sta text_src
            lda #>message
            sta text_src+1

// Then it should appear at the given x/y position on screen

            lda #<actual_text_buffer
            sta plot_buffer_lo
            lda #>actual_text_buffer
            sta plot_buffer_hi
            lda #$28
            sta plot_buffer_x
            lda #$05
            sta plot_buffer_y

            jsr text_plot
            lda #<expected_text_buffer
            sta expected_plot_buffer_lo
            lda #>expected_text_buffer
            sta expected_plot_buffer_hi

            lda #<actual_text_buffer
            sta actual_plot_buffer_lo
            lda #>actual_text_buffer
            sta actual_plot_buffer_hi
            lda #$27    
            sta buffers_x
            lda #$05
            sta buffers_y
            jsr compare_buffers
            lda cmp_res
            bne !fail+
            lda #green
            jmp !result+
!fail:      lda #red
!result:    sta $d020
            rts

expected_text_buffer:
       
.text " how are you?                           "
.text "                                        "
.text "                                        "
.text "               hello world              "
.text "                                        "
.byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

actual_text_buffer:

.text "                                        "
.text "                                        "
.text "                                        "
.text "                                        "
.text "                                        "
