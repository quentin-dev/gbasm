INCLUDE "hardware.inc"

SECTION "game utils", ROMX

WAITVRAM::

.loop

    ld a, [rSTAT]
    and STATF_BUSY
    jr nz, .loop

    ret


WAITVBLANK::
    ld a, [rLY]
    cp 145
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

DISABLEBG::
    ld hl, rLCDC
    res 0, [hl]
    ret

SELECTDISPLAY1::
    ld hl, rLCDC
    res 4, [hl]
    res 3, [hl]
    res 5, [hl]
    ret

STARTLCD::

    ld a, LCDCF_ON | LCDCF_BG9800 |LCDCF_WINOFF | LCDCF_BG8800 | LCDCF_BGON
    ld [rLCDC], a
    ret

STOPLCD::

    ld a, [rLCDC]
    rlca
    ret nc

.wait:

    ; wait vblank
    ld a, [rLY]
    cp 145
    jr nz, .wait

    xor a
    ld [rLCDC], a

    ret