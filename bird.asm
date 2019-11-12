// bird

.import source "vars.asm"

:BasicUpstart2(start)

start:	ldx #$00
        lda #<buffer
        sta buffer_active_lo
        lda #>buffer
        sta buffer_active_hi
        sta buffer_hi
        lda #<buff_2
        sta buffer_pending_lo
        lda #>buff_2
        sta buffer_pending_hi
        lda #$0a
        sta buffer_x
		sta buffer_active_fill
        lda #$19
        sta buffer_y
!loop:	
        lda buffer_active_lo
        sta buffer_lo
        lda buffer_active_hi
        sta buffer_hi
		jsr screen_left
		jsr screen_buffer
        jsr double_buffer
		inx
		cpx #$20
		bne !loop-
		rts

.var buffer_length=27
.var buffer_width=10

.import source "screen_left.asm"
.import source "screen_buffer.asm"
.import source "region_left.asm"
.import source "double_buffer.asm"

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

buff_2: .text "abcdefghij"
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
