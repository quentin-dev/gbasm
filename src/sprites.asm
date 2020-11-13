INCLUDE "hardware.inc"

SECTION "sprite utils", ROMX

RESETALLOAMATTR::
        
    ld b, 160
    ld hl, _OAMRAM

.loop

    di
    call WAITVRAM    

    ld [hl], $00

    ei

    inc hl
    dec b
    jr nz, .loop

    ret