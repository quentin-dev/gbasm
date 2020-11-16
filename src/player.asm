INCLUDE "hardware.inc"
INCLUDE "macros.inc"

SECTION "player utils", ROMX

; What to do when the player should move right
; @overwrite: A
; @returns: Nothing
MOVERIGHT::

    ; GETBGTILEINDEXAT 80, 72

    ld a, [rSCX]
    add MOVE_SIZE
    ld [rSCX], a

    call SETMOVECOOLDOWN

    INCREASEPLAYERXPOSITION 1

.end

    ret

; What to do when the player should move left
; @overwrite: A
; @returns: Nothing
MOVELEFT::

    ld a, [rSCX]
    sub MOVE_SIZE
    ld [rSCX], a

    call SETMOVECOOLDOWN

    DECREASEPLAYERXPOSITION 1

    ret

; What to do when the player should move up
; @overwrite: A
; @returns: Nothing
MOVEUP::

    ld a, [rSCY]
    sub MOVE_SIZE
    ld [rSCY], a

    call SETMOVECOOLDOWN

    DECREASEPLAYERYPOSITION 1

    ret

; What to do when the player should move down
; @overwrite: A
; @returns: Nothing
MOVEDOWN::

    ld a, [rSCY]
    add MOVE_SIZE
    ld [rSCY], a

    call SETMOVECOOLDOWN

    INCREASEPLAYERYPOSITION 1

    ret