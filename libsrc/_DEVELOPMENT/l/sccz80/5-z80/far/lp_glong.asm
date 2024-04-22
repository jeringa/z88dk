IF !__CPU_RABBIT__ && !__CPU_INTEL__ && !__CPU_GBZ80__ && !__CPU_Z180__ && !__CPU_RABBIT__ && !__CPU_KC160__

SECTION code_l_sccz80_far
PUBLIC  lp_glong

EXTERN  __far_start
EXTERN  __far_end
EXTERN  __far_page
EXTERN  l_far_incptrs

lp_glong:
    call   __far_start
    ex     af,af
    ld     bc,hl
    call    __far_page
    ; hl = physical address
    ld      a,(hl)
    ld      ixl,a
    call    l_far_incptrs
    ld      a,(hl)
    ld      ixh,a
    call    l_far_incptrs
    ld      a,(hl)
    call    l_far_incptrs
    ld      d,(hl)
    ld      e,a
    push    ix
    pop     hl
    ex      af,af
    call    __far_end
    ret

ENDIF
