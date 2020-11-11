INCLUDE "hardware.inc"

; Sprite constants
_SPR0_Y EQU _OAMRAM ; Sprite Y = start of sprite memory
_SPR0_X EQU _OAMRAM + 1
_SPR0_NUM EQU _OAMRAM + 2
_SPR0_ATT EQU _OAMRAM + 3

_MOVX EQU _RAM
_MOVY EQU _RAM + 1

SECTION "Header", ROM0[$100]


EntryPoint:
    di ; Disable interrupts
    jp Start

REPT $150 - $104
    db 0
ENDR

SECTION "Game code", ROM0

Start:
    call WAITVBLANK

    ; Turn off LCD
    xor a ; ld a, 0 ; Only bit 7 needs reset, but 0 works
    ld [rLCDC], a

    ld hl, $9000
    ld de, FontTiles
    ld bc, FontTilesEnd - FontTiles
.copyFont
    ld a, [de] ; Grab 1 byte from the source
    ld [hli], a ; Place it at the destination, incrementing hl
    inc de ; Move to next byte
    dec bc ; Decrement count
    ld a, b ; Check if count is 0, since `dec bc` does not update flags
    or c
    jr nz, .copyFont

    ld hl, $9800 ; Prints at top-left corner of the screen
    ld de, HelloWorldStr
.copyString
    ld a, [de]
    ld [hli], a
    inc de
    and a ; Check if we copied a 0
    jr nz, .copyString ; Continue if it is not

.copy

    ; Init display register
    ld a, %11100100
    ld [rBGP], a

    xor a ; ld a, 0
    ld [rSCY], a
    ld [rSCX], a

    ; Shut sound down
    ld [rNR52], a

    call INITMENU

    ; Turn screen on, display background
    ; ld a, %10000001
    ; ld [rLCDC], a
    call ENABLEBG
    call SELECTDISPLAY1
    call LCDON

.game_loop
    call WAITVBLANK

.loop_until_145
    ld a, [rLY]
    cp 145
    jp nz, .loop_until_145

    call READJOYPAD

.scroll

    ld a, [rSCX]
    ; inc a
    ld [rSCX], a

    jp .game_loop

SECTION "Font", ROM0

FontTiles:
INCBIN "data/font.chr"
FontTilesEnd:

SECTION "Hello World string", ROM0

HelloWorldStr:
    db "Hello, World!", 0
HelloWorldStrEnd:

SECTION "Sprite tiles", ROM0

Tiles:
    db  $AA, $00, $44, $00, $AA, $00, $11, $00
    db  $AA, $00, $44, $00, $AA, $00, $11, $00
    db  $3E, $3E, $41, $7F, $41, $6B, $41, $7F
    db  $41, $63, $41, $7F, $3E, $3E, $00, $00
EndTiles:
