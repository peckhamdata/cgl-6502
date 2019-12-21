.import source "vars.asm"

:BasicUpstart2(start)

start:

// Display the two sides - with thanks to George Phillips
// http://48k.ca/wgascii.html

lda #$00
sta $d020
sta $d021

.var target_data_len = $13

two_tribes:  	

                lda #<two_tribes_map
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
!menu_loop:		
                jsr Keyboard
                bcs !next+
                cmp #$ff
                beq !next+
                // Check A for Alphanumeric keys
                cmp #$31
                bcc !next+
                cmp #$32
                beq !do+
                bcs !next+
!do:
                sta side
!next:
                lda side
                bne !next+
		jmp !menu_loop-
!next:          
                // Display map
                clc
                sbc #$30
                sta side
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
                ldx side
                lda (cities_lo),x
                sta text_src
                lda (cities_hi),x
                sta text_src+1

                ldx #$00
!loop:          
                ldy #$00
                lda text_src
                sta $02
                lda text_src+1
                sta $03
                lda ($02),y
                sta p0
                dec p0
                iny
                lda ($02),y
                sta p1
                lda #$2e
                sta plot_char
                jsr plot_point
                dec p0
                txa
                clc
                adc #$31
                sta plot_char
                jsr plot_point
                jsr text_plot
                lda text_src
                clc
                adc #target_data_len // #$0d
                sta text_src
                bcc !next+
                inc text_src+1
!next:                
                inx
                cpx #$03
                bne !loop-

                lda #<turn_text
                sta text_src
                lda #>turn_text
                sta text_src+1

                jsr text_plot

                lda #<selected_targets_text
                sta text_src
                lda #>selected_targets_text
                sta text_src+1

                jsr text_plot

// Could factor this out into a function

                ldx #$00
!menu_loop:              
                txa
                pha
                jsr Keyboard
                bcs !next+
                cmp #$ff
                beq !next+
                // Check A for Alphanumeric keys
                cmp #$31
                bcc !next+
                cmp #$35
                beq !do+
                bcs !next+
!do:
                tay
                pla
                tax
                tya
                sec
                sbc #$31
                sta (targets),x 

                jsr set_target

                lda #<selected_targets_text
                sta text_src
                lda #>selected_targets_text
                sta text_src+1

                jsr text_plot

                inx
                jmp !cont+
!next:
                pla
                tax
!cont:          cpx #$02
                bne !menu_loop-
!next:          
                jsr launch_missiles
                rts

launch_missiles: ldx #$00
!loop:          lda target_x1,x
                sta curve_p1_x
                lda target_y1,x
                sta curve_p1_y

                lda target_x2,x
                sta curve_p2_x
                lda target_y2,x
                sta curve_p2_y

                lda target_x3,x
                sta curve_p3_x
                lda target_y3,x
                sta curve_p3_y


                // Some sort of telemetry bobbins

                // jsr telemetry

                // Dialogue 

                // jsr dialogue

                // Launch

                lda #$2b
                sta plot_char
                jsr curve_plot

                lda curve_p3_x
                sta circ_x
                lda curve_p3_y
                sta circ_y
                jsr bang
                inx
                cpx #$02
                bne !loop-
                rts
* = $4000

set_target:   
                tya
                pha
                txa
                pha
                lda (targets),x
                beq !next+
                tax
                lda #$00
!loop:          clc
                adc #target_data_len
                dex
                bne !loop-
!next:          sta tmp_offset

                ldx side
                lda (cities_lo),x
                sta $02
                lda (cities_hi),x
                sta $03
                ldy tmp_offset
                iny
                iny
                pla
                tax
!loop:          lda ($02),y
                pha
                tya
                sec
                sbc tmp_offset
                tay
                pla
                cpx #$01
                beq !slot_2+
                sta target_1+3,y // stick it in the right targets box
                jmp !cont+
!slot_2:        sta target_2+3,y
!cont:          iny
                cpy #$0b
                beq !next+
                tya
                clc
                adc tmp_offset
                tay
                jmp !loop-
!next:          tya
                clc
                adc tmp_offset
                tay
                iny
                iny
                cpx #$01
                beq !slot_2+
                lda ($02),y
                sta target_x1
                iny      
                lda ($02),y
                sta target_y1
                iny      
                lda ($02),y
                sta target_x2
                iny      
                lda ($02),y
                sta target_y2
                iny      
                lda ($02),y
                sta target_x3
                iny      
                lda ($02),y
                sta target_y3  
                jmp !exit+
!slot_2:                    
                lda ($02),y
                sta target_x1+1
                iny      
                lda ($02),y
                sta target_y1+1
                iny      
                lda ($02),y
                sta target_x2+1
                iny      
                lda ($02),y
                sta target_y2+1
                iny      
                lda ($02),y
                sta target_x3+1
                iny      
                lda ($02),y
                sta target_y3+1

!exit:          pla
                tay

                rts

tmp_offset: .byte $00

TempX: .byte $00
TempY: .byte $00

side:           .byte $00

cities_lo:      .byte <ussr_cities, <usa_cities
cities_hi:      .byte >ussr_cities, >usa_cities

// x,y, name (9 chars)

* = $4100

