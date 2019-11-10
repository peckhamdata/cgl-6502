// test bird
        .var screen=$0400
        .var screen_right=$0427
:BasicUpstart2(start)

start:
		// jsr test_screen_left
		jsr test_screen_buffer
		rts

.import source "test_screen_left.asm"
.import source "screen_left.asm"
.import source "test_screen_buffer.asm"