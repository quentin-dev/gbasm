INCLUDE "hardware.inc"

SECTION "joypad utils", ROMX

; Gets the currently pressed keys
; @overwrite: A, B, and C
; @return B: The value of the Button key that was pressed, if any
; @return C: The value of the Joypad key that was pressed, if any
READJOYPAD2::

    ; Select the Button keys (A, B, Select, Start)
    ld a, P1F_4
    ld [rP1], a

    ; Read the value multiple times to avoid "bouncing"
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]

    ; Save the value to B
    ld b, a

    ; Select the Joypad keys (Up, Down, Left, Right)
    ld a, P1F_5
    ld [rP1], a

    ; Read the value multiple times to avoid "bouncing"
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]

    ; Save to value to C
    ld c, a

    ret

READJOYPAD::
    ; Read joypad
    ld a, P1F_5
    ld [rP1], a

    ; Read multiple times to avoid bouncing
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]

    ; Save a in a temporary variable
    ld b, a

.check_up
    
    ; Check if up was pressed
    and P1F_2
    jp nz, .check_down

    ld a, [rSCY]
    inc a
    ld [rSCY], a

    jp .read_end

.check_down
    
    ld a, b

    ; Check if down was pressed
    and P1F_3
    jp nz, .check_right

    ld a, [rSCY]
    dec a
    ld [rSCY], a

.check_right

    ld a, b

    ; Check if right was pressed
    and P1F_0
    jp nz, .check_left

    ld a, [rSCX]
    dec a
    dec a
    ld [rSCX], a

.check_left

    ld a,b

    ; Check if left was pressed
    and P1F_1
    jp nz, .read_end

    ld a, [rSCX]
    inc a
    ld [rSCX], a

.read_end
    ret