usa_cities:     .byte $03, $04
                .text "seattle  \0"
                .byte $1c, $00
                .byte $0f, $08
                .byte $03, $04

                .byte $07, $0b
                .text "las vegas\0"
                .byte $00, $00
                .byte $0a, $0a
                .byte $0d, $0f

                .byte $1c, $0b
                .text "wash d.c.\0"
                .byte $00, $00
                .byte $00, $00
                .byte $00, $00

ussr_cities:    .byte $03, $04
                .text "moscow   \0"
                .byte $00, $00
                .byte $00, $00
                .byte $00, $00

                .byte $07, $0b
                .text "sevastopl\0"
                .byte $00, $00
                .byte $00, $00
                .byte $00, $00

                .byte $17, $0b
                .text "minsk    \0"
                .byte $00, $00
                .byte $00, $00
                .byte $00, $00

* = $4200

targets:        .byte $00, $00

target_x1:      .byte $00, $00
target_y1:      .byte $00, $00

target_x2:      .byte $00, $00
target_y2:      .byte $00, $00

target_x3:      .byte $00, $00
target_y3:      .byte $00, $00


maps_low:       .byte <ussr_map, <usa_map
maps_hi:        .byte >ussr_map, >usa_map 

main_menu_text:	.byte $08, $14
                .text "which side do you want?\n"
                .byte $08, $16
                .text "1.   united states\n"
                .byte $08, $17
                .text "2.   soviet union\0"

turn_text:      .byte $04, $14
                .text "awaiting first strike command\n"
                .byte $00, $16
                .text "please list primary targets by number\0"

selected_targets_text:

                target_1:
                .byte $03, $18
                .text " i:---------\n"
                target_2:
                .byte $12, $18
                .text "ii:---------\0"

// city
// inbound co-ords
// seattle, las vegas, nyc, washington, texas
// moscow, minsk, kyev, st petersburg, sevastopol


telemetry:
                lda #$20
                sta fill_mem_from
                lda #$07
                sta fill_mem_from+1
                lda #$20
                sta fill_mem_char
                lda #$c8
                sta fill_mem_size
                jsr fill_mem

                lda #<tele_text
                sta text_src
                lda #>tele_text
                sta text_src+1

                jsr text_plot

                rts

tele_text:
                .byte $01, $14
                .text "trajectory heading\n"
                .byte $01, $15
                .byte $77, $77, $77, $77, $77, $77, $77, $77, $77, $77, $77, $77
                .byte $77, $77, $77, $77, $77, $77
                .text "\n"
                .byte $15, $14
                .text "trajectory heading\n"
                .byte $15, $15
                .byte $77, $77, $77, $77, $77, $77, $77, $77, $77, $77, $77, $77
                .byte $77, $77, $77, $77, $77, $77
                .text "\n"

trajectory_data:
                .byte $01, $16
                .text "a-5214-a 9226 5234\n"
                .byte $01, $17
                .text "       b 6824 5132\n"
                .byte $01, $18
                .text "       c 2196 7261\n"

                .byte $15, $16
                .text "a-5214-a 9226 5234\n"
                .byte $15, $17
                .text "       b 6824 5132\n"
                .byte $15, $18
                .text "       c 2196 7261\0"

dialogue:       

            lda #$00
            sta nine_slice_x
            lda #$00
            sta nine_slice_y

            lda #$28
            sta nine_slice_w
            lda #$05
            sta nine_slice_h

            jsr nine_slice_plot

            ldx #$0b
            lda #<dialogue_text
            sta text_src
            lda #>dialogue_text
            sta text_src+1
!loop:      jsr text_plot
            jsr delay
            lda text_src
            sec
            adc #$1d
            sta text_src
            bcc !next+
            inc text_src+1
!next:      dex
            bne !loop-            
            rts

dialogue_text:

.byte $01, $01
.text "primary targets acquired  \0"
.byte $01, $01
.text "                          \0"
.byte $01, $01
.text "lets get ready to...      \0"
.byte $01, $01
.text "                          \0"
.byte $01, $01
.text "lets get ready to...      \0"
.byte $01, $01
.text "                          \0"
.byte $01, $01
.text "lets get ready to rumsfeld\0"
.byte $01, $01
.text "                          \0"
.byte $01, $01
.text "sorry                     \0"
.byte $01, $01
.text "                          \0"
.byte $01, $01
.text "wrong decade              \0"

delay_outer:     .byte $4f
delay_inner:     .byte $ff

delay:
            txa 
            pha
            tya
            pha
            ldx #$4f
!loop_i:    ldy #$ff
!loop_ii:   nop
            dey
            bne !loop_ii-
            dex
            bne !loop_i-
            pla
            tay
            pla
            tax
            rts

bang:
                txa
                pha
                lda #$a0
                sta plot_char
                lda #$10
                sta delay_outer
                lda #$10
                sta delay_inner

                ldx #$01
!loop:          stx circ_radius
                jsr circ_plot
                jsr delay
                inx
                cpx #$0a
                bne !loop-

                lda #$20
                sta plot_char

                ldx #$01
!loop:          stx circ_radius
                jsr circ_plot
                jsr delay
                inx
                cpx #$0a
                bne !loop-
                pla
                tax
                rts

.import source "copy_mem.asm"
.import source "text.asm"
.import source "line.asm"
.import source "curve.asm"
.import source "plot_point.asm"
.import source "math.asm"
.import source "maps.asm"
.import source "keys.asm"
.import source "circ.asm"
.import source "fill.asm"
.import source "nine_slice.asm"