// Given an X and a Y co-ordinate

// When we plot them

// Then they should appear on screen

// When the plotter is in headless mode
test_plot_point:
            clc
            lda #$01
            sta plot_headless
            lda #<actual_plot_points_x
            sta plot_headless_x_lo 
            lda #>actual_plot_points_x
            sta plot_headless_x_hi 

            lda #<actual_plot_points_y
            sta plot_headless_y_lo 
            lda #>actual_plot_points_y
            sta plot_headless_y_hi 

            ldx #$00
!loop:      lda expected_plot_points_x,x
            sta p0
            lda expected_plot_points_y,x
            sta p1
            jsr plot_point
            inx
            cpx #$05
            bne !loop-

// Then we should just get the x/y co-ord back
            ldx #$00
!loop:      lda expected_plot_points_x,x
            cmp actual_plot_points_x,x
            bne !fail+
            lda expected_plot_points_y,x
            cmp actual_plot_points_y,x
            bne !fail+
            inx
            cpx #$05
            bne !loop-
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
expected_plot_points_x: .byte 0,1,2,3,4
expected_plot_points_y: .byte 4,3,2,1,0

actual_plot_points_x: .byte 0,0,0,0,0
actual_plot_points_y: .byte 0,0,0,0,0