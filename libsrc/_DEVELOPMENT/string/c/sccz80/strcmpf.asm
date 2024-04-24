; strcmp function for use with far pointers

IF !__CPU_INTEL__ && !__CPU_GBZ80__ && !__CPU_Z180__ && !__CPU_RABBIT__ && !__CPU_KC160__
    SECTION   code_clib
    SECTION   code_far
    EXTERN __far_start    ;Get the initial bindings
    EXTERN __far_end   ;Reset to initial bindings
    EXTERN __far_page    ;Page in the far segment
    EXTERN l_far_incptrs  ;Increment a far pointer (returning near address)
    PUBLIC strcmpf
    PUBLIC _strcmpf


;int strcmpf(far *s1,far *s2)
;
;         if s1==s2 : hl=0
;         if s1<<s2 : hl<0
;         if s1>>s2 : hl>0

.strcmpf
._strcmpf
    ld      ix,2
    add     ix,sp  
    ld      c,(ix+0)
    ld      b,(ix+1)
    ld      e,(ix+2)    ; E'B'C'=s2
    exx
    ld      c,(ix+4)
    ld      b,(ix+5)
    ld      e,(ix+6)    ; EBC=s1
    call    __far_start
    ex      af,af'      ; save seg 1 binding
.strcmp1
    call    __far_page
    ld      a,(hl)          ; char from s1
    ld      ixl,a
    exx
    call    __far_page
    ld      a,ixl
    cp      (hl)            ;hl = s2
    jr      nz,different
    and     a
    jr      z,equal
    call    l_far_incptrs  ;inc s2
    exx
    call    l_far_incptrs  ;inc s1
    jr      strcmp1
equal:
    ld      hl,0
return:
    ex      af,af'
    call    __far_end
    ret

different:
    sub     (hl)
    ld      h,a
    jr      return
ENDIF
