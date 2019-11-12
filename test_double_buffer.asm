// Given two buffers

b1_x: .byte $0a
b1_y: .byte $03

buffer_1:   
    .text "adgjmpsvy1"
    .text "behknqtwz2"
    .text "cfilorux03"

buffer_2:
    .text "47ADGJMPSV"
    .text "58BEHKNQTW"
    .text "69CFILORUX"

test_double_buffer:

    // address of first buffer

        lda #<buffer_1
        sta buffer_active_lo
        lda #>buffer_1
        sta buffer_active_hi

    // address of second buffer

        lda #<buffer_2
        sta buffer_pending_lo
        lda #>buffer_2
        sta buffer_pending_hi

// When the first buffer is empty

    // loop to empty buffer
        lda b1_x
        sta buffer_active_fill
        sta buffer_x
        lda b1_y
        sta buffer_y
!loop:  jsr double_buffer
        lda buffer_active_fill
        bne !loop-
 
// Then it should switch to the second one
        lda buffer_active_lo
        cmp #<buffer_2
        bne !fail+

        lda buffer_active_hi
        cmp #>buffer_2
        bne !fail+
// And the first one should become the pending buffer
        lda buffer_pending_lo
        cmp #<buffer_1
        bne !fail+
        lda buffer_pending_hi
        cmp #>buffer_1
        bne !fail+
// And it should be showing as full
        lda buffer_active_fill
        cmp b1_x
        bne !fail+
        lda #green
        jmp !exit+
!fail:  lda #red
!exit:  sta $d020
        rts

    // buffer address should be second one
    // buffer should continue to empty

// And refill the first

    // refill address should be first buffer