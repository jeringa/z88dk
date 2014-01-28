
XLIB l_add_long_exx

l_add_long_exx:

   ; compute a += b
   ;
   ; enter : dehl'= long a
   ;         dehl = long b
   ;
   ; exit  : dehl = a + b
   ;         dehl'= long b 
   ;         exx set active on exit
   ;
   ; uses  : f, (bc, de, hl) of exx set

   push de
   push hl
   
   exx
   
   pop bc                      ; bc = b.LSW
   add hl,bc
   ex de,hl
   
   pop bc                      ; bc = b.MSW
   adc hl,bc
   ex de,hl
   
   ret
