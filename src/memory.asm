INCLUDE "hardware.inc"

SECTION "memory utils", ROMX

; @param HL:
; @param DE:
; @param BC:
MEMCOPY::

    inc b
    inc c
    jr .memcopyskip

.memcopyloop

    ld a, [hl+]
    ld [de], a

    inc de

.memcopyskip

    dec c
    jr nz, .memcopyloop
    dec b
    jr nz, .memcopyloop
    ret

; @param HL: Source's starting position
; @param DE: Destination's starting position
; @param BC: Number of bytes to copy
MEMCOPYTOVRAM::

    inc b
    inc c
    jr .memcopyvramskip

.memcopyvramloop

    di

    ; WaitForLCD

    ld a, [hl+]
    ld [de], a

    ei
    inc de

.memcopyvramskip

    dec c
    jr nz, .memcopyvramloop
    dec b
    jr nz, .memcopyvramloop
    ret
