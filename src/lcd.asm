INCLUDE "hardware.inc"
INCLUDE "macros.inc"

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

.loop

    ld a, [rLY]
    cp 145
    jr nz, .loop
    
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

; Initializes the LCD with the same parameters as STARTLCD and 8 x 8 sprites enabled
; @overwrites: A
; @return: Nothing
STARTLCDWITHSPRITES::
    
    ld a, LCDCF_ON | LCDCF_BG9800 | LCDCF_WINON | LCDCF_BG8800 | LCDCF_BGON | LCDCF_OBJON | LCDCF_OBJ8 | LCDCF_WIN9C00
    ld [rLCDC], a
    ret

UPDATELCDWINDOW::

    ld hl, rWY
    ld a, [hl]

    cp WINDOW_Y_SHOWN

    ; Not equal to WINDOW_Y_SHOWN
    jr nz, .window_is_off

.window_is_on

    ld [hl], WINDOW_Y_HIDDEN

    jr .end

.window_is_off

    ld [hl], WINDOW_Y_SHOWN

.end

    ret

HIDELCDWINDOW::

    ld hl, rWY
    ld [hl], WINDOW_Y_HIDDEN

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