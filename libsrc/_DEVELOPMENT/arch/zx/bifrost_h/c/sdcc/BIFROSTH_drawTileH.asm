; ----------------------------------------------------------------
; Z88DK INTERFACE LIBRARY FOR THE BIFROST* ENGINE - RELEASE 1.2/L
;
; See "bifrost_h.h" for further details
; ----------------------------------------------------------------

; void BIFROSTH_drawTileH(unsigned int lin,unsigned int col,unsigned int tile)

SECTION code_clib
SECTION code_bifrost_h

PUBLIC _BIFROSTH_drawTileH

EXTERN asm_BIFROSTH_drawTileH

_BIFROSTH_drawTileH:

        ld hl,2
        add hl,sp
        ld d,(hl)       ; D=lin
        inc hl
        inc hl
        ld e,(hl)       ; E=col
        inc hl
        inc hl
        ld a,(hl)       ; A=tile

        jp asm_BIFROSTH_drawTileH        ; execute 'draw_tile'
