;;
;; Arkos 2 Player automatically generated for zx target in smc mode.
;; Do not modify this file directly.  Go instead to support/arkos directory
;; and regenerate the Player with the proper Makefile recipes!  - ZXjogv
;; (zx@jogv.es)
;;

    section smc_sound_ay

    defc    asm_smc_PLY_AKG_INIT=PLY_AKG_INIT
    defc    asm_smc_PLY_AKG_STOP=PLY_AKG_STOP
    defc    asm_smc_PLY_AKG_PLAY=PLY_AKG_PLAY
    defc    asm_smc_PLY_AKG_INITSOUNDEFFECTS=PLY_AKG_INITSOUNDEFFECTS
    defc    asm_smc_PLY_AKG_PLAYSOUNDEFFECT=PLY_AKG_PLAYSOUNDEFFECT

    public  asm_smc_PLY_AKG_INIT
    public  asm_smc_PLY_AKG_STOP
    public  asm_smc_PLY_AKG_PLAY
    public  asm_smc_PLY_AKG_INITSOUNDEFFECTS
    public  asm_smc_PLY_AKG_PLAYSOUNDEFFECT

    defc    PLY_AKG_FULL_INIT_CODE=ASMPC+1
    defc    PLY_AKG_OFFSET1B=ASMPC+1
    defc    PLY_AKG_USE_HOOKS=ASMPC+1
    defc    PLY_AKG_STOP_SOUNDS=ASMPC+1
    defc    PLY_AKG_BITFORSOUND=ASMPC+2
    defc    PLY_AKG_OFFSET2B=ASMPC+2
    defc    PLY_AKG_SOUNDEFFECTDATA_OFFSETINVERTEDVOLUME=ASMPC+2

PLY_AKG_START:
PLY_AKG_OPCODE_ADD_HL_BC_MSB:
    jp      PLY_AKG_INIT
    defc    PLY_AKG_SOUNDEFFECTDATA_OFFSETSPEED=ASMPC+1
    defc    PLY_AKG_BITFORNOISE=ASMPC+2
PLY_AKG_SOUNDEFFECTDATA_OFFSETCURRENTSTEP:
    jp      PLY_AKG_PLAY
    defc    PLY_AKG_CHANNEL_SOUNDEFFECTDATASIZE=ASMPC+2
    jp      PLY_AKG_INITTABLEORA_END

PLY_AKG_INITSOUNDEFFECTS:
PLY_AKG_OPCODE_ADD_HL_BC_LSB:
    ld      (PLY_AKG_PTSOUNDEFFECTTABLE+1), hl
    ret
PLY_AKG_PLAYSOUNDEFFECT:
    dec     a
PLY_AKG_PTSOUNDEFFECTTABLE:
    ld      hl, 0
    ld      e, a
    ld      d, 0
    add     hl, de
    add     hl, de
    ld      e, (hl)
    inc     hl
    ld      d, (hl)
    ld      a, (de)
    inc     de
    ex      af, af'
    ld      a, b
    ld      hl, PLY_AKG_CHANNEL1_SOUNDEFFECTDATA
    ld      b, 0
    defc    PLY_AKG_OPCODE_INC_HL=ASMPC+1
    sla     c
    sla     c
    sla     c
    add     hl, bc
    ld      (hl), e
    inc     hl
PLY_AKG_OPCODE_DEC_HL:
    ld      (hl), d
    inc     hl
    ld      (hl), a
    inc     hl
    ld      (hl), 0
    inc     hl
    ex      af, af'
    ld      (hl), a
    ret
PLY_AKG_STOPSOUNDEFFECTFROMCHANNEL:
    add     a, a
    add     a, a
PLY_AKG_OPCODE_SCF:
    add     a, a
    ld      e, a
    ld      d, 0
    ld      hl, PLY_AKG_CHANNEL1_SOUNDEFFECTDATA
    add     hl, de
    ld      (hl), d
    inc     hl
    ld      (hl), d
PLY_AKG_OPCODE_SBC_HL_BC_LSB:
    ret
PLY_AKG_PLAYSOUNDEFFECTSSTREAM:
    rla
    rla
    ld      ix, PLY_AKG_CHANNEL1_SOUNDEFFECTDATA
    ld      iy, PLY_AKG_PSGREG8
    ld      hl, PLY_AKG_PSGREG01_INSTR+1
    exx
    ld      c, a
    call    PLY_AKG_PSES_PLAY
    ld      ix, PLY_AKG_CHANNEL2_SOUNDEFFECTDATA
    ld      iy, PLY_AKG_PSGREG9
    exx
    ld      hl, PLY_AKG_PSGREG23_INSTR+1
    exx
    rr      c
    call    PLY_AKG_PSES_PLAY
    ld      ix, PLY_AKG_CHANNEL3_SOUNDEFFECTDATA
    ld      iy, PLY_AKG_PSGREG10
    exx
    ld      hl, PLY_AKG_PSGREG45_INSTR+1
    exx
    rr      c
    call    PLY_AKG_PSES_PLAY
    ld      a, c
    ret
PLY_AKG_PSES_PLAY:
    ld      l, (ix+0)
    ld      h, (ix+1)
    ld      a, l
    or      h
    ret     z
PLY_AKG_PSES_READFIRSTBYTE:
    ld      a, (hl)
    inc     hl
    ld      b, a
    rra
    jr      c, PLY_AKG_PSES_SOFTWAREORSOFTWAREANDHARDWARE
    rra
    jr      c, PLY_AKG_PSES_HARDWAREONLY
    rra
    jr      c, PLY_AKG_PSES_S_ENDORLOOP
    call    PLY_AKG_PSES_MANAGEVOLUMEFROMA_FILTER4BITS
    rl      b
    call    PLY_AKG_PSES_READNOISEIFNEEDEDANDOPENORCLOSENOISECHANNEL
    set     2, c
    jr      PLY_AKG_PSES_SAVEPOINTERANDEXIT
PLY_AKG_PSES_S_ENDORLOOP:
    rra
    jr      c, PLY_AKG_PSES_S_LOOP
    xor     a
    ld      (ix+0), a
    ld      (ix+1), a
    ret
PLY_AKG_PSES_S_LOOP:
    ld      a, (hl)
    inc     hl
    ld      h, (hl)
    ld      l, a
    jr      PLY_AKG_PSES_READFIRSTBYTE
PLY_AKG_PSES_SAVEPOINTERANDEXIT:
    ld      a, (ix+3)
    cp      (ix+4)
    jr      c, PLY_AKG_PSES_NOTREACHED
    defc    PLY_AKG_OPCODE_OR_A=ASMPC+2
    ld      (ix+3), 0
    db      221
    db      117
    db      0
    db      221
    db      116
    db      1
    ret
PLY_AKG_PSES_NOTREACHED:
    inc     (ix+3)
    ret
    defc    PLY_AKG_OPCODE_ADD_A_IMMEDIATE=ASMPC+2
PLY_AKG_PSES_HARDWAREONLY:
    call    PLY_AKG_PSES_SHARED_READRETRIGHARDWAREENVPERIODNOISE
    set     2, c
    jr      PLY_AKG_PSES_SAVEPOINTERANDEXIT
PLY_AKG_PSES_SOFTWAREORSOFTWAREANDHARDWARE:
    rra
    jr      c, PLY_AKG_PSES_SOFTWAREANDHARDWARE
    call    PLY_AKG_PSES_MANAGEVOLUMEFROMA_FILTER4BITS
    rl      b
    call    PLY_AKG_PSES_READNOISEIFNEEDEDANDOPENORCLOSENOISECHANNEL
PLY_AKG_OPCODE_SUB_IMMEDIATE:
    res     2, c
    call    PLY_AKG_PSES_READSOFTWAREPERIOD
    jr      PLY_AKG_PSES_SAVEPOINTERANDEXIT
PLY_AKG_PSES_SOFTWAREANDHARDWARE:
    call    PLY_AKG_PSES_SHARED_READRETRIGHARDWAREENVPERIODNOISE
    call    PLY_AKG_PSES_READSOFTWAREPERIOD
    res     2, c
    jr      PLY_AKG_PSES_SAVEPOINTERANDEXIT
PLY_AKG_PSES_SHARED_READRETRIGHARDWAREENVPERIODNOISE:
    rra
    jr      nc, PLY_AKG_PSES_H_AFTERRETRIG
    ld      d, a
    ld      a, 255
PLY_AKG_OPCODE_SBC_HL_BC_MSB:
    ld      (PLY_AKG_PSGREG13_OLDVALUE+1), a
    ld      a, d
PLY_AKG_PSES_H_AFTERRETRIG:
    and     7
    add     a, 8
    ld      (PLY_AKG_PSGREG13_INSTR+1), a
    rl      b
    call    PLY_AKG_PSES_READNOISEIFNEEDEDANDOPENORCLOSENOISECHANNEL
    call    PLY_AKG_PSES_READHARDWAREPERIOD
    ld      a, 16
    jp      PLY_AKG_PSES_MANAGEVOLUMEFROMA_HARD
PLY_AKG_PSES_READNOISEIFNEEDEDANDOPENORCLOSENOISECHANNEL:
    jr      c, PLY_AKG_PSES_READNOISEANDOPENNOISECHANNEL_OPENNOISE
    set     5, c
    ret
PLY_AKG_PSES_READNOISEANDOPENNOISECHANNEL_OPENNOISE:
    ld      a, (hl)
    ld      (PLY_AKG_PSGREG6), a
    inc     hl
    res     5, c
    ret
PLY_AKG_PSES_READHARDWAREPERIOD:
    ld      a, (hl)
    ld      (PLY_AKG_PSGHARDWAREPERIOD_INSTR+1), a
    inc     hl
    ld      a, (hl)
    ld      (PLY_AKG_PSGHARDWAREPERIOD_INSTR+2), a
    inc     hl
    ret
PLY_AKG_PSES_READSOFTWAREPERIOD:
    ld      a, (hl)
    inc     hl
    exx
    ld      (hl), a
    inc     hl
    exx
    ld      a, (hl)
    inc     hl
    exx
    ld      (hl), a
    exx
    ret
PLY_AKG_PSES_MANAGEVOLUMEFROMA_FILTER4BITS:
    and     15
PLY_AKG_PSES_MANAGEVOLUMEFROMA_HARD:
    sub     (ix+2)
    jr      nc, PLY_AKG_PSES_MVFA_NOOVERFLOW
    xor     a
PLY_AKG_PSES_MVFA_NOOVERFLOW:
    ld      (iy+0), a
    ret
PLY_AKG_CHANNEL1_SOUNDEFFECTDATA:
    dw      0
PLY_AKG_CHANNEL1_SOUNDEFFECTINVERTEDVOLUME:
    db      0
PLY_AKG_CHANNEL1_SOUNDEFFECTCURRENTSTEP:
    db      0
PLY_AKG_CHANNEL1_SOUNDEFFECTSPEED:
    db      0
    db      0
    db      0
    db      0
PLY_AKG_CHANNEL2_SOUNDEFFECTDATA:
    db      0
    db      0
    db      0
    db      0
    db      0
    db      0
    db      0
    db      0
PLY_AKG_CHANNEL3_SOUNDEFFECTDATA:
    db      0
    db      0
    db      0
    db      0
    db      0
    db      0
    db      0
    db      0
PLY_AKG_INIT:
    ld      de, 4
    add     hl, de
    ld      de, PLY_AKG_ARPEGGIOSTABLE+1
    ldi
    ldi
    ld      de, PLY_AKG_PITCHESTABLE+1
    ldi
    ldi
    ld      de, PLY_AKG_INSTRUMENTSTABLE+1
    ldi
    ldi
    ld      c, (hl)
    inc     hl
    ld      b, (hl)
    inc     hl
    ld      (PLY_AKG_CHANNEL_READEFFECTS_EFFECTBLOCKS1+1), bc
    ld      (PLY_AKG_CHANNEL_READEFFECTS_EFFECTBLOCKS2+1), bc
    add     a, a
    ld      e, a
    ld      d, 0
    add     hl, de
    ld      a, (hl)
    inc     hl
    ld      h, (hl)
    ld      l, a
    ld      de, 5
    add     hl, de
    ld      de, PLY_AKG_CHANNEL3_READCELLEND+1
    ldi
    ld      de, PLY_AKG_CHANNEL1_NOTE+1
    ldi
    ld      (PLY_AKG_READLINKER+1), hl
    ld      hl, PLY_AKG_INITTABLE0
    ld      bc, 3584
    call    PLY_AKG_INIT_READWORDSANDFILL
    inc     c
    ld      hl, PLY_AKG_INITTABLE0_END
    ld      b, 3
    call    PLY_AKG_INIT_READWORDSANDFILL
    ld      hl, PLY_AKG_INITTABLE1_END
    ld      bc, 3511
    call    PLY_AKG_INIT_READWORDSANDFILL
    ld      a, 255
    ld      (PLY_AKG_PSGREG13_OLDVALUE+1), a
    ld      hl, (PLY_AKG_INSTRUMENTSTABLE+1)
    ld      e, (hl)
    inc     hl
    ld      d, (hl)
    ex      de, hl
    inc     hl
    ld      (PLY_AKG_ENDWITHOUTLOOP+1), hl
    ld      (PLY_AKG_CHANNEL1_PTINSTRUMENT+1), hl
    ld      (PLY_AKG_CHANNEL2_PTINSTRUMENT+1), hl
    ld      (PLY_AKG_CHANNEL3_PTINSTRUMENT+1), hl
    ld      hl, 0
    ld      (PLY_AKG_CHANNEL1_SOUNDEFFECTDATA), hl
    ld      (PLY_AKG_CHANNEL2_SOUNDEFFECTDATA), hl
    ld      (PLY_AKG_CHANNEL3_SOUNDEFFECTDATA), hl
    ret
PLY_AKG_INIT_READWORDSANDFILL_LOOP:
    ld      e, (hl)
    inc     hl
    ld      d, (hl)
    inc     hl
    ld      a, c
    ld      (de), a
PLY_AKG_INIT_READWORDSANDFILL:
    djnz    PLY_AKG_INIT_READWORDSANDFILL_LOOP
    ret
PLY_AKG_INITTABLE0:
    dw      PLY_AKG_CHANNEL1_INVERTEDVOLUMEINTEGERANDDECIMAL+1
    dw      PLY_AKG_CHANNEL1_INVERTEDVOLUMEINTEGER
    dw      PLY_AKG_CHANNEL2_INVERTEDVOLUMEINTEGERANDDECIMAL+1
    dw      PLY_AKG_CHANNEL2_INVERTEDVOLUMEINTEGER
    dw      PLY_AKG_CHANNEL3_INVERTEDVOLUMEINTEGERANDDECIMAL+1
    dw      PLY_AKG_CHANNEL3_INVERTEDVOLUMEINTEGER
    dw      PLY_AKG_CHANNEL1_PITCHTABLE_END+1
    dw      PLY_AKG_CHANNEL1_PITCHTABLE_END+2
    dw      PLY_AKG_CHANNEL2_PITCHTABLE_END+1
    dw      PLY_AKG_CHANNEL2_PITCHTABLE_END+2
    dw      PLY_AKG_CHANNEL3_PITCHTABLE_END+1
    dw      PLY_AKG_CHANNEL3_PITCHTABLE_END+2
    dw      PLY_AKG_RETRIG+1

PLY_AKG_INITTABLE0_END:
PLY_AKG_INITTABLE1:
    dw      PLY_AKG_PATTERNDECREASINGHEIGHT+1
    dw      PLY_AKG_TICKDECREASINGCOUNTER+1

PLY_AKG_INITTABLE1_END:
PLY_AKG_INITTABLEORA:
    dw      PLY_AKG_CHANNEL1_ISVOLUMESLIDE
    dw      PLY_AKG_CHANNEL2_ISVOLUMESLIDE
    dw      PLY_AKG_CHANNEL3_ISVOLUMESLIDE
    dw      PLY_AKG_CHANNEL1_ISARPEGGIOTABLE
    dw      PLY_AKG_CHANNEL2_ISARPEGGIOTABLE
    dw      PLY_AKG_CHANNEL3_ISARPEGGIOTABLE
    dw      PLY_AKG_CHANNEL1_ISPITCHTABLE
    dw      PLY_AKG_CHANNEL2_ISPITCHTABLE
    dw      PLY_AKG_CHANNEL3_ISPITCHTABLE
    dw      PLY_AKG_CHANNEL1_ISPITCH
    dw      PLY_AKG_CHANNEL2_ISPITCH
    dw      PLY_AKG_CHANNEL3_ISPITCH

PLY_AKG_INITTABLEORA_END:
PLY_AKG_STOP:
    ld      (PLY_AKG_PSGREG13_END+1), sp
    xor     a
    ld      l, a
    ld      h, a
    ld      (PLY_AKG_PSGREG8), a
    ld      (PLY_AKG_PSGREG9), hl
    ld      a, 63
    jp      PLY_AKG_SENDPSGREGISTERS
PLY_AKG_PLAY:
    ld      (PLY_AKG_PSGREG13_END+1), sp
    xor     a
    ld      (PLY_AKG_EVENT), a
PLY_AKG_TICKDECREASINGCOUNTER:
    ld      a, 1
    dec     a
    jp      nz, PLY_AKG_SETSPEEDBEFOREPLAYSTREAMS
PLY_AKG_PATTERNDECREASINGHEIGHT:
    ld      a, 1
    dec     a
    jr      nz, PLY_AKG_SETCURRENTLINEBEFOREREADLINE

PLY_AKG_READLINKER:
PLY_AKG_READLINKER_PTLINKER:
    ld      sp, 0
    pop     hl
    ld      a, l
    or      h
    jr      nz, PLY_AKG_READLINKER_NOLOOP
    pop     hl
    ld      sp, hl
    pop     hl
PLY_AKG_READLINKER_NOLOOP:
    ld      (PLY_AKG_CHANNEL1_READTRACK+1), hl
    pop     hl
    ld      (PLY_AKG_CHANNEL2_READTRACK+1), hl
    pop     hl
    ld      (PLY_AKG_CHANNEL3_READTRACK+1), hl
    pop     hl
    ld      (PLY_AKG_READLINKER+1), sp
    ld      sp, hl
    pop     hl
    ld      c, l
    ld      a, h
    ld      (PLY_AKG_CHANNEL1_AFTERNOTEKNOWN+1), a
    pop     hl
    ld      a, l
    ld      (PLY_AKG_CHANNEL2_AFTERNOTEKNOWN+1), a
    ld      a, h
    ld      (PLY_AKG_CHANNEL3_AFTERNOTEKNOWN+1), a
    pop     hl
    ld      (PLY_AKG_SPEEDTRACK_PTTRACK+1), hl
    pop     hl
    ld      (PLY_AKG_EVENTTRACK_PTTRACK+1), hl
    xor     a
    ld      (PLY_AKG_READLINE+1), a
    ld      (PLY_AKG_SPEEDTRACK_END+1), a
    ld      (PLY_AKG_EVENTTRACK_END+1), a
    ld      (PLY_AKG_CHANNEL1_READCELLEND+1), a
    ld      (PLY_AKG_CHANNEL2_READCELLEND+1), a
    ld      a, c
PLY_AKG_SETCURRENTLINEBEFOREREADLINE:
    ld      (PLY_AKG_PATTERNDECREASINGHEIGHT+1), a

PLY_AKG_READLINE:
PLY_AKG_SPEEDTRACK_WAITCOUNTER:
    ld      a, 0
    sub     1
    jr      nc, PLY_AKG_SPEEDTRACK_MUSTWAIT
PLY_AKG_SPEEDTRACK_PTTRACK:
    ld      hl, 0
    ld      a, (hl)
    inc     hl
    srl     a
    jr      c, PLY_AKG_SPEEDTRACK_STOREPOINTERANDWAITCOUNTER
    jr      nz, PLY_AKG_SPEEDTRACK_NORMALVALUE
    ld      a, (hl)
    inc     hl
PLY_AKG_SPEEDTRACK_NORMALVALUE:
    ld      (PLY_AKG_CHANNEL3_READCELLEND+1), a
    xor     a
PLY_AKG_SPEEDTRACK_STOREPOINTERANDWAITCOUNTER:
    ld      (PLY_AKG_SPEEDTRACK_PTTRACK+1), hl
PLY_AKG_SPEEDTRACK_MUSTWAIT:
    ld      (PLY_AKG_READLINE+1), a

PLY_AKG_SPEEDTRACK_END:
PLY_AKG_EVENTTRACK_WAITCOUNTER:
    ld      a, 0
    sub     1
    jr      nc, PLY_AKG_EVENTTRACK_MUSTWAIT
PLY_AKG_EVENTTRACK_PTTRACK:
    ld      hl, 0
    ld      a, (hl)
    inc     hl
    srl     a
    jr      c, PLY_AKG_EVENTTRACK_STOREPOINTERANDWAITCOUNTER
    jr      nz, PLY_AKG_EVENTTRACK_NORMALVALUE
    ld      a, (hl)
    inc     hl
PLY_AKG_EVENTTRACK_NORMALVALUE:
    ld      (PLY_AKG_EVENT), a
    xor     a
PLY_AKG_EVENTTRACK_STOREPOINTERANDWAITCOUNTER:
    ld      (PLY_AKG_EVENTTRACK_PTTRACK+1), hl
PLY_AKG_EVENTTRACK_MUSTWAIT:
    ld      (PLY_AKG_SPEEDTRACK_END+1), a

PLY_AKG_EVENTTRACK_END:
PLY_AKG_CHANNEL1_WAITCOUNTER:
    ld      a, 0
    sub     1
    jr      c, PLY_AKG_CHANNEL1_READTRACK
    ld      (PLY_AKG_EVENTTRACK_END+1), a
    jp      PLY_AKG_CHANNEL1_READCELLEND

PLY_AKG_CHANNEL1_READTRACK:
PLY_AKG_CHANNEL1_PTTRACK:
    ld      hl, 0
    ld      c, (hl)
    inc     hl
    ld      a, c
    and     63
    cp      60
    jr      c, PLY_AKG_CHANNEL1_NOTE
    sub     60
    jp      z, PLY_AKG_CHANNEL1_MAYBEEFFECTS
    dec     a
    jr      z, PLY_AKG_CHANNEL1_WAIT
    dec     a
    jr      z, PLY_AKG_CHANNEL1_SMALLWAIT
    ld      a, (hl)
    inc     hl
    jr      PLY_AKG_CHANNEL1_AFTERNOTEKNOWN
