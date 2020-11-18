INCLUDE "hardware.inc"
INCLUDE "constants.inc"

SECTION "dialogue utils", ROMX

; @overwrites: A, BC, DE
; @returns: Nothinh
CLEARWINDOW::

    ; Clear the first line

    ; Use the ground tile
    ld a, GROUND_TILE_INDEX
    
    ; Start at the beginning of the window
    ld de, _SCRN1

    ; Clear only the 20 visible tiles
    ld bc, 20

    call MEMSETVAL

    ; Move to the start of second line
    ld de, _SCRN1 + $20
    ld bc, 20

    call MEMSETVAL

    ; Move to the start of the third line
    ld de, _SCRN1 + $40
    ld bc, 20

    call MEMSETVAL

    ret

; Sets the string seeen in the window
;
; WARNING: Only the 18 first characters of the string will be displayed
; @param DE: Start of the string to display
; @overwrites: A, BC, HL
; @returns: Nothing
SETDIALOGUESTRING::

    ; Save DE's value to HL
    ld h, d
    ld l, e

    ; Clear the text line
    ld a, GROUND_TILE_INDEX
    ld de, WINDOW_TEXT_START_POSITION
    ld bc, WINDOW_TEXT_MAX_LEN

    call MEMSETVAL

    ; Get DE's value from HL
    ld d, h
    ld e, l

    ; Write on the second line, indented by 1
    ld hl, WINDOW_TEXT_START_POSITION

.writeloop

    ld a, [de]

    and a

    jr z, .end

    ld [hl+], a

    inc de

    jr .writeloop

.end

    ret