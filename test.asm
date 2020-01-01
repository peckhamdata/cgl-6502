.import source "vars.asm"

.var screen=dummy_screen
.var screen_right=dummy_screen+$27

.macro run_test(test) {
        txa
        pha
        jsr test
        pla
        tax
        lda $d020
        cmp #red
        bne !cont+
        rts
!cont:  lda #$2e
        sta $0400,x
        inx
}

:BasicUpstart2(start)

dummy_screen: .fill $0400, 0

start:
        ldx #$00
        run_test(test_screen_left)
        run_test(test_screen_buffer)
        run_test(test_double_buffer)
        run_test(test_plot_point)
        run_test(test_init_line)
        run_test(test_plot_line)
        run_test(test_copy_mem)
        run_test(test_curve)
        run_test(test_circ)
        run_test(test_text)
        run_test(test_filled_curve)
        run_test(test_fill_mem)
        run_test(test_nine_slice)
        rts

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
.import source "test/test_nine_slice.asm"
.import source "nine_slice.asm"
.import source "fill.asm"
.import source "test/test_fill.asm"