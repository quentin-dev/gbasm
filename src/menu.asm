INCLUDE "hardware.inc"

SECTION "menu", ROMX

INCLUDE "bg-3.inc"

INITMENU::

    ld hl, bg3_tile_data
    ld de, _VRAM
    ld bc, bg3_tile_data_size
    call MEMCOPYTOVRAM

    ld hl, bg3_map_data
    ld de, _SCRN0
    ld bc, bg3_tile_map_size
    call MEMCOPY
