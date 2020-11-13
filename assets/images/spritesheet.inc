; ///////////////////////
; //                   //
; //  File Attributes  //
; //                   //
; ///////////////////////

; Filename: spritesheet.png
; Pixel Width: 16px
; Pixel Height: 8px

; /////////////////
; //             //
; //  Constants  //
; //             //
; /////////////////

spritesheet_tile_map_size EQU $02
spritesheet_tile_map_width EQU $02
spritesheet_tile_map_height EQU $01

spritesheet_tile_data_size EQU $20
spritesheet_tile_count EQU $02

; ////////////////
; //            //
; //  Map Data  //
; //            //
; ////////////////

spritesheet_map_data:
DB $00,$01

; /////////////////
; //             //
; //  Tile Data  //
; //             //
; /////////////////

spritesheet_tile_data:
DB $18,$00,$18,$00,$18,$66,$00,$FF,$00,$BD,$81,$3C,$00,$24,$00,$24
DB $5A,$00,$18,$81,$FF,$00,$5A,$24,$18,$24,$18,$00,$18,$02,$08,$04