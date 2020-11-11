INCLUDE "hardware.inc"

SECTION "game utils", ROMX

; :: to export the function
WAITVBLANK::
    ld a, [rLY]
    cp 144
    jp nz, WAITVBLANK
    ret

LCDON::
    ld hl, rLCDC
    set 7, [hl]
    ret

LCDOFF::
    ld hl, rLCDC
    res 7, [hl]
    ret

ENABLEBG::
    ld hl, rLCDC
    set 0, [hl]
    ret

SELECTDISPLAY1::
    ld hl, rLCDC
    set 4, [hl]
    res 3, [hl]
    ret