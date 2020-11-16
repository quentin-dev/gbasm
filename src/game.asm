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

    ld hl, rWY
    ld [hl], WINDOW_Y_HIDDEN

    ld hl, rWX
    ld [hl], WINDOW_X

    ld hl, $9C00
    ld [hl], $C1

    call RESETALLOAMATTR

    SETPLAYERSPRITETILE 0
    SETPLAYERSCREENPOSITION 72, 72

    UPDATEPLAYERXPOSITION 9
    UPDATEPLAYERYPOSITION 9

    ld hl, MOVE_COOLDOWN
    ld [hl], 0

    ld hl, ACTION_COOLDOWN
    ld [hl], 0

    ret

SETMOVECOOLDOWN::

    ld hl, MOVE_COOLDOWN
    ld [hl], MOVE_COOLDOWN_LENGTH

    ret

UPDATEMOVECOOLDOWN::

    ld hl, MOVE_COOLDOWN
    dec [hl]

    ret

SETACTIONCOOLDOWN::

    ld hl, ACTION_COOLDOWN
    ld [hl], ACTION_COOLDOWN_LENGTH

    ret

UPDATEACTIONCOOLDOWN::

    ld hl, ACTION_COOLDOWN
    dec [hl]

    ret