PLY_AKG_CHANNEL1_SMALLWAIT:
    ld      a, c
    rlca
    rlca
    and     3
    inc     a
    ld      (PLY_AKG_EVENTTRACK_END+1), a
    jr      PLY_AKG_CHANNEL1_BEFOREEND_STORECELLPOINTER
PLY_AKG_CHANNEL1_WAIT:
    ld      a, (hl)
    ld      (PLY_AKG_EVENTTRACK_END+1), a
    inc     hl
    jr      PLY_AKG_CHANNEL1_BEFOREEND_STORECELLPOINTER

PLY_AKG_CHANNEL1_SAMEINSTRUMENT:
PLY_AKG_CHANNEL1_PTBASEINSTRUMENT:
    ld      de, 0
    ld      (PLY_AKG_CHANNEL1_PTINSTRUMENT+1), de
    jr      PLY_AKG_CHANNEL1_AFTERINSTRUMENT

PLY_AKG_CHANNEL1_NOTE:
PLY_AKG_BASENOTEINDEX:
    add     a, 0

PLY_AKG_CHANNEL1_AFTERNOTEKNOWN:
PLY_AKG_CHANNEL1_TRANSPOSITION:
    add     a, 0
    ld      (PLY_AKG_CHANNEL1_TRACKNOTE+1), a
    rl      c
    jr      nc, PLY_AKG_CHANNEL1_SAMEINSTRUMENT
    ld      a, (hl)
    inc     hl
    exx
    ld      l, a
    ld      h, 0
    add     hl, hl
PLY_AKG_INSTRUMENTSTABLE:
    ld      de, 0
    add     hl, de
    ld      sp, hl
    pop     hl
    ld      a, (hl)
    inc     hl
    ld      (PLY_AKG_CHANNEL1_INSTRUMENTORIGINALSPEED+1), a
    ld      (PLY_AKG_CHANNEL1_PTINSTRUMENT+1), hl
    ld      (PLY_AKG_CHANNEL1_SAMEINSTRUMENT+1), hl
    exx
PLY_AKG_CHANNEL1_AFTERINSTRUMENT:
    ex      de, hl
    xor     a
    ld      l, a
    ld      h, a
    ld      (PLY_AKG_CHANNEL1_PITCHTABLE_END+1), hl
    ld      (PLY_AKG_CHANNEL1_ARPEGGIOTABLECURRENTSTEP+1), a
    ld      (PLY_AKG_CHANNEL1_PITCHTABLECURRENTSTEP+1), a
    ld      (PLY_AKG_CHANNEL1_INSTRUMENTSTEP+2), a
PLY_AKG_CHANNEL1_INSTRUMENTORIGINALSPEED:
    ld      a, 0
    ld      (PLY_AKG_CHANNEL1_INSTRUMENTSPEED+1), a
    ld      a, 183
    ld      (PLY_AKG_CHANNEL1_ISPITCH), a
    ld      a, (PLY_AKG_CHANNEL1_ARPEGGIOBASESPEED)
    ld      (PLY_AKG_CHANNEL1_ARPEGGIOTABLESPEED), a
    ld      a, (PLY_AKG_CHANNEL1_PITCHBASESPEED)
    ld      (PLY_AKG_CHANNEL1_PITCHTABLESPEED), a
    ld      hl, (PLY_AKG_CHANNEL1_ARPEGGIOTABLEBASE)
    ld      (PLY_AKG_CHANNEL1_ARPEGGIOTABLE+1), hl
    ld      hl, (PLY_AKG_CHANNEL1_PITCHTABLEBASE)
    ld      (PLY_AKG_CHANNEL1_PITCHTABLE+1), hl
    ex      de, hl
    rl      c
    jp      c, PLY_AKG_CHANNEL1_READEFFECTS
PLY_AKG_CHANNEL1_BEFOREEND_STORECELLPOINTER:
    ld      (PLY_AKG_CHANNEL1_READTRACK+1), hl

PLY_AKG_CHANNEL1_READCELLEND:
PLY_AKG_CHANNEL2_WAITCOUNTER:
    ld      a, 0
    sub     1
    jr      c, PLY_AKG_CHANNEL2_READTRACK
    ld      (PLY_AKG_CHANNEL1_READCELLEND+1), a
    jp      PLY_AKG_CHANNEL2_READCELLEND

PLY_AKG_CHANNEL2_READTRACK:
PLY_AKG_CHANNEL2_PTTRACK:
    ld      hl, 0
    ld      c, (hl)
    inc     hl
    ld      a, c
    and     63
    cp      60
    jr      c, PLY_AKG_CHANNEL2_NOTE
    sub     60
    jp      z, PLY_AKG_CHANNEL1_READEFFECTSEND
    dec     a
    jr      z, PLY_AKG_CHANNEL2_WAIT
    dec     a
    jr      z, PLY_AKG_CHANNEL2_SMALLWAIT
    ld      a, (hl)
    inc     hl
    jr      PLY_AKG_CHANNEL2_AFTERNOTEKNOWN
PLY_AKG_CHANNEL2_SMALLWAIT:
    ld      a, c
    rlca
    rlca
    and     3
    inc     a
    ld      (PLY_AKG_CHANNEL1_READCELLEND+1), a
    jr      PLY_AKG_CHANNEL2_BEFOREEND_STORECELLPOINTER
PLY_AKG_CHANNEL2_WAIT:
    ld      a, (hl)
    ld      (PLY_AKG_CHANNEL1_READCELLEND+1), a
    inc     hl
    jr      PLY_AKG_CHANNEL2_BEFOREEND_STORECELLPOINTER

PLY_AKG_CHANNEL2_SAMEINSTRUMENT:
PLY_AKG_CHANNEL2_PTBASEINSTRUMENT:
    ld      de, 0
    ld      (PLY_AKG_CHANNEL2_PTINSTRUMENT+1), de
    jr      PLY_AKG_CHANNEL2_AFTERINSTRUMENT
PLY_AKG_CHANNEL2_NOTE:
    ld      b, a
    ld      a, (PLY_AKG_CHANNEL1_NOTE+1)
    add     a, b

PLY_AKG_CHANNEL2_AFTERNOTEKNOWN:
PLY_AKG_CHANNEL2_TRANSPOSITION:
    add     a, 0
    ld      (PLY_AKG_CHANNEL2_TRACKNOTE+1), a
    rl      c
    jr      nc, PLY_AKG_CHANNEL2_SAMEINSTRUMENT
    ld      a, (hl)
    inc     hl
    exx
    ld      e, a
    ld      d, 0
    ld      hl, (PLY_AKG_INSTRUMENTSTABLE+1)
    add     hl, de
    add     hl, de
    ld      sp, hl
    pop     hl
    ld      a, (hl)
    inc     hl
    ld      (PLY_AKG_CHANNEL2_INSTRUMENTORIGINALSPEED+1), a
    ld      (PLY_AKG_CHANNEL2_PTINSTRUMENT+1), hl
    ld      (PLY_AKG_CHANNEL2_SAMEINSTRUMENT+1), hl
    exx
PLY_AKG_CHANNEL2_AFTERINSTRUMENT:
    ex      de, hl
    xor     a
    ld      l, a
    ld      h, a
    ld      (PLY_AKG_CHANNEL2_PITCHTABLE_END+1), hl
    ld      (PLY_AKG_CHANNEL2_ARPEGGIOTABLECURRENTSTEP+1), a
    ld      (PLY_AKG_CHANNEL2_PITCHTABLECURRENTSTEP+1), a
    ld      (PLY_AKG_CHANNEL2_INSTRUMENTSTEP+2), a
PLY_AKG_CHANNEL2_INSTRUMENTORIGINALSPEED:
    ld      a, 0
    ld      (PLY_AKG_CHANNEL2_INSTRUMENTSPEED+1), a
    ld      a, 183
    ld      (PLY_AKG_CHANNEL2_ISPITCH), a
    ld      a, (PLY_AKG_CHANNEL2_ARPEGGIOBASESPEED)
    ld      (PLY_AKG_CHANNEL2_ARPEGGIOTABLESPEED), a
    ld      a, (PLY_AKG_CHANNEL2_PITCHBASESPEED)
    ld      (PLY_AKG_CHANNEL2_PITCHTABLESPEED), a
    ld      hl, (PLY_AKG_CHANNEL2_ARPEGGIOTABLEBASE)
    ld      (PLY_AKG_CHANNEL2_ARPEGGIOTABLE+1), hl
    ld      hl, (PLY_AKG_CHANNEL2_PITCHTABLEBASE)
    ld      (PLY_AKG_CHANNEL2_PITCHTABLE+1), hl
    ex      de, hl
    rl      c
    jp      c, PLY_AKG_CHANNEL2_READEFFECTS
PLY_AKG_CHANNEL2_BEFOREEND_STORECELLPOINTER:
    ld      (PLY_AKG_CHANNEL2_READTRACK+1), hl

PLY_AKG_CHANNEL2_READCELLEND:
PLY_AKG_CHANNEL3_WAITCOUNTER:
    ld      a, 0
    sub     1
    jr      c, PLY_AKG_CHANNEL3_READTRACK
    ld      (PLY_AKG_CHANNEL2_READCELLEND+1), a
    jp      PLY_AKG_CHANNEL3_READCELLEND

PLY_AKG_CHANNEL3_READTRACK:
PLY_AKG_CHANNEL3_PTTRACK:
    ld      hl, 0
    ld      c, (hl)
    inc     hl
    ld      a, c
    and     63
    cp      60
    jr      c, PLY_AKG_CHANNEL3_NOTE
    sub     60
    jp      z, PLY_AKG_CHANNEL2_READEFFECTSEND
    dec     a
    jr      z, PLY_AKG_CHANNEL3_WAIT
    dec     a
    jr      z, PLY_AKG_CHANNEL3_SMALLWAIT
    ld      a, (hl)
    inc     hl
    jr      PLY_AKG_CHANNEL3_AFTERNOTEKNOWN
PLY_AKG_CHANNEL3_SMALLWAIT:
    ld      a, c
    rlca
    rlca
    and     3
    inc     a
    ld      (PLY_AKG_CHANNEL2_READCELLEND+1), a
    jr      PLY_AKG_CHANNEL3_BEFOREEND_STORECELLPOINTER
PLY_AKG_CHANNEL3_WAIT:
    ld      a, (hl)
    ld      (PLY_AKG_CHANNEL2_READCELLEND+1), a
    inc     hl
    jr      PLY_AKG_CHANNEL3_BEFOREEND_STORECELLPOINTER

PLY_AKG_CHANNEL3_SAMEINSTRUMENT:
PLY_AKG_CHANNEL3_PTBASEINSTRUMENT:
    ld      de, 0
    ld      (PLY_AKG_CHANNEL3_PTINSTRUMENT+1), de
    jr      PLY_AKG_CHANNEL3_AFTERINSTRUMENT
PLY_AKG_CHANNEL3_NOTE:
    ld      b, a
    ld      a, (PLY_AKG_CHANNEL1_NOTE+1)
    add     a, b

PLY_AKG_CHANNEL3_AFTERNOTEKNOWN:
PLY_AKG_CHANNEL3_TRANSPOSITION:
    add     a, 0
    ld      (PLY_AKG_CHANNEL3_TRACKNOTE+1), a
    rl      c
    jr      nc, PLY_AKG_CHANNEL3_SAMEINSTRUMENT
    ld      a, (hl)
    inc     hl
    exx
    ld      e, a
    ld      d, 0
    ld      hl, (PLY_AKG_INSTRUMENTSTABLE+1)
    add     hl, de
    add     hl, de
    ld      sp, hl
    pop     hl
    ld      a, (hl)
    inc     hl
    ld      (PLY_AKG_CHANNEL3_INSTRUMENTORIGINALSPEED+1), a
    ld      (PLY_AKG_CHANNEL3_PTINSTRUMENT+1), hl
    ld      (PLY_AKG_CHANNEL3_SAMEINSTRUMENT+1), hl
    exx
