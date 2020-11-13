INCLUDE "hardware.inc"

; Sprite constants
_SPR0_Y EQU _OAMRAM ; Sprite Y = start of sprite memory
_SPR0_X EQU _OAMRAM + 1
_SPR0_NUM EQU _OAMRAM + 2
_SPR0_ATT EQU _OAMRAM + 3

_MOVX EQU _RAM
_MOVY EQU _RAM + 1

SECTION "Vblank", ROM0[$0040]
	reti

SECTION "LCDC", ROM0[$0048]
	reti

SECTION "Timer", ROM0[$0050]
	reti

SECTION "Serial", ROM0[$0058]
	reti

SECTION "Joypad", ROM0[$0060]
	reti

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
    ; xor a ; ld a, 0 ; Only bit 7 needs reset, but 0 works
    ; ld [rLCDC], a

    call STOPLCD

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
    call STARTLCD

.game_loop
    call WAITVBLANK

    call READJOYPAD2

.start_pressed

    ld a, b

    ; Check if the Start button was pressed
    bit PADB_START, a
    jr nz, .b_pressed

    call STOPLCD

    call INITGAME

    call STARTLCDWITHSPRITES

    jr .end

.b_pressed

    ld a, b

    ; Check if the B button was pressed
    bit PADB_B, a
    jr nz, .right_pressed

    call STOPLCD

    call INITMENU

    call STARTLCD

    jr .end

.right_pressed

    ld a, c

    bit $0, a
    ; jr nz, .end

    call z, MOVERIGHT

.left_pressed

    ld a, c

    bit $1, a
    call z, MOVELEFT

.up_pressed

    ld a, c

    bit $2, a
    call z, MOVEUP

.down_pressed

    ld a, c

    bit $3, a
    call z, MOVEDOWN

.end

    jr .game_loop

SECTION "Font", ROM0

FontTiles:
INCBIN "data/font.chr"
FontTilesEnd:

SECTION "Hello World string", ROM0

HelloWorldStr:
    db "Hello, World!", 0
HelloWorldStrEnd:
