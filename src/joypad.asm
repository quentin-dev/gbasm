INCLUDE "hardware.inc"

SECTION "joypad utils", ROMX

READJOYPAD2::

    ld a, P1F_4
    ld [rP1], a

    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]

    ld b, a

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