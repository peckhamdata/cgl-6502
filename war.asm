.import source "vars.asm"

:BasicUpstart2(start)

start:

// Display the two sides - with thanks to George Phillips
// http://48k.ca/wgascii.html

lda #$00
sta $d020
sta $d021



two_tribes:  	lda #<two_tribes_map
                sta copy_mem_source_lo
                lda #>two_tribes_map
                sta copy_mem_source_hi

                lda #<screen
                sta copy_mem_dest_lo
                lda #>screen
                sta copy_mem_dest_hi

                lda #$00
                sta copy_mem_dest_length_lo
                lda #$04    
                sta copy_mem_dest_length_hi

                jsr copy_mem

                lda #<main_menu_text
                sta text_src
                lda #>main_menu_text
                sta text_src+1

                jsr text_plot
menu_loop:		
                jsr Keyboard
                bcs NoValidInput
                // stx TempX
                // sty TempY
                cmp #$ff
                beq NoNewAphanumericKey
                // Check A for Alphanumeric keys
                cmp #$31
                bcc !next+
                cmp #$32
                beq !do+
                bcs !next+
!do:
                sta side

!next:
                NoNewAphanumericKey:
                // // Check X & Y for Non-Alphanumeric Keys
                // ldx TempX
                // ldy TempY
                // stx $0401
                // sty $0402
                NoValidInput:  // This may be substituted for an errorhandler if needed.
                lda side
                bne !next+
		jmp menu_loop
!next:          
                // Display map
                clc
                sbc #$30
                tax
                lda (maps_low),x                
                sta copy_mem_source_lo
                lda (maps_hi),x
                sta copy_mem_source_hi
                lda #<screen
                sta copy_mem_dest_lo
                lda #>screen
                sta copy_mem_dest_hi

                jsr copy_mem
                rts

TempX: .byte $00
TempY: .byte $00

side:           .byte $00

maps_low:       .byte <usa_map, <ussr_map
maps_hi:        .byte >usa_map, >ussr_map

main_menu_text:	.byte $08, $14
	            .text "which side do you want?\n"
	            .byte $08, $16
	            .text "1.   united states\n"
	            .byte $08, $17
	            .text "2.   ussr\0"

.import source "copy_mem.asm"
.import source "text.asm"
.import source "plot_point.asm"
.import source "math.asm"
.import source "maps.asm"
.import source "keys.asm"