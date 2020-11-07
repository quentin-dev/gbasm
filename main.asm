INCLUDE "hardware.inc"

SECTION "Header", ROM0[$100]


EntryPoint:
    di ; Disable interrupts
    jp Start

REPT $150 - $104
    db 0
ENDR

SECTION "Game code", ROM0

Start:
    ; Turn off LCD
.waitVBlank
    ld a, [rLY]
    cp 144 ; Check if LCD is past VBlank
    jr c, .waitVBlank

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

    ; Init display register
    ld a, %11100100
    ld [rBGP], a

    xor a ; ld a, 0
    ld [rSCY], a
    ld [rSCX], a

    ; Shut sound down
    ld [rNR52], a

    ; Turn screen on, display background
    ld a, %10000001
    ld [rLCDC], a

    ; Lock up
.lockup
    jr .lockup

SECTION "Font", ROM0

FontTiles:
INCBIN "font.chr"
FontTilesEnd:

SECTION "Hello World string", ROM0

HelloWorldStr:
    db "Hello, World!", 0
