INCLUDE "hardware.inc"

SECTION "player utils", ROMX

MOVERIGHT::

    ld a, [rSCX]
    inc a
    ld [rSCX], a

    ret

MOVELEFT::

    ld a, [rSCX]
    dec a
    ld [rSCX], a

    ret

MOVEUP::

    ld a, [rSCY]
    dec a
    ld [rSCY], a

    ret

MOVEDOWN::

    ld a, [rSCY]
    inc a
    ld [rSCY], a

    ret