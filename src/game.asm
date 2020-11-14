INCLUDE "hardware.inc"

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

    ld hl, rOBP0
    ld [hl], %11100100

    ld hl, rOBP1
    ld [hl], %11100100

    call RESETALLOAMATTR

    ld hl, _OAMRAM
    ld [hl], 84

    inc l
    ld [hl], 80

    inc l
    ld [hl], $00

    inc l
    ld [hl], $00

    ret