PLY_AKG_CHANNEL3_AFTERINSTRUMENT:
    ex      de, hl
    xor     a
    ld      l, a
    ld      h, a
    ld      (PLY_AKG_CHANNEL3_PITCHTABLE_END+1), hl
    ld      (PLY_AKG_CHANNEL3_ARPEGGIOTABLECURRENTSTEP+1), a
    ld      (PLY_AKG_CHANNEL3_PITCHTABLECURRENTSTEP+1), a
    ld      (PLY_AKG_CHANNEL3_INSTRUMENTSTEP+2), a
PLY_AKG_CHANNEL3_INSTRUMENTORIGINALSPEED:
    ld      a, 0
    ld      (PLY_AKG_CHANNEL3_INSTRUMENTSPEED+1), a
    ld      a, 183
    ld      (PLY_AKG_CHANNEL3_ISPITCH), a
    ld      a, (PLY_AKG_CHANNEL3_ARPEGGIOBASESPEED)
    ld      (PLY_AKG_CHANNEL3_ARPEGGIOTABLESPEED), a
    ld      a, (PLY_AKG_CHANNEL3_PITCHBASESPEED)
    ld      (PLY_AKG_CHANNEL3_PITCHTABLESPEED), a
    ld      hl, (PLY_AKG_CHANNEL3_ARPEGGIOTABLEBASE)
    ld      (PLY_AKG_CHANNEL3_ARPEGGIOTABLE+1), hl
    ld      hl, (PLY_AKG_CHANNEL3_PITCHTABLEBASE)
    ld      (PLY_AKG_CHANNEL3_PITCHTABLE+1), hl
    ex      de, hl
    rl      c
    jp      c, PLY_AKG_CHANNEL3_READEFFECTS
PLY_AKG_CHANNEL3_BEFOREEND_STORECELLPOINTER:
    ld      (PLY_AKG_CHANNEL3_READTRACK+1), hl

PLY_AKG_CHANNEL3_READCELLEND:
PLY_AKG_CURRENTSPEED:
    ld      a, 0
PLY_AKG_SETSPEEDBEFOREPLAYSTREAMS:
    ld      (PLY_AKG_TICKDECREASINGCOUNTER+1), a
    defc    PLY_AKG_CHANNEL1_INVERTEDVOLUMEINTEGER=ASMPC+2
PLY_AKG_CHANNEL1_INVERTEDVOLUMEINTEGERANDDECIMAL:
    ld      hl, 0
PLY_AKG_CHANNEL1_ISVOLUMESLIDE:
    or      a
    jr      nc, PLY_AKG_CHANNEL1_VOLUMESLIDE_END
PLY_AKG_CHANNEL1_VOLUMESLIDEVALUE:
    ld      de, 0
    add     hl, de
    bit     7, h
    jr      z, PLY_AKG_CHANNEL1_VOLUMENOTOVERFLOW
    ld      h, 0
    jr      PLY_AKG_CHANNEL1_VOLUMESETAGAIN
PLY_AKG_CHANNEL1_VOLUMENOTOVERFLOW:
    ld      a, h
    cp      16
    jr      c, PLY_AKG_CHANNEL1_VOLUMESETAGAIN
    ld      h, 15
PLY_AKG_CHANNEL1_VOLUMESETAGAIN:
    ld      (PLY_AKG_CHANNEL1_INVERTEDVOLUMEINTEGERANDDECIMAL+1), hl
PLY_AKG_CHANNEL1_VOLUMESLIDE_END:
    ld      a, h
    ld      (PLY_AKG_CHANNEL1_GENERATEDCURRENTINVERTEDVOLUME+1), a
    ld      c, 0
PLY_AKG_CHANNEL1_ISARPEGGIOTABLE:
    or      a
    jr      nc, PLY_AKG_CHANNEL1_ARPEGGIOTABLE_END
PLY_AKG_CHANNEL1_ARPEGGIOTABLE:
    ld      hl, 0
    ld      a, (hl)
    cp      128
    jr      nz, PLY_AKG_CHANNEL1_ARPEGGIOTABLE_AFTERLOOPTEST
    inc     hl
    ld      a, (hl)
    inc     hl
    ld      h, (hl)
    ld      l, a
    ld      a, (hl)
PLY_AKG_CHANNEL1_ARPEGGIOTABLE_AFTERLOOPTEST:
    ld      c, a
    ld      a, (PLY_AKG_CHANNEL1_ARPEGGIOTABLESPEED)
    ld      d, a
PLY_AKG_CHANNEL1_ARPEGGIOTABLECURRENTSTEP:
    ld      a, 0
    inc     a
    cp      d
    jr      c, PLY_AKG_CHANNEL1_ARPEGGIOTABLE_BEFOREEND_SAVESTEP
    inc     hl
    ld      (PLY_AKG_CHANNEL1_ARPEGGIOTABLE+1), hl
    xor     a
PLY_AKG_CHANNEL1_ARPEGGIOTABLE_BEFOREEND_SAVESTEP:
    ld      (PLY_AKG_CHANNEL1_ARPEGGIOTABLECURRENTSTEP+1), a
PLY_AKG_CHANNEL1_ARPEGGIOTABLE_END:
    ld      de, 0
PLY_AKG_CHANNEL1_ISPITCHTABLE:
    or      a
    jr      nc, PLY_AKG_CHANNEL1_PITCHTABLE_END
PLY_AKG_CHANNEL1_PITCHTABLE:
    ld      sp, 0
    pop     de
    pop     hl
    ld      a, (PLY_AKG_CHANNEL1_PITCHTABLESPEED)
    ld      b, a
PLY_AKG_CHANNEL1_PITCHTABLECURRENTSTEP:
    ld      a, 0
    inc     a
    cp      b
    jr      c, PLY_AKG_CHANNEL1_PITCHTABLE_BEFOREEND_SAVESTEP
    ld      (PLY_AKG_CHANNEL1_PITCHTABLE+1), hl
    xor     a
PLY_AKG_CHANNEL1_PITCHTABLE_BEFOREEND_SAVESTEP:
    ld      (PLY_AKG_CHANNEL1_PITCHTABLECURRENTSTEP+1), a

PLY_AKG_CHANNEL1_PITCHTABLE_END:
PLY_AKG_CHANNEL1_PITCH:
    ld      hl, 0
PLY_AKG_CHANNEL1_ISPITCH:
    or      a
    jr      nc, PLY_AKG_CHANNEL1_PITCH_END
    db      221
    db      105
PLY_AKG_CHANNEL1_PITCHTRACK:
    ld      bc, 0
    or      a
PLY_AKG_CHANNEL1_PITCHTRACKADDORSBC_16BITS:
    nop
    add     hl, bc
PLY_AKG_CHANNEL1_PITCHTRACKDECIMALCOUNTER:
    ld      a, 0
    defc    PLY_AKG_CHANNEL1_PITCHTRACKDECIMALVALUE=ASMPC+1
PLY_AKG_CHANNEL1_PITCHTRACKDECIMALINSTR:
    add     a, 0
    ld      (PLY_AKG_CHANNEL1_PITCHTRACKDECIMALCOUNTER+1), a
    jr      nc, PLY_AKG_CHANNEL1_PITCHNOCARRY
PLY_AKG_CHANNEL1_PITCHTRACKINTEGERADDORSUB:
    inc     hl
PLY_AKG_CHANNEL1_PITCHNOCARRY:
    ld      (PLY_AKG_CHANNEL1_PITCHTABLE_END+1), hl

PLY_AKG_CHANNEL1_SOUNDSTREAM_RELATIVEMODIFIERADDRESS:
PLY_AKG_CHANNEL1_GLIDEDIRECTION:
    ld      a, 0
    or      a
    jr      z, PLY_AKG_CHANNEL1_GLIDE_END
    ld      (PLY_AKG_CHANNEL1_AFTERARPEGGIOPITCHVARIABLES+1), hl
    ld      c, l
    ld      b, h
    ex      af, af'
    ld      a, (PLY_AKG_CHANNEL1_TRACKNOTE+1)
    add     a, a
    ld      l, a
    ex      af, af'
    ld      h, 0
    ld      sp, PLY_AKG_PERIODTABLE
    add     hl, sp
    ld      sp, hl
    pop     hl
    dec     sp
    dec     sp
    add     hl, bc
PLY_AKG_CHANNEL1_GLIDETOREACH:
    ld      bc, 0
    rra
    jr      nc, PLY_AKG_CHANNEL1_GLIDEDOWNCHECK
    or      a
    sbc     hl, bc
    jr      nc, PLY_AKG_CHANNEL1_AFTERARPEGGIOPITCHVARIABLES
    jr      PLY_AKG_CHANNEL1_GLIDEOVER
PLY_AKG_CHANNEL1_GLIDEDOWNCHECK:
    sbc     hl, bc
    jr      c, PLY_AKG_CHANNEL1_AFTERARPEGGIOPITCHVARIABLES
PLY_AKG_CHANNEL1_GLIDEOVER:
    ld      l, c
    ld      h, b
    pop     bc
    or      a
    sbc     hl, bc
    ld      (PLY_AKG_CHANNEL1_PITCHTABLE_END+1), hl
    ld      a, 183
    ld      (PLY_AKG_CHANNEL1_ISPITCH), a
    jr      PLY_AKG_CHANNEL1_GLIDE_END
PLY_AKG_CHANNEL1_ARPEGGIOTABLESPEED:
    db      0
PLY_AKG_CHANNEL1_ARPEGGIOBASESPEED:
    db      0
PLY_AKG_CHANNEL1_ARPEGGIOTABLEBASE:
    db      0
    db      0
PLY_AKG_CHANNEL1_PITCHTABLESPEED:
    db      0
PLY_AKG_CHANNEL1_PITCHBASESPEED:
    db      0
PLY_AKG_CHANNEL1_PITCHTABLEBASE:
    db      0
    db      0

PLY_AKG_CHANNEL1_AFTERARPEGGIOPITCHVARIABLES:

PLY_AKG_CHANNEL1_GLIDE_BEFOREEND:
PLY_AKG_CHANNEL1_GLIDE_SAVEHL:
    ld      hl, 0
PLY_AKG_CHANNEL1_GLIDE_END:
    db      221
    db      77
PLY_AKG_CHANNEL1_PITCH_END:
    add     hl, de
    ld      (PLY_AKG_CHANNEL1_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS+1), hl
    ld      a, c
    ld      (PLY_AKG_CHANNEL1_GENERATEDCURRENTARPNOTE+1), a
    defc    PLY_AKG_CHANNEL2_INVERTEDVOLUMEINTEGER=ASMPC+2
PLY_AKG_CHANNEL2_INVERTEDVOLUMEINTEGERANDDECIMAL:
    ld      hl, 0
PLY_AKG_CHANNEL2_ISVOLUMESLIDE:
    or      a
    jr      nc, PLY_AKG_CHANNEL2_VOLUMESLIDE_END
