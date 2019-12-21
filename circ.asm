circ_radius:    .byte $0a
f:              .byte $00
ddf_y:          .byte $00
ddf_x:          .byte $00
xx:             .byte $00
yy:             .byte $00
circ_x:         .byte $00
circ_y:         .byte $00

circ_plot:      txa
                pha
                lda circ_radius
                sta num1
                sta yy
                lda #$00
                sta xx
                sta ddf_x

                sec
                lda #$01
                sbc circ_radius
                sta f

                lda #$fe
                sta num2
                jsr mult8
                sta ddf_y

                lda circ_x
                sta p0
                lda circ_y
                adc circ_radius
                sta p1
                jsr plot_point
                lda circ_y
                sbc circ_radius
                sta p1
                jsr plot_point

                lda circ_y
                sta p1
                lda circ_x
                sbc circ_radius
                sta p0
                jsr plot_point

                lda circ_y
                sta p1
                lda circ_x
                adc circ_radius
                sta p0
                jsr plot_point

        !loop:  lda xx
                cmp yy
                bcc !next+
                jmp !done+
        !next:  lda f
                bmi !next+
                lda yy
                sec
                sbc #$01
                sta yy
                lda ddf_y
                clc
                adc #$02
                sta ddf_y
                lda f
                adc ddf_y
                sta f
        !next:  inc xx
                lda ddf_x
                clc
                adc #$02
                sta ddf_x
                lda f
                clc
                adc ddf_x
                adc #$01
                sta f       

        //    Plot(cx + x, cy + y, Color)
                lda circ_x
                clc
                adc xx
                sta p0
                lda circ_y
                clc
                adc yy
                sta p1
                jsr plot_point
        //    Plot(cx - x, cy + y, Color)

                lda circ_x
                sec
                sbc xx
                sta p0
                lda circ_y
                clc
                adc yy
                sta p1
                jsr plot_point

        //    Plot(cx + x, cy - y, Color)

                lda circ_x
                clc
                adc xx
                sta p0
                lda circ_y
                sec
                sbc yy
                sta p1
                jsr plot_point

        //    Plot(cx - x, cy - y, Color)

                lda circ_x
                sec
                sbc xx
                sta p0
                lda circ_y
                sec
                sbc yy
                sta p1
                jsr plot_point

        //    Plot(cx + y, cy + x, Color)

                lda circ_x
                clc
                adc yy
                sta p0
                lda circ_y
                clc
                adc xx
                sta p1
                jsr plot_point

            // Plot(cx - y, cy + x, Color)

                lda circ_x
                sec
                sbc yy
                sta p0
                lda circ_y
                clc
                adc xx
                sta p1
                jsr plot_point

            // Plot(cx + y, cy - x, Color)

                lda circ_x
                clc
                adc yy
                sta p0
                lda circ_y
                sec
                sbc xx
                sta p1
                jsr plot_point

            // Plot(cx - y, cy - x, Color)

                lda circ_x
                sec
                sbc yy
                sta p0
                lda circ_y
                sec
                sbc xx
                sta p1
                jsr plot_point

                jmp !loop-
                !done: 
                pla
                tax
                rts
