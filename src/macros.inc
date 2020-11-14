INCLUDE "hardware.inc"

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