// Given an X and a Y co-ordinate

// When we plot them

// Then they should appear on screen

test_plot_point:
            clc
            lda #<actual_plot_buffer
            sta plot_buffer_lo
            lda #>actual_plot_buffer
            sta plot_buffer_hi
            lda #$05
            sta plot_buffer_x
            lda #$05
            sta plot_buffer_y            
            lda #$01
            sta plot_color_difference
            ldx #$00
!loop:      lda plot_points_x,x
            sta p0
            lda plot_points_y,x
            sta p1
            stx plot_color
            jsr plot_point
            inx
            cpx #$05
            bne !loop-
            
            lda #<expected_plot_buffer
            sta expected_plot_buffer_lo
            lda #>expected_plot_buffer
            sta expected_plot_buffer_hi

            lda #<actual_plot_buffer
            sta actual_plot_buffer_lo
            lda #>actual_plot_buffer
            sta actual_plot_buffer_hi

            lda #$05
            sta buffers_x
            sta buffers_y
            jsr compare_buffers
            lda cmp_res
            bne !fail+
            lda #green
            jmp !result+
!fail:      lda #red
!result:    sta $d020

            lda #<expected_color_buffer
            sta expected_plot_buffer_lo
            lda #>expected_color_buffer
            sta expected_plot_buffer_hi

            lda #<actual_color_buffer
            sta actual_plot_buffer_lo
            lda #>actual_color_buffer
            sta actual_plot_buffer_hi

            jsr compare_buffers
            lda cmp_res
            bne !fail+
            lda #green
            jmp !result+
!fail:      lda #red
!result:    sta $d020

            rts

// Given X that is out of bounds

// When we plot

// Then ???

// Given Y that is out of bounds

// When we plot

// Then ???

// Test colour


plot_points_x: .byte 0,1,2,3,4
plot_points_y: .byte 4,3,2,1,0

expected_plot_buffer:  .text "    :"
                       .text "   : "
                       .text "  :  "
                       .text " :   "
                       .text ":    "

expected_color_buffer: .byte $00, $00, $00, $00, $04
                       .byte $00, $00, $00, $03, $00
                       .byte $00, $00, $02, $00, $00
                       .byte $00, $01, $00, $00, $00
                       .byte $00, $00, $00, $00, $00 

* = $4100
actual_plot_buffer:    .text "     "
                       .text "     "
                       .text "     "
                       .text "     "
                       .text "     "
* = $4200
actual_color_buffer:   .byte $00, $00, $00, $00, $00
                       .byte $00, $00, $00, $00, $00
                       .byte $00, $00, $00, $00, $00
                       .byte $00, $00, $00, $00, $00
                       .byte $00, $00, $00, $00, $00 