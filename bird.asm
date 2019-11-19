// bird

.import source "vars.asm"

:BasicUpstart2(start)

start:	
				lda #<usa_map+2
                sta copy_mem_source_lo
                lda #>usa_map+2
                sta copy_mem_source_hi

                lda #$00
                sta copy_mem_dest_lo
                lda #$04
                sta copy_mem_dest_hi

                lda #$00
                sta copy_mem_dest_length_lo
                lda #$04    
                sta copy_mem_dest_length_hi

                jsr copy_mem
		

		ldx #$00
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
// !loop:	
//         lda buffer_active_lo
//         sta buffer_lo
//         lda buffer_active_hi
//         sta buffer_hi
// 		jsr screen_left
// 		jsr screen_buffer
//         jsr double_buffer
// 		inx
// 		cpx #$40
// 		bne !loop-
// 		ldx #$00
// !loop:	lda (x0s),x
// 		sta x0		
// 		lda (x1s),x
// 		sta x1		
// 		lda (y0s),x
// 		sta y0		
// 		lda (y1s),x
// 		sta y1
// 		jsr init_line		
// 		// jsr plot_line
// 		inx
// 		cpx #$06	
// 		bne !loop-
		jsr bang
		// jsr expl
		rts

x0s:	.byte 01, 01, 00, 20, 08, 22	
y0s:	.byte 25, 01, 13, 00, 10, 39

x1s:	.byte 38, 38, 40, 20, 40, 25
y1s:	.byte 01, 25, 13, 25, 19, 01

.var buffer_length=27
.var buffer_width=10

.import source "screen_left.asm"
.import source "screen_buffer.asm"
.import source "region_left.asm"
.import source "double_buffer.asm"
.import source "plot_point.asm"
.import source "line.asm"
.import source "copy_mem.asm"
.import source "tmp.asm"
.import source "circ.asm"

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

buff_2: .text "hellotoyou"
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

.import source "usa_map.asm"