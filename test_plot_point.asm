// Given an X and a Y co-ordinate

// When we plot them

// Then they should appear on screen

// When the plotter is in headless mode
test_plot_point:
            clc
            lda #<actual_plot_buffer
            sta plot_buffer_lo
            lda #>actual_plot_buffer
            sta plot_buffer_hi
            lda #$05
            sta plot_buffer_x
            sta plot_buffer_y            
            ldx #$00
!loop:      lda plot_points_x,x
            sta p0
            lda plot_points_y,x
            sta p1
            jsr plot_point
            inx
            cpx #$05
            bne !loop-

// Then we should just get the x/y co-ord back
            
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
            rts

// Given X that is out of bounds

// When we plot

// Then ???

// Given Y that is out of bounds

// When we plot

// Then ???
plot_points_x: .byte 0,1,2,3,4
plot_points_y: .byte 4,3,2,1,0

expected_plot_buffer:  .text "    :"
                       .text "   : "
                       .text "  :  "
                       .text " :   "
                       .text ":    "

actual_plot_buffer:    .text "     "
                       .text "     "
                       .text "     "
                       .text "     "
                       .text "     "
