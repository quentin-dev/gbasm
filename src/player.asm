INCLUDE "hardware.inc"

SECTION "player utils", ROMX

; What to do when the player should move right
; @overwrite: A
; @returns: Nothing
MOVERIGHT::

    ld a, [rSCX]
    inc a
    ld [rSCX], a

    ret

; What to do when the player should move left
; @overwrite: A
; @returns: Nothing
MOVELEFT::

    ld a, [rSCX]
    dec a
    ld [rSCX], a

    ret

; What to do when the player should move up
; @overwrite: A
; @returns: Nothing
MOVEUP::

    ld a, [rSCY]
    dec a
    ld [rSCY], a

    ret

; What to do when the player should move down
; @overwrite: A
; @returns: Nothing
MOVEDOWN::

    ld a, [rSCY]
    inc a
    ld [rSCY], a

    ret