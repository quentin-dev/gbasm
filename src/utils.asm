INCLUDE "hardware.inc"

SECTION "game utils", ROMX

; :: to export the function
WAITVBLANK::
    ld a, [rLY]
    cp 144
    jp nz, WAITVBLANK
    ret