// test bird
:BasicUpstart2(start)

start:
		// jsr test_screen_left
		jsr test_screen_buffer
		rts

.import source "vars.asm"
.import source "test_screen_left.asm"
.import source "screen_left.asm"
.import source "test_screen_buffer.asm"
.import source "screen_buffer.asm"