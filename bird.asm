// bird

.import source "vars.asm"

:BasicUpstart2(start)

start:  

// .text "hello professor falken, no wait, I mean matthew broderic, well one of the matthews..."

// .text "shall we play a game?"

// .text "please list primary targets"

// .text "missile warning"

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


            lda #$28
            sta plot_buffer_x
            lda #$19
            sta plot_buffer_y 
            lda #$00
            sta plot_buffer_lo
            lda #$04
            sta plot_buffer_hi

            lda #$13
            sta nine_slice_x
            lda #$0c
            sta nine_slice_y
            lda #$01
            sta nine_slice_w
            lda #$01
            sta nine_slice_h
            ldx #$00
!loop:      
            jsr nine_slice_plot
            dec nine_slice_x
            dec nine_slice_y
            inc nine_slice_w
            inc nine_slice_w
            inc nine_slice_h
            inc nine_slice_h
            ldy #$00
wait:           lda #$ff
                cmp $d012
                bne wait
                iny
                cpy #$10
                bne wait
!continue:      inx
            cpx #$0b
            bne !loop-
test_text:
            lda #<message
            sta text_src
            lda #>message
            sta text_src+1
            jsr text_plot
            rts  

message:    .byte $11, $0b
            .text "hello\n"
            .byte $11, $0d
            .text "world\0"

// When we display that text


x0s:    .byte 01, 01, 00, 20, 08, 22    
y0s:    .byte 25, 01, 13, 00, 10, 39

x1s:    .byte 38, 38, 40, 20, 40, 25
y1s:    .byte 01, 25, 13, 25, 19, 01

.var buffer_length=27
.var buffer_width=10

.import source "screen_left.asm"
.import source "screen_buffer.asm"
.import source "region_left.asm"
.import source "double_buffer.asm"
.import source "plot_point.asm"
.import source "line.asm"
.import source "copy_mem.asm"
.import source "circ.asm"
.import source "math.asm"
.import source "curve.asm"
.import source "nine_slice.asm"
.import source "text.asm"

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

.import source "maps.asm"