// bird

.import source "vars.asm"

:BasicUpstart2(start)

start:	ldx #$00
!loop:	jsr screen_left
        lda #<buffer
        sta buffer_lo
        lda #>buffer
        sta buffer_hi
		jsr screen_buffer
        lda #<buffer
        sta region_lo
        lda #>buffer
        sta region_hi
        lda #$0a
        sta region_x
        lda #$19
        sta region_y
        jsr region_left
		inx
		cpx #$20
		bne !loop-
		rts

.var buffer_length=27
.var buffer_width=10

.import source "screen_left.asm"
.import source "screen_buffer.asm"
.import source "region_left.asm"

buffer: .text "abcdefghij"
        .text "bcdefghijk"
        .text "cdefghijkl"
        .text "defghijklm"
        .text "efghijklmn"
        .text "fghijklmno"
        .text "ghijklmnop"
        .text "hijklmnopq"
        .text "ijklmnopqr"
        .text "jklmnopqrs"
        .text "klmnopqrst"
        .text "lmnopqrstu"
        .text "mnopqrstuv"
        .text "nopqrstuvw"
        .text "opqrstuvwx"
        .text "pqrstuvwxy"
        .text "qrstuvwxyz"
        .text "rstuvwxyza"
        .text "stuvwxyzab"
        .text "tuvwxyzabc"
        .text "uvwxyzabcd"
        .text "vwxyzabcde"
        .text "wxyzabcdef"
        .text "xyzabcdefg"
        .text "yzabcdefgh"
        .text "zabcdefghi"
