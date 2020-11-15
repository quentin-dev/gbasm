INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "constants.inc"

SECTION "game screen", ROMX

INCLUDE "game-bg.inc"
INCLUDE "spritesheet.inc"

; Copies the game background tile and map data to $9000 (VRAM) and screen
; @overwrites: HL, DE, and BC
; @returns: Nothing
INITGAME::

    ld hl, gamebg_tile_data
    ld de, $9000
    ld bc, gamebg_tile_data_size
    call MEMCOPYTOVRAM

    ld hl, gamebg_map_data
    ld de, _SCRN0
    ld bc, gamebg_tile_map_size
    call MEMCOPY

    ld hl, spritesheet_tile_data
    ld de, _VRAM
    ld bc, spritesheet_tile_data_size
    call MEMCOPYTOVRAM

    ; Set first sprite palette
    ld hl, rOBP0
    ld [hl], %11100100

    ; Set second sprite palette
    ld hl, rOBP1
    ld [hl], %11100100

    call RESETALLOAMATTR

    SETPLAYERSPRITETILE 0
    SETPLAYERSCREENPOSITION 80, 72

    UPDATEPLAYERXPOSITION 10
    UPDATEPLAYERYPOSITION 9

    ret