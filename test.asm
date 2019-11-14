// test bird
:BasicUpstart2(start)

start:
        // jsr test_screen_left
        // jsr test_screen_buffer
        // jsr test_double_buffer
        // jsr test_plot_point
        // jsr test_init_line
        jsr test_plot_line
        rts

.import source "vars.asm"
.import source "tools.asm"
.import source "test_screen_left.asm"
.import source "screen_left.asm"
.import source "test_screen_buffer.asm"
.import source "screen_buffer.asm"
.import source "region_left.asm"
.import source "test_double_buffer.asm"
.import source "double_buffer.asm"
.import source "test_plot_point.asm"
.import source "plot_point.asm"
.import source "line.asm"
.import source "test_line.asm"
