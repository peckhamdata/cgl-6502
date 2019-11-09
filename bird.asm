// bird

:BasicUpstart2(start)

start:

        // Screen Colour
        lda #1
        sta $d020
        sta $d021
this:   jmp this

.import source "test-left-shift.asm"