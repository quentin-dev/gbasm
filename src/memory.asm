INCLUDE "hardware.inc"

SECTION "memory utils", ROMX

; Copies BC bytes starting at HL to DE
; @param HL: Source's starting position
; @param DE: Destination's starting position
; @param BC: Number of bytes to copy
; @returns: Nothing
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

; Copies BC bytes starting at HL to DE in a VRAM-safe manner
; @param HL: Source's starting position
; @param DE: Destination's starting position
; @param BC: Number of bytes to copy
; @returns: Nothing
MEMCOPYTOVRAM::

    inc b
    inc c
    jr .memcopyvramskip

.memcopyvramloop

    di

    call WAITVRAM

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