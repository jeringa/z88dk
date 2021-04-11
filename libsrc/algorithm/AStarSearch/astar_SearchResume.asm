; struct astar_path __FASTCALL__ *astar_SearchResume(struct astar_path *p)
; resume a search previously stopped
; 01.2007 aralbrec

SECTION code_clib
PUBLIC astar_SearchResume
PUBLIC _astar_SearchResume
EXTERN astar_Search
EXTERN asm_astar_Search_resume_success, asm_astar_Search_resume_fail

; enter : hl = path to start search with
;              if 0, search not resumed from path but from queue

.astar_SearchResume
._astar_SearchResume
   push ix
   ld a,h
   or l
   jr nz,astar_SearchResume_ResumeFail
   push ix
   call asm_astar_Search_resume_success
   pop  ix
   ret 
.astar_SearchResume_ResumeFail
   call asm_astar_Search_resume_fail
   pop ix
   ret
