// test bird
:BasicUpstart2(start)

start:
        // jsr test_screen_left
        // jsr test_screen_buffer
        // jsr test_double_buffer
        // jsr test_plot_point
        // jsr test_init_line
        // jsr test_plot_line
        // jsr test_copy_mem
        // jsr test_curve
        // jsr test_circ
        // jsr test_text

//         ldx #$00
//         lda #$05
// !loop:  sta $D800,x
//         sta $D900,x
//         sta $Da00,x
//         inx
//         bne !loop-        
// lda #$0e
// sta $d020
// sta $d021

// jsr test_raster

//        jsr test_filled_curve
        // jsr test_nine_slice
        // jsr test_figure
        jsr test_fill_mem
        rts

.import source "vars.asm"
.import source "tools.asm"
.import source "test/test_screen_left.asm"
.import source "screen_left.asm"
.import source "test/test_screen_buffer.asm"
.import source "screen_buffer.asm"
.import source "region_left.asm"
.import source "test/test_double_buffer.asm"
.import source "double_buffer.asm"
.import source "test/test_plot_point.asm"
.import source "plot_point.asm"
.import source "line.asm"
.import source "test/test_line.asm"
.import source "copy_mem.asm"
.import source "test/test_copy_mem.asm"
.import source "curve.asm"
.import source "test/test_curve.asm"
.import source "test/test_filled_curve.asm"
.import source "math.asm"
.import source "test/test_circ.asm"
.import source "circ.asm"
.import source "test/test_text.asm"
.import source "text.asm"
.import source "test/test_figure.asm"
.import source "figure.asm"
.import source "test/test_nine_slice.asm"
.import source "nine_slice.asm"
.import source "test/test_raster.asm"
.import source "fill.asm"
.import source "test/test_fill.asm"