PLY_AKG_CHANNEL2_VOLUMESLIDEVALUE:
    ld      de, 0
    add     hl, de
    bit     7, h
    jr      z, PLY_AKG_CHANNEL2_VOLUMENOTOVERFLOW
    ld      h, 0
    jr      PLY_AKG_CHANNEL2_VOLUMESETAGAIN
PLY_AKG_CHANNEL2_VOLUMENOTOVERFLOW:
    ld      a, h
    cp      16
    jr      c, PLY_AKG_CHANNEL2_VOLUMESETAGAIN
    ld      h, 15
PLY_AKG_CHANNEL2_VOLUMESETAGAIN:
    ld      (PLY_AKG_CHANNEL2_INVERTEDVOLUMEINTEGERANDDECIMAL+1), hl
PLY_AKG_CHANNEL2_VOLUMESLIDE_END:
    ld      a, h
    ld      (PLY_AKG_CHANNEL2_GENERATEDCURRENTINVERTEDVOLUME+1), a
    ld      c, 0
PLY_AKG_CHANNEL2_ISARPEGGIOTABLE:
    or      a
    jr      nc, PLY_AKG_CHANNEL2_ARPEGGIOTABLE_END
PLY_AKG_CHANNEL2_ARPEGGIOTABLE:
    ld      hl, 0
    ld      a, (hl)
    cp      128
    jr      nz, PLY_AKG_CHANNEL2_ARPEGGIOTABLE_AFTERLOOPTEST
    inc     hl
    ld      a, (hl)
    inc     hl
    ld      h, (hl)
    ld      l, a
    ld      a, (hl)
PLY_AKG_CHANNEL2_ARPEGGIOTABLE_AFTERLOOPTEST:
    ld      c, a
    ld      a, (PLY_AKG_CHANNEL2_ARPEGGIOTABLESPEED)
    ld      d, a
PLY_AKG_CHANNEL2_ARPEGGIOTABLECURRENTSTEP:
    ld      a, 0
    inc     a
    cp      d
    jr      c, PLY_AKG_CHANNEL2_ARPEGGIOTABLE_BEFOREEND_SAVESTEP
    inc     hl
    ld      (PLY_AKG_CHANNEL2_ARPEGGIOTABLE+1), hl
    xor     a
PLY_AKG_CHANNEL2_ARPEGGIOTABLE_BEFOREEND_SAVESTEP:
    ld      (PLY_AKG_CHANNEL2_ARPEGGIOTABLECURRENTSTEP+1), a
PLY_AKG_CHANNEL2_ARPEGGIOTABLE_END:
    ld      de, 0
PLY_AKG_CHANNEL2_ISPITCHTABLE:
    or      a
    jr      nc, PLY_AKG_CHANNEL2_PITCHTABLE_END
PLY_AKG_CHANNEL2_PITCHTABLE:
    ld      sp, 0
    pop     de
    pop     hl
    ld      a, (PLY_AKG_CHANNEL2_PITCHTABLESPEED)
    ld      b, a
PLY_AKG_CHANNEL2_PITCHTABLECURRENTSTEP:
    ld      a, 0
    inc     a
    cp      b
    jr      c, PLY_AKG_CHANNEL2_PITCHTABLE_BEFOREEND_SAVESTEP
    ld      (PLY_AKG_CHANNEL2_PITCHTABLE+1), hl
    xor     a
PLY_AKG_CHANNEL2_PITCHTABLE_BEFOREEND_SAVESTEP:
    ld      (PLY_AKG_CHANNEL2_PITCHTABLECURRENTSTEP+1), a

PLY_AKG_CHANNEL2_PITCHTABLE_END:
PLY_AKG_CHANNEL2_PITCH:
    ld      hl, 0
PLY_AKG_CHANNEL2_ISPITCH:
    or      a
    jr      nc, PLY_AKG_CHANNEL2_PITCH_END
    db      221
    db      105
PLY_AKG_CHANNEL2_PITCHTRACK:
    ld      bc, 0
    or      a
PLY_AKG_CHANNEL2_PITCHTRACKADDORSBC_16BITS:
    nop
    add     hl, bc
PLY_AKG_CHANNEL2_PITCHTRACKDECIMALCOUNTER:
    ld      a, 0
    defc    PLY_AKG_CHANNEL2_PITCHTRACKDECIMALVALUE=ASMPC+1
PLY_AKG_CHANNEL2_PITCHTRACKDECIMALINSTR:
    add     a, 0
    ld      (PLY_AKG_CHANNEL2_PITCHTRACKDECIMALCOUNTER+1), a
    jr      nc, PLY_AKG_CHANNEL2_PITCHNOCARRY
PLY_AKG_CHANNEL2_PITCHTRACKINTEGERADDORSUB:
    inc     hl
PLY_AKG_CHANNEL2_PITCHNOCARRY:
    ld      (PLY_AKG_CHANNEL2_PITCHTABLE_END+1), hl

PLY_AKG_CHANNEL2_SOUNDSTREAM_RELATIVEMODIFIERADDRESS:
PLY_AKG_CHANNEL2_GLIDEDIRECTION:
    ld      a, 0
    or      a
    jr      z, PLY_AKG_CHANNEL2_GLIDE_END
    ld      (PLY_AKG_CHANNEL2_AFTERARPEGGIOPITCHVARIABLES+1), hl
    ld      c, l
    ld      b, h
    ex      af, af'
    ld      a, (PLY_AKG_CHANNEL2_TRACKNOTE+1)
    add     a, a
    ld      l, a
    ex      af, af'
    ld      h, 0
    ld      sp, PLY_AKG_PERIODTABLE
    add     hl, sp
    ld      sp, hl
    pop     hl
    dec     sp
    dec     sp
    add     hl, bc
PLY_AKG_CHANNEL2_GLIDETOREACH:
    ld      bc, 0
    rra
    jr      nc, PLY_AKG_CHANNEL2_GLIDEDOWNCHECK
    or      a
    sbc     hl, bc
    jr      nc, PLY_AKG_CHANNEL2_AFTERARPEGGIOPITCHVARIABLES
    jr      PLY_AKG_CHANNEL2_GLIDEOVER
PLY_AKG_CHANNEL2_GLIDEDOWNCHECK:
    sbc     hl, bc
    jr      c, PLY_AKG_CHANNEL2_AFTERARPEGGIOPITCHVARIABLES
PLY_AKG_CHANNEL2_GLIDEOVER:
    ld      l, c
    ld      h, b
    pop     bc
    or      a
    sbc     hl, bc
    ld      (PLY_AKG_CHANNEL2_PITCHTABLE_END+1), hl
    ld      a, 183
    ld      (PLY_AKG_CHANNEL2_ISPITCH), a
    jr      PLY_AKG_CHANNEL2_GLIDE_END
PLY_AKG_CHANNEL2_ARPEGGIOTABLESPEED:
    db      0
PLY_AKG_CHANNEL2_ARPEGGIOBASESPEED:
    db      0
PLY_AKG_CHANNEL2_ARPEGGIOTABLEBASE:
    db      0
    db      0
PLY_AKG_CHANNEL2_PITCHTABLESPEED:
    db      0
PLY_AKG_CHANNEL2_PITCHBASESPEED:
    db      0
PLY_AKG_CHANNEL2_PITCHTABLEBASE:
    db      0
    db      0

PLY_AKG_CHANNEL2_AFTERARPEGGIOPITCHVARIABLES:

PLY_AKG_CHANNEL2_GLIDE_BEFOREEND:
PLY_AKG_CHANNEL2_GLIDE_SAVEHL:
    ld      hl, 0
PLY_AKG_CHANNEL2_GLIDE_END:
    db      221
    db      77
PLY_AKG_CHANNEL2_PITCH_END:
    add     hl, de
    ld      (PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS+1), hl
    ld      a, c
    ld      (PLY_AKG_CHANNEL2_GENERATEDCURRENTARPNOTE+1), a
    defc    PLY_AKG_CHANNEL3_INVERTEDVOLUMEINTEGER=ASMPC+2
PLY_AKG_CHANNEL3_INVERTEDVOLUMEINTEGERANDDECIMAL:
    ld      hl, 0
PLY_AKG_CHANNEL3_ISVOLUMESLIDE:
    or      a
    jr      nc, PLY_AKG_CHANNEL3_VOLUMESLIDE_END
PLY_AKG_CHANNEL3_VOLUMESLIDEVALUE:
    ld      de, 0
    add     hl, de
    bit     7, h
    jr      z, PLY_AKG_CHANNEL3_VOLUMENOTOVERFLOW
    ld      h, 0
    jr      PLY_AKG_CHANNEL3_VOLUMESETAGAIN
PLY_AKG_CHANNEL3_VOLUMENOTOVERFLOW:
    ld      a, h
    cp      16
    jr      c, PLY_AKG_CHANNEL3_VOLUMESETAGAIN
    ld      h, 15
PLY_AKG_CHANNEL3_VOLUMESETAGAIN:
    ld      (PLY_AKG_CHANNEL3_INVERTEDVOLUMEINTEGERANDDECIMAL+1), hl
PLY_AKG_CHANNEL3_VOLUMESLIDE_END:
    ld      a, h
    ld      (PLY_AKG_CHANNEL3_GENERATEDCURRENTINVERTEDVOLUME+1), a
    ld      c, 0
PLY_AKG_CHANNEL3_ISARPEGGIOTABLE:
    or      a
    jr      nc, PLY_AKG_CHANNEL3_ARPEGGIOTABLE_END
PLY_AKG_CHANNEL3_ARPEGGIOTABLE:
    ld      hl, 0
    ld      a, (hl)
    cp      128
    jr      nz, PLY_AKG_CHANNEL3_ARPEGGIOTABLE_AFTERLOOPTEST
    inc     hl
    ld      a, (hl)
    inc     hl
    ld      h, (hl)
    ld      l, a
    ld      a, (hl)
PLY_AKG_CHANNEL3_ARPEGGIOTABLE_AFTERLOOPTEST:
    ld      c, a
    ld      a, (PLY_AKG_CHANNEL3_ARPEGGIOTABLESPEED)
    ld      d, a
PLY_AKG_CHANNEL3_ARPEGGIOTABLECURRENTSTEP:
    ld      a, 0
    inc     a
    cp      d
    jr      c, PLY_AKG_CHANNEL3_ARPEGGIOTABLE_BEFOREEND_SAVESTEP
    inc     hl
    ld      (PLY_AKG_CHANNEL3_ARPEGGIOTABLE+1), hl
    xor     a
PLY_AKG_CHANNEL3_ARPEGGIOTABLE_BEFOREEND_SAVESTEP:
    ld      (PLY_AKG_CHANNEL3_ARPEGGIOTABLECURRENTSTEP+1), a
PLY_AKG_CHANNEL3_ARPEGGIOTABLE_END:
    ld      de, 0
PLY_AKG_CHANNEL3_ISPITCHTABLE:
    or      a
    jr      nc, PLY_AKG_CHANNEL3_PITCHTABLE_END
PLY_AKG_CHANNEL3_PITCHTABLE:
    ld      sp, 0
    pop     de
    pop     hl
    ld      a, (PLY_AKG_CHANNEL3_PITCHTABLESPEED)
    ld      b, a
PLY_AKG_CHANNEL3_PITCHTABLECURRENTSTEP:
    ld      a, 0
    inc     a
    cp      b
    jr      c, PLY_AKG_CHANNEL3_PITCHTABLE_BEFOREEND_SAVESTEP
    ld      (PLY_AKG_CHANNEL3_PITCHTABLE+1), hl
    xor     a
