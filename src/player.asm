INCLUDE "hardware.inc"
INCLUDE "macros.inc"

SECTION "player utils", ROMX

; What to do when the player should move right
; @overwrite: A
; @returns: Nothing
MOVERIGHT::

    GETBGTILEINDEXAT PLAYER_X, PLAYER_Y, 1, 0

    CHECKTILEISGROUND

    jr nz, .end

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

    GETBGTILEINDEXAT PLAYER_X, PLAYER_Y, -1, 0

    CHECKTILEISGROUND

    jr nz, .end

    ld a, [rSCX]
    sub MOVE_SIZE
    ld [rSCX], a

    call SETMOVECOOLDOWN

    DECREASEPLAYERXPOSITION 1

.end

    ret

; What to do when the player should move up
; @overwrite: A
; @returns: Nothing
MOVEUP::

    GETBGTILEINDEXAT PLAYER_X, PLAYER_Y, 0, -1

    CHECKTILEISGROUND

    jr nz, .end

    ld a, [rSCY]
    sub MOVE_SIZE
    ld [rSCY], a

    call SETMOVECOOLDOWN

    DECREASEPLAYERYPOSITION 1

.end

    ret

; What to do when the player should move down
; @overwrite: A
; @returns: Nothing
MOVEDOWN::

    GETBGTILEINDEXAT PLAYER_X, PLAYER_Y, 0, 1

    CHECKTILEISGROUND

    jr nz, .end

    ld a, [rSCY]
    add MOVE_SIZE
    ld [rSCY], a

    call SETMOVECOOLDOWN

    INCREASEPLAYERYPOSITION 1

.end

    ret