INCLUDE "hardware.inc"

SECTION "LCD utils", ROMX

; Waits for VRAM to be accessible by checking the STAT register
; @overwrites: A
; @return: Nothing
WAITVRAM::

.loop

    ld a, [rSTAT]
    and STATF_BUSY
    jr nz, .loop

    ret

; Waits for VBlank by checking the line being drawn
; @overwrites: A
; @returns: Nothing
WAITVBLANK::
    ld a, [rLY]
    cp 145
    jr nz, WAITVBLANK
    ret

; Enables the LCD display by setting the 7th bit of the LCD control register
; @overwrites: HL
; @returns: Nothing
ENABLELCD::
    ld hl, rLCDC
    set 7, [hl]
    ret

; Disables the LCD display by reseting the 7th bit of the LCD control register
; @overwrites: HL
; @returns: Nothing
DISABLELCD::
    ld hl, rLCDC
    res 7, [hl]
    ret

; Initializes the LCD with certain parameters
; @overwrites: A
; @return: Nothing
STARTLCD::

    ld a, LCDCF_ON | LCDCF_BG9800 | LCDCF_WINOFF | LCDCF_BG8800 | LCDCF_BGON
    ld [rLCDC], a
    ret

; Stops the LCD, but waits for VBlank before doing so
; @overwrites: A
; @return: Nothing
STOPLCD::

    ld a, [rLCDC]
    rlca
    ret nc

    call WAITVBLANK

    xor a
    ld [rLCDC], a

    ret