PLY_AKG_CHANNEL3_PITCHTABLE_BEFOREEND_SAVESTEP:
    ld      (PLY_AKG_CHANNEL3_PITCHTABLECURRENTSTEP+1), a

PLY_AKG_CHANNEL3_PITCHTABLE_END:
PLY_AKG_CHANNEL3_PITCH:
    ld      hl, 0
PLY_AKG_CHANNEL3_ISPITCH:
    or      a
    jr      nc, PLY_AKG_CHANNEL3_PITCH_END
    db      221
    db      105
PLY_AKG_CHANNEL3_PITCHTRACK:
    ld      bc, 0
    or      a
PLY_AKG_CHANNEL3_PITCHTRACKADDORSBC_16BITS:
    nop
    add     hl, bc
PLY_AKG_CHANNEL3_PITCHTRACKDECIMALCOUNTER:
    ld      a, 0
    defc    PLY_AKG_CHANNEL3_PITCHTRACKDECIMALVALUE=ASMPC+1
PLY_AKG_CHANNEL3_PITCHTRACKDECIMALINSTR:
    add     a, 0
    ld      (PLY_AKG_CHANNEL3_PITCHTRACKDECIMALCOUNTER+1), a
    jr      nc, PLY_AKG_CHANNEL3_PITCHNOCARRY
PLY_AKG_CHANNEL3_PITCHTRACKINTEGERADDORSUB:
    inc     hl
PLY_AKG_CHANNEL3_PITCHNOCARRY:
    ld      (PLY_AKG_CHANNEL3_PITCHTABLE_END+1), hl

PLY_AKG_CHANNEL3_SOUNDSTREAM_RELATIVEMODIFIERADDRESS:
PLY_AKG_CHANNEL3_GLIDEDIRECTION:
    ld      a, 0
    or      a
    jr      z, PLY_AKG_CHANNEL3_GLIDE_END
    ld      (PLY_AKG_CHANNEL3_AFTERARPEGGIOPITCHVARIABLES+1), hl
    ld      c, l
    ld      b, h
    ex      af, af'
    ld      a, (PLY_AKG_CHANNEL3_TRACKNOTE+1)
    add     a, a
    ld      l, a
    ex      af, af'
    ld      h, 0
    ld      sp, PLY_AKG_PERIODTABLE
    add     hl, sp
    ld      sp, hl
    pop     hl
    dec     sp
    dec     sp
    add     hl, bc
PLY_AKG_CHANNEL3_GLIDETOREACH:
    ld      bc, 0
    rra
    jr      nc, PLY_AKG_CHANNEL3_GLIDEDOWNCHECK
    or      a
    sbc     hl, bc
    jr      nc, PLY_AKG_CHANNEL3_AFTERARPEGGIOPITCHVARIABLES
    jr      PLY_AKG_CHANNEL3_GLIDEOVER
PLY_AKG_CHANNEL3_GLIDEDOWNCHECK:
    sbc     hl, bc
    jr      c, PLY_AKG_CHANNEL3_AFTERARPEGGIOPITCHVARIABLES
PLY_AKG_CHANNEL3_GLIDEOVER:
    ld      l, c
    ld      h, b
    pop     bc
    or      a
    sbc     hl, bc
    ld      (PLY_AKG_CHANNEL3_PITCHTABLE_END+1), hl
    ld      a, 183
    ld      (PLY_AKG_CHANNEL3_ISPITCH), a
    jr      PLY_AKG_CHANNEL3_GLIDE_END
PLY_AKG_CHANNEL3_ARPEGGIOTABLESPEED:
    db      0
PLY_AKG_CHANNEL3_ARPEGGIOBASESPEED:
    db      0
PLY_AKG_CHANNEL3_ARPEGGIOTABLEBASE:
    db      0
    db      0
PLY_AKG_CHANNEL3_PITCHTABLESPEED:
    db      0
PLY_AKG_CHANNEL3_PITCHBASESPEED:
    db      0
PLY_AKG_CHANNEL3_PITCHTABLEBASE:
    db      0
    db      0

PLY_AKG_CHANNEL3_AFTERARPEGGIOPITCHVARIABLES:

PLY_AKG_CHANNEL3_GLIDE_BEFOREEND:
PLY_AKG_CHANNEL3_GLIDE_SAVEHL:
    ld      hl, 0
PLY_AKG_CHANNEL3_GLIDE_END:
    db      221
    db      77
PLY_AKG_CHANNEL3_PITCH_END:
    add     hl, de
    ld      (PLY_AKG_CHANNEL3_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS+1), hl
    ld      a, c
    ld      (PLY_AKG_CHANNEL3_GENERATEDCURRENTARPNOTE+1), a
    ld      sp, (PLY_AKG_PSGREG13_END+1)

PLY_AKG_CHANNEL1_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS:
PLY_AKG_CHANNEL1_GENERATEDCURRENTPITCH:
    ld      hl, 0
PLY_AKG_CHANNEL1_TRACKNOTE:
    ld      a, 0
PLY_AKG_CHANNEL1_GENERATEDCURRENTARPNOTE:
    add     a, 0
    ld      e, a
    ld      d, 0
    exx
PLY_AKG_CHANNEL1_INSTRUMENTSTEP:
    db      253
    db      46
    db      0
PLY_AKG_CHANNEL1_PTINSTRUMENT:
    ld      hl, 0
PLY_AKG_CHANNEL1_GENERATEDCURRENTINVERTEDVOLUME:
    ld      de, 57359
    call    PLY_AKG_READINSTRUMENTCELL
    db      253
    db      125
    inc     a
PLY_AKG_CHANNEL1_INSTRUMENTSPEED:
    cp      0
    jr      c, PLY_AKG_CHANNEL1_SETINSTRUMENTSTEP
    ld      (PLY_AKG_CHANNEL1_PTINSTRUMENT+1), hl
    xor     a
PLY_AKG_CHANNEL1_SETINSTRUMENTSTEP:
    ld      (PLY_AKG_CHANNEL1_INSTRUMENTSTEP+2), a
    ld      a, e
    ld      (PLY_AKG_PSGREG8), a
    rr      d
    exx
    ld      (PLY_AKG_PSGREG01_INSTR+1), hl

PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS:
PLY_AKG_CHANNEL2_GENERATEDCURRENTPITCH:
    ld      hl, 0
PLY_AKG_CHANNEL2_TRACKNOTE:
    ld      a, 0
PLY_AKG_CHANNEL2_GENERATEDCURRENTARPNOTE:
    add     a, 0
    ld      e, a
    ld      d, 0
    exx
PLY_AKG_CHANNEL2_INSTRUMENTSTEP:
    db      253
    db      46
    db      0
PLY_AKG_CHANNEL2_PTINSTRUMENT:
    ld      hl, 0
PLY_AKG_CHANNEL2_GENERATEDCURRENTINVERTEDVOLUME:
    ld      e, 15
    nop
    call    PLY_AKG_READINSTRUMENTCELL
    db      253
    db      125
    inc     a
PLY_AKG_CHANNEL2_INSTRUMENTSPEED:
    cp      0
    jr      c, PLY_AKG_CHANNEL2_SETINSTRUMENTSTEP
    ld      (PLY_AKG_CHANNEL2_PTINSTRUMENT+1), hl
    xor     a
PLY_AKG_CHANNEL2_SETINSTRUMENTSTEP:
    ld      (PLY_AKG_CHANNEL2_INSTRUMENTSTEP+2), a
    ld      a, e
    ld      (PLY_AKG_PSGREG9), a
    rr      d
    exx
    ld      (PLY_AKG_PSGREG23_INSTR+1), hl

PLY_AKG_CHANNEL3_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS:
PLY_AKG_CHANNEL3_GENERATEDCURRENTPITCH:
    ld      hl, 0
PLY_AKG_CHANNEL3_TRACKNOTE:
    ld      a, 0
PLY_AKG_CHANNEL3_GENERATEDCURRENTARPNOTE:
    add     a, 0
    ld      e, a
    ld      d, 0
    exx
PLY_AKG_CHANNEL3_INSTRUMENTSTEP:
    db      253
    db      46
    db      0
PLY_AKG_CHANNEL3_PTINSTRUMENT:
    ld      hl, 0
PLY_AKG_CHANNEL3_GENERATEDCURRENTINVERTEDVOLUME:
    ld      e, 15
    nop
    call    PLY_AKG_READINSTRUMENTCELL
    db      253
    db      125
    inc     a
PLY_AKG_CHANNEL3_INSTRUMENTSPEED:
    cp      0
    jr      c, PLY_AKG_CHANNEL3_SETINSTRUMENTSTEP
    ld      (PLY_AKG_CHANNEL3_PTINSTRUMENT+1), hl
    xor     a
PLY_AKG_CHANNEL3_SETINSTRUMENTSTEP:
    ld      (PLY_AKG_CHANNEL3_INSTRUMENTSTEP+2), a
    ld      a, e
    ld      (PLY_AKG_PSGREG10), a
    ld      a, d
    exx
    ld      (PLY_AKG_PSGREG45_INSTR+1), hl
    call    PLY_AKG_PLAYSOUNDEFFECTSSTREAM
PLY_AKG_SENDPSGREGISTERS:
    ex      af, af'
    ld      de, 49151
    ld      bc, 65533
    ld      a, 1
PLY_AKG_PSGREG01_INSTR:
    ld      hl, 0
    db      237
    db      113
    ld      b, d
    out     (c), l
    ld      b, e
    out     (c), a
    ld      b, d
    out     (c), h
    ld      b, e
PLY_AKG_PSGREG23_INSTR:
    ld      hl, 0
    inc     a
    out     (c), a
    ld      b, d
    out     (c), l
    ld      b, e
    inc     a
    out     (c), a
    ld      b, d
    out     (c), h
    ld      b, e
PLY_AKG_PSGREG45_INSTR:
    ld      hl, 0
    inc     a
    out     (c), a
    ld      b, d
    out     (c), l
    ld      b, e
    inc     a
    out     (c), a
    ld      b, d
    out     (c), h
    ld      b, e
    defc    PLY_AKG_PSGREG6=ASMPC+1
    defc    PLY_AKG_PSGREG8=ASMPC+2
PLY_AKG_PSGREG6_8_INSTR:
    ld      hl, 0
    inc     a
    out     (c), a
    ld      b, d
    out     (c), l
    ld      b, e
    inc     a
    out     (c), a
    ld      b, d
    ex      af, af'
    out     (c), a
    ex      af, af'
    ld      b, e
    inc     a
    out     (c), a
    ld      b, d
    out     (c), h
    ld      b, e
    defc    PLY_AKG_PSGREG9=ASMPC+1
    defc    PLY_AKG_PSGREG10=ASMPC+2
PLY_AKG_PSGREG9_10_INSTR:
    ld      hl, 0
    inc     a
    out     (c), a
    ld      b, d
    out     (c), l
    ld      b, e
    inc     a
    out     (c), a
    ld      b, d
    out     (c), h
    ld      b, e
PLY_AKG_PSGHARDWAREPERIOD_INSTR:
    ld      hl, 0
    inc     a
    out     (c), a
    ld      b, d
    out     (c), l
    ld      b, e
    inc     a
    out     (c), a
    ld      b, d
    out     (c), h
    ld      b, e
    inc     a
    out     (c), a
