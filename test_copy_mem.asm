

// Given a data source:

source_data: .text  ")FcX1B2p5z:a&Iv[fglv@4A%cy0wPJ.eqR/h@cilN/qPpxG*9Xg[a}v/BCD]'/Fb"
             .text  "<,bJ/tznlfFFf64kM1VaqdDi.zuI{m[AGzOsOd4%rv<iFnIy5p3i170u]b?aU46f"
             .text  "Ye[4*DPvn3?8M9nr:%?v'Rg*.IPUut%GW/Xh2,r]%nWwbx'KswVD?gW%6M?xvZ)a"
             .text  "e2y8/J%xLb4b%BSO!9Qvdz2q^R!lX{&P*rnGZU]i/m5T10id%G9}J!Vk0)/8w'jR"
             .text  "V;gjmmIL2(3)QWcJws3K]Kqqc;CRB>LeTXp)g[dUGurNC;jE>S#xlQe&'x{2EXP6"
             .text  "*@o{#v3FFo@xBPv'O}#fFve6$.Da$O2CE3}[ioT@bWQ^NQgv<DR^Z>'w:DxHP$64"
             .text  ";n0!7oz.iJ)<DRD0!TFL)fKOx7'1o0];Ony!Met<uWXp9w9pDV^W%*b]ARK1Q&d#"
             .text  "YTcm$!S^0H)qWGosU:4Np8KOBb(shQRUf;RZdAsMW;BOuwx4>BQd%jU(p7#54SXq"
             .text  "yEW6)os</[l5J43z.{x@PTpZAd;^?*J0c0eY7W^v^5['6b?7HQ@J%RJmO:OW<ixx"
             .text  "QjfP61B,.sLz3&*A'(C6!31P$%geE:Xf[,U/ML,3w:]eXc9mYOBC(op[0@603.0/"
             .text  "Jsov><Zsjx4y&hqqWyEmhx6$[!DLGq4a93M&2O#M/v2wqogH1l'GkzxeG85QL?Bf"
             .text  "cpJjUofjJqo{2la&0hp8QS)<R,QVI>c.ljzzYwJSHPAQUwrYB8&}wB$A&u0YAM*8"
             .text  "2sa0B9kDu#OWs]@pWP1k>:p13}]$pK:mz?.>CtwVKdoe3%1/^E!DO*'QnZq>v;YL"
             .text  "fjP3>ZZUmOHND(iMyhKbnQ5zm)R%<:l6A(<3,zS}eM>O&Zpuh33SIQ9^iAul'e?v"
             .text  "&:wjNAD%u1@qH/KQ,UN3G3Omw4TT)%ld}z/l%%NXWa]{r6nBknKfG}h!pT#t9^B,"
             .text  "Y[pX#Wwb9/@&NqD0qkNjvnSv&(>F*Er#^#;%,jShc*>7#}'j9#dzyX10I]/fBSZ:"

// And an empty destination:
dest_data:  .fill $0400, 0

// When we move the data from source to dest:

test_copy_mem:  lda #<source_data
                sta copy_mem_source_lo
                lda #>source_data
                sta copy_mem_source_hi

                lda #<dest_data
                sta copy_mem_dest_lo
                lda #>dest_data
                sta copy_mem_dest_hi

                lda #$00
                sta copy_mem_dest_length_lo
                lda #$04    
                sta copy_mem_dest_length_hi

                jsr copy_mem

// Then the data at dest should match the data at source:

                lda #<source_data
                sta test_copy_mem_a_lo
                lda #>source_data
                sta test_copy_mem_a_hi

                lda #<dest_data
                sta test_copy_mem_b_lo
                lda #>dest_data
                sta test_copy_mem_b_hi

                lda #$00
                sta test_copy_mem_counter_lo
                lda #$04
                sta test_copy_mem_counter_hi
                ldy #$0
                ldx test_copy_mem_counter_hi
                beq !next+
!loop:          lda test_copy_mem_a_lo
                sta $02
                lda test_copy_mem_a_hi
                sta $03
                lda ($02),y
                pha
                lda test_copy_mem_b_lo
                sta $02
                lda test_copy_mem_b_hi
                sta $03
                pla
                cmp ($02),y
                bne !fail+
                iny
                bne !loop-
                inc test_copy_mem_a_hi
                inc test_copy_mem_b_hi
                dex
                bne !loop-
!next:          ldx test_copy_mem_counter_lo
                beq !next+
!loop:          lda (test_copy_mem_a_lo),y
                cmp (test_copy_mem_b_lo),y  
                bne !fail+
                iny
                dex
                bne !loop-
!next:          lda #green
                jmp !exit+
!fail:          lda #red                            
!exit:          sta $d020
                rts

test_copy_mem_b_lo:   .byte 0
test_copy_mem_b_hi:   .byte 0

test_copy_mem_a_lo:   .byte 0
test_copy_mem_a_hi:   .byte 0

test_copy_mem_counter_lo:   .byte 0
test_copy_mem_counter_hi:   .byte 0

// MOVEDOWN LDY #0
//          LDX SIZEH
//          BEQ MD2
// MD1      LDA (FROM),Y ; move a page at a time
//          STA (TO),Y
//          INY
//          BNE MD1
//          INC FROM+1
//          INC TO+1
//          DEX
//          BNE MD1
// MD2      LDX SIZEL
//          BEQ MD4
// MD3      LDA (FROM),Y ; move the remaining bytes
//          STA (TO),Y
//          INY
//          DEX
//          BNE MD3
// MD4      RTS

