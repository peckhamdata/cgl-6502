buffer_active_lo:   .byte 0
buffer_active_hi:   .byte 0
buffer_pending_lo:  .byte 0
buffer_pending_hi:  .byte 0
buffer_x:           .byte 0
buffer_y:           .byte 0

buffer_active_fill: .byte 0

double_buffer:  
        lda buffer_active_lo
        sta region_lo
        lda buffer_active_hi
        sta region_hi
        lda buffer_x
        sta region_x
        lda buffer_y
        sta region_y
        
        jsr region_left
        dec buffer_active_fill
        bne !exit+
        lda buffer_active_lo
        pha
        lda buffer_active_hi
        pha
        lda buffer_pending_lo
        sta buffer_active_lo
        lda buffer_pending_hi
        sta buffer_active_hi
        pla
        sta buffer_pending_hi
        pla
        sta buffer_pending_lo
        lda buffer_x
        sta buffer_active_fill
!exit:  rts