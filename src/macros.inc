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
    ld [hl], \2 + 16
    
    inc l
    ; Set X position + offset
    ld [hl], \3 + 8

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

; WIP
; @param \1: the X postion
; @param \2: the Y position
; @returns HL: the address of the corresponding tile
GETBGTILEINDEXAT: MACRO

    ; Calculate (Y * 32) + [rSCY] + X + ([rSCX] / 32) + _SCRN0
    push bc

    ld hl, 0

    ; Add (Y * 32) + X + _SCRN0    
    ld bc, ((\2 / 8) * 32) + (\1 / 8) + _SCRN0
    add hl, bc

    ; Add [rSCY]
    ld bc, 0
    ld a, [rSCY]
    ld c, a
    add hl, bc

    ; Add [rSCX] / 32
    ld bc, 0
    ld a, [rSCX]

    rra
    rra
    rra
    rra
    rra

    ld c, a
    add hl, bc

    pop bc
    
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


CHECKMOVECOOLDOWN: MACRO

    ld hl, MOVE_COOLDOWN
    ld a, [hl]
    and a

ENDM

    ENDC ;MACROS_INC