
SECTION code_l_clang


PUBLIC __lshl


; iybc << a
__lshl:
   push af
   push iy
   ex (sp),hl
   call impl
   ex (sp),hl
   pop iy
   pop af
   ret

impl:
   or a
   ret z

   cp 32
   ret nc
shift_loop:
   sla c
   rl  b
   rl  l
   rl  h
   dec a
   jr  nz,shift_loop
   ret
