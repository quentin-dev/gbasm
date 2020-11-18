INCLUDE "hardware.inc"
INCLUDE "macros.inc"

SECTION "player utils", ROMX

; Check if there if an interaction is vertically next to the player
; @param HL: Interaction entry start
; @overwrites: B, DE
; @returns A: 0 if the interaction is above or under the player
; @returns HL: HL's input value
CHECKVERTICAL:

    ; Save the entry's X position to B
    ld a, [hl]
    ld b, a

    ; Check if X values are equal
    ld de, PLAYER_X
    ld a, [de]

    xor a, b

    ; Return if they aren't
    jr nz, .end

    ; Point to the entry's Y position
    inc hl

    ; Save the entry's Y position ton B
    ld a, [hl]
    ld b, a

    ; Reset HL
    dec hl

    ld de, PLAYER_Y
    
    ; Check if entry's Y position is equal to the player's + 1
    ld a, [de]
    inc a

    xor a, b

    jr z, .end

    ; Check if entry's Y position is equal to the player's - 1
    ld a, [de]
    dec a

    xor a, b

    jr z, .end

.end

    ret

; Check if there if an interaction is horizontally next to the player
; @param HL: Interaction entry start
; @overwrites: B, DE
; @returns A: 0 if the interaction is in front of or behind the player
; @returns HL: HL's input value
CHECKHORIZONTAL::
    
    ; Point to the entry's Y position
    inc hl

    ; Save the entry's Y position to B
    ld a, [hl]
    ld b, a

    ; Point to the entry's X position for later
    dec hl

    ; Check if Y values are equal
    ld de, PLAYER_Y
    ld a, [de]

    xor a, b

    ; return if they aren't equal
    jr nz, .end

    ; Save the entry's X position to B
    ld a, [hl]
    ld b, a

    ld de, PLAYER_X
    
    ; Check if the entry's X position is equal to the player's + 1
    ld a, [de]
    inc a

    xor a, b

    jr z, .end

    ; Check if the entry's X position is equal to the player's - 1
    ld a, [de]
    dec a

    xor a, b

.end

    ret


; Sets and displays dialogue if the player is next to an interaction
; @overwrites: A, DE, HL
; @returns: Nothing
NEXTTOINTERACTION:

    ; Save BC
    push bc

    ld hl, InteractionListStart

.checkentryloop
    ; Get the interaction's X position
    ld a, [hl]

    ; Check if we reached the end of the list
    cp 33
    ; Jump to the end of the function if we have
    jr z, .end

    call CHECKVERTICAL

    and a, a

    jr z, .displaydialogue

    call CHECKHORIZONTAL

    and a, a

    jr z, .displaydialogue

    ; Increment HL to point to the next entry

    inc hl
    inc hl
    inc hl
    inc hl

    jr .checkentryloop

.displaydialogue

    ; Increment HL to point to the start of the string

    inc hl
    inc hl

    ; Load the address of the string into DE
    ; Watch out for endianness
    ld a, [hl]
    ld e, a

    inc hl

    ld a, [hl]
    ld d, a

    call SETDIALOGUESTRING
    call UPDATELCDWINDOW

.end

    ; Set BC's value
    pop bc

    ret

; What to do when A is pressed
; @overwrites: A, DE, HL
; @returns: Nothing
APRESSED::

    call NEXTTOINTERACTION
    call SETACTIONCOOLDOWN

    ret

; What to do when the player should move right
; @overwrite: A
; @returns: Nothing
MOVERIGHT::

    GETBGTILEINDEXAT PLAYER_X, PLAYER_Y, 1, 0

    CHECKTILEISGROUND

    jr nz, .end

    call HIDELCDWINDOW

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

    call HIDELCDWINDOW

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

    call HIDELCDWINDOW

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

    call HIDELCDWINDOW

    ld a, [rSCY]
    add MOVE_SIZE
    ld [rSCY], a

    call SETMOVECOOLDOWN

    INCREASEPLAYERYPOSITION 1

.end

    ret