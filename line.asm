* = $4000
steep:      .byte $00

x0:         .byte $01
y0:         .byte $02
x1:         .byte $0a
y1:         .byte $0e

delta_x:    .byte $00
delta_y:    .byte $00
error:      .byte $00
y:          .byte $00
y_step:     .byte $00

xtmp:       .byte $00

* = $400B
init_line:   clc
             lda x1
             sec
             sbc x0
             bpl !next+
             eor #$ff
             clc
             adc #$01
!next:       sta xtmp
             lda y1
             sec
             sbc y0
             bpl !next+
             eor #$ff
             clc
             adc #$01
!next:       cmp xtmp
             beq !swap+
             bcs !swap+
             jmp !next+          
!swap:       lda #$01
             sta steep
             lda y0
             pha
             lda x0
             sta y0
             pla
             sta x0

             lda y1
             pha
             lda x1
             sta y1
             pla
             sta x1
!next:       lda x0
             cmp x1
             beq !cont+
             bcs !cont+
             jmp !next+
!cont:       lda x0
             pha
             lda x1
             sta x0
             pla
             sta x1

             lda y0
             pha
             lda y1
             sta y0
             pla
             sta y1
!next:      sec    
            lda x1
            sbc x0
            sta delta_x
            sec
            lda y1
            sbc y0
            bpl !next+
            eor #$ff
            clc
            adc #$01
!next:      sta delta_y
            lda delta_x
            lsr
            sta error
            lda y0
            sta y
            cmp y1
            bcc !else+
            lda #$ff
            sta y_step
            jmp !next+
!else:      lda #$01
            sta y_step      
!next:      rts
plot_line:  clc
!next:      ldx x0
!loop:      
            lda steep
            cmp #$01
            bne !next+
            lda y            // Plot y,x
            sta p0
            stx p1
            jsr plot_point
            jmp !done+
!next:      stx p0           // Plot x,y
            lda y
            sta p1
            jsr plot_point
!done:      sec
            lda error
            sbc delta_y
            sta error
            bcs !lt+
            jmp !next+
!lt:        lda y
            clc
            adc y_step
            sta y
            lda error
            clc
            adc delta_x
            sta error
!next:      inx
            cpx x1
            bne !loop-
            rts

