; void drawb(int tlx, int tly, int width, int height)
IF !__CPU_INTEL__
    SECTION code_graphics
    PUBLIC  drawb
    PUBLIC  _drawb
    EXTERN  asm_drawb

    
.drawb
._drawb

    pop     af
    
    pop     de
    pop     hl
    exx        ; w_plotpixel and swapgfxbk must not use the alternate registers, no problem with w_line_r
    pop     de
    pop     hl
    
    push    hl
    push    de
    exx
    push    hl
    push    de
    push    af    ; ret addr
    
    jp      asm_drawb
ENDIF