PLY_AKG_PSGREG13_OLDVALUE:
    ld      a, 255
PLY_AKG_RETRIG:
    or      0
PLY_AKG_PSGREG13_INSTR:
    ld      l, 0
    cp      l
    jr      z, PLY_AKG_PSGREG13_END
    ld      a, l
    ld      (PLY_AKG_PSGREG13_OLDVALUE+1), a
    ld      b, d
    out     (c), a
    xor     a
    ld      (PLY_AKG_RETRIG+1), a

PLY_AKG_PSGREG13_END:
PLY_AKG_SAVESP:
    ld      sp, 0
    ret
PLY_AKG_CHANNEL1_MAYBEEFFECTS:
    ld      (PLY_AKG_EVENTTRACK_END+1), a
    bit     6, c
    jp      z, PLY_AKG_CHANNEL1_BEFOREEND_STORECELLPOINTER
PLY_AKG_CHANNEL1_READEFFECTS:
    ld      iy, PLY_AKG_CHANNEL1_SOUNDSTREAM_RELATIVEMODIFIERADDRESS
    ld      ix, PLY_AKG_CHANNEL1_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS
    ld      de, PLY_AKG_CHANNEL1_BEFOREEND_STORECELLPOINTER
    jr      PLY_AKG_CHANNEL3_READEFFECTSEND

PLY_AKG_CHANNEL1_READEFFECTSEND:
PLY_AKG_CHANNEL2_MAYBEEFFECTS:
    ld      (PLY_AKG_CHANNEL1_READCELLEND+1), a
    bit     6, c
    jp      z, PLY_AKG_CHANNEL2_BEFOREEND_STORECELLPOINTER
PLY_AKG_CHANNEL2_READEFFECTS:
    ld      iy, PLY_AKG_CHANNEL2_SOUNDSTREAM_RELATIVEMODIFIERADDRESS
    ld      ix, PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS
    ld      de, PLY_AKG_CHANNEL2_BEFOREEND_STORECELLPOINTER
    jr      PLY_AKG_CHANNEL3_READEFFECTSEND

PLY_AKG_CHANNEL2_READEFFECTSEND:
PLY_AKG_CHANNEL3_MAYBEEFFECTS:
    ld      (PLY_AKG_CHANNEL2_READCELLEND+1), a
    bit     6, c
    jp      z, PLY_AKG_CHANNEL3_BEFOREEND_STORECELLPOINTER
PLY_AKG_CHANNEL3_READEFFECTS:
    ld      iy, PLY_AKG_CHANNEL3_SOUNDSTREAM_RELATIVEMODIFIERADDRESS
    ld      ix, PLY_AKG_CHANNEL3_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS
    ld      de, PLY_AKG_CHANNEL3_BEFOREEND_STORECELLPOINTER

PLY_AKG_CHANNEL3_READEFFECTSEND:
PLY_AKG_CHANNEL_READEFFECTS:
    ld      (PLY_AKG_CHANNEL_READEFFECTS_ENDJUMP+1), de
    ex      de, hl
    ld      a, (de)
    inc     de
    sla     a
    jr      c, PLY_AKG_CHANNEL_READEFFECTS_RELATIVEADDRESS
    exx
    ld      l, a
    ld      h, 0
PLY_AKG_CHANNEL_READEFFECTS_EFFECTBLOCKS1:
    ld      de, 0
    add     hl, de
    ld      e, (hl)
    inc     hl
    ld      d, (hl)
PLY_AKG_CHANNEL_RE_EFFECTADDRESSKNOWN:
    ld      a, (de)
    inc     de
    ld      (PLY_AKG_CHANNEL_RE_EFFECTRETURN+1), a
    and     254
    ld      l, a
    ld      h, 0
    ld      sp, PLY_AKG_EFFECTTABLE
    add     hl, sp
    ld      sp, hl
    ret

PLY_AKG_CHANNEL_RE_EFFECTRETURN:
PLY_AKG_CHANNEL_RE_READNEXTEFFECTINBLOCK:
    ld      a, 0
    rra
    jr      c, PLY_AKG_CHANNEL_RE_EFFECTADDRESSKNOWN
    exx
    ex      de, hl
PLY_AKG_CHANNEL_READEFFECTS_ENDJUMP:
    jp      0
PLY_AKG_CHANNEL_READEFFECTS_RELATIVEADDRESS:
    srl     a
    exx
    ld      h, a
    exx
    ld      a, (de)
    inc     de
    exx
    ld      l, a
PLY_AKG_CHANNEL_READEFFECTS_EFFECTBLOCKS2:
    ld      de, 0
    add     hl, de
    jr      PLY_AKG_CHANNEL_RE_EFFECTADDRESSKNOWN
PLY_AKG_READINSTRUMENTCELL:
    ld      a, (hl)
    inc     hl
    ld      b, a
    rra
    jp      c, PLY_AKG_S_OR_H_OR_SAH_OR_ENDWITHLOOP
    rra
    jr      c, PLY_AKG_STH_OR_ENDWITHOUTLOOP
    rra
    jr      c, PLY_AKG_HARDTOSOFT
PLY_AKG_NOSOFTNOHARD:
    and     15
    sub     e
    jr      nc, PLY_AKG_NOSOFTNOHARD+6
    xor     a
    ld      e, a
    rl      b
    jr      nc, PLY_AKG_NSNH_NONOISE
    ld      a, (hl)
    inc     hl
    ld      (PLY_AKG_PSGREG6), a
    set     2, d
    res     5, d
    ret
PLY_AKG_NSNH_NONOISE:
    set     2, d
    ret
PLY_AKG_SOFT:
    and     15
    sub     e
    jr      nc, PLY_AKG_SOFTONLY_HARDONLY_TESTSIMPLE_COMMON-1
    xor     a
    ld      e, a
PLY_AKG_SOFTONLY_HARDONLY_TESTSIMPLE_COMMON:
    rl      b
    jr      nc, PLY_AKG_S_NOTSIMPLE
    ld      c, 0
    jr      PLY_AKG_S_AFTERSIMPLETEST
PLY_AKG_S_NOTSIMPLE:
    ld      b, (hl)
    ld      c, b
    inc     hl
PLY_AKG_S_AFTERSIMPLETEST:
    call    PLY_AKG_S_OR_H_CHECKIFSIMPLEFIRST_CALCULATEPERIOD
    ld      a, c
    and     31
    ret     z
    ld      (PLY_AKG_PSGREG6), a
    res     5, d
    ret
PLY_AKG_HARDTOSOFT:
    call    PLY_AKG_STOH_HTOS_SANDH_COMMON
    ld      (PLY_AKG_HS_JUMPRATIO+1), a
    ld      a, b
    exx
    ld      (PLY_AKG_PSGHARDWAREPERIOD_INSTR+1), hl
PLY_AKG_HS_JUMPRATIO:
    jr      PLY_AKG_HS_JUMPRATIO+2
    sla     l
    rl      h
    sla     l
    rl      h
    sla     l
    rl      h
    sla     l
    rl      h
    sla     l
    rl      h
    sla     l
    rl      h
    sla     l
    rl      h
    rla
    jr      nc, PLY_AKG_SH_NOSOFTWAREPITCHSHIFT
    exx
    ld      a, (hl)
    inc     hl
    exx
    add     a, l
    ld      l, a
    exx
    ld      a, (hl)
    inc     hl
    exx
    adc     a, h
    ld      h, a
PLY_AKG_SH_NOSOFTWAREPITCHSHIFT:
    exx
    ret

PLY_AKG_ENDWITHOUTLOOP:
PLY_AKG_EMPTYINSTRUMENTDATAPT:
    ld      hl, 0
    inc     hl
    xor     a
    ld      b, a
    jr      PLY_AKG_NOSOFTNOHARD
PLY_AKG_STH_OR_ENDWITHOUTLOOP:
    rra
    jr      c, PLY_AKG_ENDWITHOUTLOOP
    call    PLY_AKG_STOH_HTOS_SANDH_COMMON
    ld      (PLY_AKG_SH_JUMPRATIO+1), a
    ld      a, b
    exx
    ld      e, l
    ld      d, h
PLY_AKG_SH_JUMPRATIO:
    jr      PLY_AKG_SH_JUMPRATIO+2
    srl     h
    rr      l
    srl     h
    rr      l
    srl     h
    rr      l
    srl     h
    rr      l
    srl     h
    rr      l
    srl     h
    rr      l
    srl     h
    rr      l
    jr      nc, PLY_AKG_SH_JUMPRATIOEND
    inc     hl
PLY_AKG_SH_JUMPRATIOEND:
    rla
    jr      nc, PLY_AKG_SH_NOHARDWAREPITCHSHIFT
    exx
    ld      a, (hl)
    inc     hl
    exx
    add     a, l
    ld      l, a
    exx
    ld      a, (hl)
    inc     hl
    exx
    adc     a, h
    ld      h, a
PLY_AKG_SH_NOHARDWAREPITCHSHIFT:
    ld      (PLY_AKG_PSGHARDWAREPERIOD_INSTR+1), hl
    ex      de, hl
    exx
    ret
PLY_AKG_S_OR_H_OR_SAH_OR_ENDWITHLOOP:
    rra
    jr      c, PLY_AKG_H_OR_ENDWITHLOOP
    rra
    jp      nc, PLY_AKG_SOFT
    exx
    push    hl
    push    de
    exx
    call    PLY_AKG_STOH_HTOS_SANDH_COMMON
    exx
    ld      (PLY_AKG_PSGHARDWAREPERIOD_INSTR+1), hl
    pop     de
    pop     hl
    exx
    rl      b
    jp      PLY_AKG_S_OR_H_CHECKIFSIMPLEFIRST_CALCULATEPERIOD
PLY_AKG_H_OR_ENDWITHLOOP:
    rra
    jr      c, PLY_AKG_ENDWITHLOOP
    ld      e, 16
    rra
    jr      nc, PLY_AKG_H_AFTERRETRIG
    ld      c, a
    db      253
    db      125
    or      a
    jr      nz, PLY_AKG_H_RETRIGEND
    ld      a, e
    ld      (PLY_AKG_RETRIG+1), a
PLY_AKG_H_RETRIGEND:
    ld      a, c
PLY_AKG_H_AFTERRETRIG:
    and     7
    add     a, 8
    ld      (PLY_AKG_PSGREG13_INSTR+1), a
    call    PLY_AKG_SOFTONLY_HARDONLY_TESTSIMPLE_COMMON
    exx
    ld      (PLY_AKG_PSGHARDWAREPERIOD_INSTR+1), hl
    exx
    set     2, d
    ret
PLY_AKG_ENDWITHLOOP:
    ld      a, (hl)
    inc     hl
    ld      h, (hl)
    ld      l, a
    jp      PLY_AKG_READINSTRUMENTCELL
PLY_AKG_S_OR_H_CHECKIFSIMPLEFIRST_CALCULATEPERIOD:
    jr      nc, PLY_AKG_S_OR_H_NEXTBYTE
    exx
    ex      de, hl
    add     hl, hl
    ld      bc, PLY_AKG_PERIODTABLE
    add     hl, bc
    ld      a, (hl)
    inc     hl
    ld      h, (hl)
    ld      l, a
    add     hl, de
    exx
    rl      b
    rl      b
    rl      b
    ret
