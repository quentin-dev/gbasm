INCLUDE "hardware.inc"
INCLUDE "constants.inc"

    IF !DEF(MACROS_INC)
MACROS_INC SET 1

; ### SPRITE & PLAYER MACROS ###

; Sets a sprite's position relative to screen, (0, 0) is (8, 16) 
; @param \1: The sprite's index in OAM [0; 40]
; @param \2: The X position relative to screen [0; 160]
; @param \3: The Y position relative to screen [0; 144]
; @overwrites: HL
; @returns: Nothing
SETSPRITESCREENPOSITION: MACRO

    ; Load the exact address into HL (each OAM entry is 4 bytes long)
    ld hl, _OAMRAM + (\1 * 4)

    ; Set Y position + offset
    ld [hl], \3 + 16
    
    inc l
    ; Set X position + offset
    ld [hl], \2 + 8

ENDM

; Set the player position relative to screen (0, 0) is (8, 16)
; @param \1: the X position relative to screen
; @param \2: the Y position relative to screen
; @overwrites: HL
; @returns: Nothing
SETPLAYERSCREENPOSITION: MACRO

    SETSPRITESCREENPOSITION 0, \1, \2

ENDM

; Set the player's sprite
; @param \1: the tile index
; @overwrites: HL
; @returns: Nothing
SETPLAYERSPRITETILE: MACRO

    ld hl, _OAMRAM + 2
    ld [hl], \1

ENDM

; Saves the BG tile index to A
; @param \1: the tile's X postion
; @param \2: the tile's Y position
; @param \3: the X offset
; @param \4: the Y offset
; @overwrites: HL, DE
; @returns A: the corresponding tile index
GETBGTILEINDEXAT: MACRO

    ; GOAL: Calculate ((Y * 32) + X) + _SCRN0
    
    ; Save BC as to not lose its data
    push bc

    ; Save ((Y + offset) * 32) to BC    
    ld hl, \2
    ld a, [hl]

    add a, \4

    ld h, 0
    ld l, a

    ; Y * 2
    add hl, hl

    ; Y * 4
    add hl, hl

    ; Y * 8
    add hl, hl

    ; Y * 16
    add hl, hl
    
    ; Y * 32
    add hl, hl

    ; Put HL into BC
    ld b, h
    ld c, l

    ; Save (X + offset) to HL
    ld hl, \1
    ld a, [hl]

    add a, \3
    
    ld h, 0
    ld l, a

    ; Add _SCRN0 + BC to HL
    ld de, _SCRN0

    add hl, de
    add hl, bc

    ; Load BG tile index into A
    ld a, [hl]

    ; Fetch BC's initial value
    pop bc
    
ENDM

; Checks if the value in A is equal to GROUND_TILE_INDEX
;
; Should be used right after GETBGTILEINDEXAT
; @overwrites: H
; @returns: Nothing
CHECKTILEISGROUND: MACRO

    ld h, GROUND_TILE_INDEX
    xor a, h

ENDM

; Update the player's X position in RAM
; @param \1: the new X position
; @overwrite: HL
; @returns: Nothing
UPDATEPLAYERXPOSITION: MACRO

    ld hl, PLAYER_X
    ld [hl], \1

ENDM

; Increase the player's X position
; @param \1: the value to add
; @overwrite: HL, A
; @returns: Nothing
INCREASEPLAYERXPOSITION: MACRO

    ld hl, PLAYER_X
    ld a, \1
    add [hl]
    ld [hl], a

ENDM

; Decrease the player's X axis position
; @param \1: the amount to substract
; @overwrites: HL, A, B
; @returns: nothing
DECREASEPLAYERXPOSITION: MACRO

    ld hl, PLAYER_X
    ld a, [hl]
    ld b, \1
    sub a, b
    ld [hl], a

ENDM

; Increase the player's Y axis position
; @param \1: the value to add
; @overwrites: HL, A
; @returns: nothing
INCREASEPLAYERYPOSITION: MACRO

    ld hl, PLAYER_Y
    ld a, \1
    add [hl]
    ld [hl], a

ENDM

; Decrease the player's Y axis position
; @param \1: the amount to substract
; @overwrites: HL, A, B
; @returns: nothing
DECREASEPLAYERYPOSITION: MACRO

    ld hl, PLAYER_Y
    ld a, [hl]
    ld b, \1
    sub a, b
    ld [hl], a

ENDM



; Update the player's Y position in RAM
; @param \1: The new Y position
; @overwrite: HL
; @returns: Nothing
UPDATEPLAYERYPOSITION: MACRO

    ld hl, PLAYER_Y
    ld [hl], \1

ENDM


WAITVRAMMACRO: MACRO

    ld a, [rSTAT]
    and STATF_BUSY
    jr nz, @-4

ENDM

WAITVBLANKMACRO: MACRO

    ld a, [rLY]
    cp 144
    jr nz, @-4
    
ENDM

CHECKMOVECOOLDOWN: MACRO

    ld hl, MOVE_COOLDOWN
    ld a, [hl]
    and a

ENDM

CHECKACTIONCOOLDOWN: MACRO

    ld hl, ACTION_COOLDOWN
    ld a, [hl]
    and a

ENDM

    ENDC ;MACROS_INC