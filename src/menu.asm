INCLUDE "hardware.inc"

SECTION "menu screen", ROMX

INCLUDE "menu-bg.inc"

; Copies the main menu background tile and map data to $9000 (VRAM) and screen
; @overwrites: HL, DE, and BC
; @returns: Nothing
INITMENU::

    ld hl, menubg_tile_data
    ld de, $9000
    ld bc, menubg_tile_data_size
    call MEMCOPYTOVRAM

    ld hl, menubg_map_data
    ld de, _SCRN0
    ld bc, menubg_tile_map_size
    call MEMCOPY

    ret