PLY_AKG_S_OR_H_NEXTBYTE:
    rl      b
    jr      c, PLY_AKG_S_OR_H_FORCEDPERIOD
    rl      b
    jr      nc, PLY_AKG_S_OR_H_AFTERARPEGGIO
    ld      a, (hl)
    inc     hl
    exx
    add     a, e
    ld      e, a
    exx
PLY_AKG_S_OR_H_AFTERARPEGGIO:
    rl      b
    jr      nc, PLY_AKG_S_OR_H_AFTERPITCH
    ld      a, (hl)
    inc     hl
    exx
    add     a, l
    ld      l, a
    exx
    ld      a, (hl)
    inc     hl
    exx
    adc     a, h
    ld      h, a
    exx
PLY_AKG_S_OR_H_AFTERPITCH:
    exx
    ex      de, hl
    add     hl, hl
    ld      bc, PLY_AKG_PERIODTABLE
    add     hl, bc
    ld      a, (hl)
    inc     hl
    ld      h, (hl)
    ld      l, a
    add     hl, de
    exx
    ret
PLY_AKG_S_OR_H_FORCEDPERIOD:
    ld      a, (hl)
    inc     hl
    exx
    ld      l, a
    exx
    ld      a, (hl)
    inc     hl
    exx
    ld      h, a
    exx
    rl      b
    rl      b
    ret
PLY_AKG_STOH_HTOS_SANDH_COMMON:
    ld      e, 16
    rra
    jr      nc, PLY_AKG_SHOHS_AFTERRETRIG
    ld      c, a
    db      253
    db      125
    or      a
    jr      nz, PLY_AKG_SHOHS_RETRIGEND
    dec     a
    ld      (PLY_AKG_RETRIG+1), a
PLY_AKG_SHOHS_RETRIGEND:
    ld      a, c
PLY_AKG_SHOHS_AFTERRETRIG:
    and     7
    add     a, 8
    ld      (PLY_AKG_PSGREG13_INSTR+1), a
    rl      b
    jr      nc, PLY_AKG_SHOHS_AFTERNOISE
    ld      a, (hl)
    inc     hl
    ld      (PLY_AKG_PSGREG6), a
    res     5, d
PLY_AKG_SHOHS_AFTERNOISE:
    ld      c, (hl)
    ld      b, c
    inc     hl
    rl      b
    call    PLY_AKG_S_OR_H_CHECKIFSIMPLEFIRST_CALCULATEPERIOD
    ld      a, c
    rla
    rla
    and     28
    ret
PLY_AKG_EFFECTTABLE:
    dw      PLY_AKG_EFFECT_RESETFULLVOLUME
    dw      PLY_AKG_EFFECT_RESET
    dw      PLY_AKG_EFFECT_VOLUME
    dw      PLY_AKG_EFFECT_ARPEGGIOTABLE
    dw      PLY_AKG_EFFECT_ARPEGGIOTABLESTOP
    dw      PLY_AKG_EFFECT_PITCHTABLE
    dw      PLY_AKG_EFFECT_PITCHTABLESTOP
    dw      PLY_AKG_EFFECT_VOLUMESLIDE
    dw      PLY_AKG_EFFECT_VOLUMESLIDESTOP
    dw      PLY_AKG_EFFECT_PITCHUP
    dw      PLY_AKG_EFFECT_PITCHDOWN
    dw      PLY_AKG_EFFECT_PITCHSTOP
    dw      PLY_AKG_EFFECT_GLIDEWITHNOTE
    dw      PLY_AKG_EFFECT_GLIDE_READSPEED
    dw      PLY_AKG_EFFECT_LEGATO
    dw      PLY_AKG_EFFECT_FORCEINSTRUMENTSPEED
    dw      PLY_AKG_EFFECT_FORCEARPEGGIOSPEED
    dw      PLY_AKG_EFFECT_FORCEPITCHSPEED
PLY_AKG_EFFECT_RESETFULLVOLUME:
    xor     a
    jr      PLY_AKG_EFFECT_RESETVOLUME_AFTERREADING
PLY_AKG_EFFECT_RESET:
    ld      a, (de)
    inc     de
PLY_AKG_EFFECT_RESETVOLUME_AFTERREADING:
    ld      (iy-123), a
    xor     a
    ld      (iy-26), a
    ld      (iy-25), a
    ld      a, 183
    ld      (iy-24), a
    ld      (iy-52), a
    ld      (iy-91), a
    ld      (iy-122), a
    jp      PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_VOLUME:
    ld      a, (de)
    inc     de
    ld      (iy-123), a
    ld      (iy-122), 183
    jp      PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_ARPEGGIOTABLE:
    ld      a, (de)
    inc     de
    ld      l, a
    ld      h, 0
    add     hl, hl
PLY_AKG_ARPEGGIOSTABLE:
    ld      bc, 0
    add     hl, bc
    ld      c, (hl)
    inc     hl
    ld      b, (hl)
    inc     hl
    ld      a, (bc)
    inc     bc
    ld      (iy+61), a
    ld      (iy+62), a
    ld      (iy-87), c
    ld      (iy-86), b
    ld      (iy+63), c
    ld      (iy+64), b
    ld      (iy-91), 55
    xor     a
    ld      (iy-68), a
    jp      PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_ARPEGGIOTABLESTOP:
    ld      (iy-91), 183
    jp      PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_PITCHTABLE:
    ld      a, (de)
    inc     de
    ld      l, a
    ld      h, 0
    add     hl, hl
PLY_AKG_PITCHESTABLE:
    ld      bc, 0
    add     hl, bc
    ld      c, (hl)
    inc     hl
    ld      b, (hl)
    inc     hl
    ld      a, (bc)
    inc     bc
    ld      (iy+65), a
    ld      (iy+66), a
    ld      (iy-48), c
    ld      (iy-47), b
    ld      (iy+67), c
    ld      (iy+68), b
    ld      (iy-52), 55
    xor     a
    ld      (iy-39), a
    jp      PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_PITCHTABLESTOP:
    ld      (iy-52), 183
    jp      PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_VOLUMESLIDE:
    ld      a, (de)
    inc     de
    ld      (iy-118), a
    ld      a, (de)
    inc     de
    ld      (iy-117), a
    ld      (iy-122), 55
    jp      PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_VOLUMESLIDESTOP:
    ld      (iy-122), 183
    jp      PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_PITCHDOWN:
    ld      (iy-15), 0
    ld      (iy-14), 9
    ld      (iy-11), 198
    ld      (iy-4), 35
PLY_AKG_EFFECT_PITCHUPDOWN_COMMON:
    ld      (iy-24), 55
    ld      (iy+1), 0
    ld      a, (de)
    inc     de
    ld      (iy-10), a
    ld      a, (de)
    inc     de
    ld      (iy-18), a
    jp      PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_PITCHUP:
    ld      (iy-15), 237
    ld      (iy-14), 66
    ld      (iy-11), 214
    ld      (iy-4), 43
    jr      PLY_AKG_EFFECT_PITCHUPDOWN_COMMON
PLY_AKG_EFFECT_PITCHSTOP:
    ld      (iy-24), 183
    jp      PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_GLIDEWITHNOTE:
    ld      a, (de)
    inc     de
    ld      (PLY_AKG_EFFECT_GLIDEWITHNOTESAVEDE+1), de
    add     a, a
    ld      l, a
    ld      h, 0
    ld      bc, PLY_AKG_PERIODTABLE
    add     hl, bc
    ld      sp, hl
    pop     de
    ld      (iy+29), e
    ld      (iy+30), d
    ld      a, (ix+4)
    add     a, a
    ld      l, a
    ld      h, 0
    add     hl, bc
    ld      sp, hl
    pop     hl
    ld      c, (iy-26)
    ld      b, (iy-25)
    add     hl, bc
    or      a
    sbc     hl, de
PLY_AKG_EFFECT_GLIDEWITHNOTESAVEDE:
    ld      de, 0
    jr      c, PLY_AKG_EFFECT_GLIDE_PITCHDOWN
    ld      (iy+1), 1
    ld      (iy-15), 237
    ld      (iy-14), 66
    ld      (iy-11), 214
    ld      (iy-4), 43

PLY_AKG_EFFECT_GLIDE_READSPEED:
PLY_AKG_EFFECT_GLIDESPEED:
    ld      a, (de)
    inc     de
    ld      (iy-10), a
    ld      a, (de)
    inc     de
    ld      (iy-18), a
    ld      a, 55
    ld      (iy-24), a
    jp      PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_GLIDE_PITCHDOWN:
    ld      (iy+1), 2
    ld      (iy-15), 0
    ld      (iy-14), 9
    ld      (iy-11), 198
    ld      (iy-4), 35
    jr      PLY_AKG_EFFECT_GLIDE_READSPEED
PLY_AKG_EFFECT_LEGATO:
    ld      a, (de)
    inc     de
    ld      (ix+4), a
    ld      a, 183
    ld      (iy-24), a
    xor     a
    ld      (iy-26), a
    ld      (iy-25), a
    jp      PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_FORCEINSTRUMENTSPEED:
    ld      a, (de)
    inc     de
    ld      (ix+27), a
    jp      PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_FORCEARPEGGIOSPEED:
    ld      a, (de)
    inc     de
    ld      (iy+61), a
    jp      PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EFFECT_FORCEPITCHSPEED:
    ld      a, (de)
    inc     de
    ld      (iy+65), a
    jp      PLY_AKG_CHANNEL_RE_EFFECTRETURN
PLY_AKG_EVENT:
    db      0
PLY_AKG_PERIODTABLE:
    dw      6778
    dw      6398
    dw      6039
    dw      5700
    dw      5380
    dw      5078
    dw      4793
    dw      4524
    dw      4270
    dw      4030
    dw      3804
    dw      3591
    dw      3389
    dw      3199
    dw      3019
    dw      2850
    dw      2690
    dw      2539
    dw      2397
    dw      2262
    dw      2135
    dw      2015
    dw      1902
    dw      1795
    dw      1695
    dw      1599
    dw      1510
    dw      1425
    dw      1345
    dw      1270
    dw      1198
    dw      1131
    dw      1068
    dw      1008
    dw      951
    dw      898
    dw      847
    dw      800
    dw      755
    dw      712
    dw      673
    dw      635
    dw      599
    dw      566
    dw      534
    dw      504
    dw      476
    dw      449
    dw      424
    dw      400
    dw      377
    dw      356
    dw      336
    dw      317
    dw      300
    dw      283
    dw      267
    dw      252
    dw      238
    dw      224
    dw      212
    dw      200
    dw      189
    dw      178
    dw      168
    dw      159
    dw      150
    dw      141
    dw      133
    dw      126
    dw      119
    dw      112
    dw      106
    dw      100
    dw      94
    dw      89
    dw      84
    dw      79
    dw      75
    dw      71
    dw      67
    dw      63
    dw      59
    dw      56
    dw      53
    dw      50
    dw      47
    dw      45
    dw      42
    dw      40
    dw      37
    dw      35
    dw      33
    dw      31
    dw      30
    dw      28
    dw      26
    dw      25
    dw      24
    dw      22
    dw      21
    dw      20
    dw      19
    dw      18
    dw      17
    dw      16
    dw      15
    dw      14
    dw      13
    dw      12
    dw      12
    dw      11
    dw      11
    dw      10
    dw      9
    dw      9
    dw      8
    dw      8
    dw      7
    dw      7
    dw      7
    dw      6
    dw      6
    dw      6
    dw      5
    dw      5
    dw      5
    dw      4

