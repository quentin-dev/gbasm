INCLUDE "hardware.inc"

SECTION "game screen", ROMX

INCLUDE "game-bg.inc"

INITGAME::

    ld hl, gamebg_tile_data
    ld de, $9000
    ld bc, gamebg_tile_data_size
    call MEMCOPYTOVRAM

    ld hl, gamebg_map_data
    ld de, _SCRN0
    ld bc, gamebg_tile_map_size
    call MEMCOPY

    ret