
radius:		.byte $00
f:			.byte $00
ddf_y:		.byte $00
ddf_x:		.byte $00
anum1:		.byte $00
anum2:		.byte $00
xx:			.byte $00
yy:			.byte $00
cx:			.byte 30
cy:			.byte 13

expl:
		ldx #$00
!loop:	stx radius
		lda #$00
		sta xx
		sta yy
		sta ddf_y
		sta ddf_x
		sta f
		jsr circ
		inx
		cpx #$5
		bne !loop-
		rts

circ:
txa
pha
lda radius
sta anum1
sta yy
lda #$00
sta xx
sta ddf_x

sec
lda #$01
sbc radius
sta f

lda #$fe
sta anum2
jsr mult8
sta ddf_y

lda cx
sta p0
lda cy
adc radius
sta p1
jsr plot_point
lda cy
sbc radius
sta p1
jsr plot_point

lda cy
sta p1
lda cx
sbc radius
sta p0
jsr plot_point

lda cy
sta p1
lda cx
adc radius
sta p0
jsr plot_point

!loop:	lda xx
		cmp yy
		bcc !next+
		jmp !done+
!next:	lda f
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
!next:	inc xx
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
		lda cx
		clc
		adc xx
		sta p0
		lda cy
		clc
		adc yy
		sta p1
		jsr plot_point
//    Plot(cx - x, cy + y, Color)

		lda cx
		sec
		sbc xx
		sta p0
		lda cy
		clc
		adc yy
		sta p1
		jsr plot_point

//    Plot(cx + x, cy - y, Color)

		lda cx
		clc
		adc xx
		sta p0
		lda cy
		sec
		sbc yy
		sta p1
		jsr plot_point

//    Plot(cx - x, cy - y, Color)

		lda cx
		sec
		sbc xx
		sta p0
		lda cy
		sec
		sbc yy
		sta p1
		jsr plot_point

//    Plot(cx + y, cy + x, Color)

		lda cx
		clc
		adc yy
		sta p0
		lda cy
		clc
		adc xx
		sta p1
		jsr plot_point

    // Plot(cx - y, cy + x, Color)

		lda cx
		sec
		sbc yy
		sta p0
		lda cy
		clc
		adc xx
		sta p1
		jsr plot_point

    // Plot(cx + y, cy - x, Color)

		lda cx
		clc
		adc yy
		sta p0
		lda cy
		sec
		sbc xx
		sta p1
		jsr plot_point

    // Plot(cx - y, cy - x, Color)

		lda cx
		sec
		sbc yy
		sta p0
		lda cy
		sec
		sbc xx
		sta p1
		jsr plot_point

		jmp !loop-
!done: 
pla
tax
rts

// ; General 8bit * 8bit = 8bit multiply
// ; by White Flame 20030207

// ; Multiplies "num1" by "num2" and returns result in .A
// ; Instead of using a bit counter, this routine early-exits when num2 reaches zero, thus saving iterations.


// ; Input variables:
// ;   num1 (multiplicand)
// ;   num2 (multiplier), should be small for speed
// ;   Signedness should not matter

// ; .X and .Y are preserved
// ; num1 and num2 get clobbered

mult8:

 lda #$00
 beq !enterLoop+

!doAdd:
 clc
 adc anum1

!loop:
 asl anum1
!enterLoop: // ;For an accumulating multiply (.A = .A + num1*num2), set up num1 and num2, then enter here
 lsr anum2
 bcs !doAdd-
 bne !loop-

end:	rts

// ; 15 bytes
