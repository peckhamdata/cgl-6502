// test bird
:BasicUpstart2(start)

start:
        jsr test_screen_left
        jsr test_screen_buffer
        jsr test_double_buffer
        rts

.import source "vars.asm"
.import source "test_screen_left.asm"
.import source "screen_left.asm"
.import source "test_screen_buffer.asm"
.import source "screen_buffer.asm"
.import source "region_left.asm"
.import source "test_double_buffer.asm"
.import source "double_buffer.asm"
