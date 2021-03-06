; ///////////////////////
; //                   //
; //  File Attributes  //
; //                   //
; ///////////////////////

; Filename: game-bg.png
; Pixel Width: 256px
; Pixel Height: 256px

; /////////////////
; //             //
; //  Constants  //
; //             //
; /////////////////

gamebg_tile_map_size EQU $0400
gamebg_tile_map_width EQU $20
gamebg_tile_map_height EQU $20

gamebg_tile_data_size EQU $50
gamebg_tile_count EQU $05

; ////////////////
; //            //
; //  Map Data  //
; //            //
; ////////////////

gamebg_map_data:
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$01
DB $01,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$02,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$03,$03,$01,$03
DB $03,$01,$03,$03,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$00,$01,$01,$03,$03,$01
DB $01,$03,$03,$01,$01,$00,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$00,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$00,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$00,$01,$01,$01,$01,$03
DB $03,$01,$01,$01,$01,$00,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$00,$00,$01,$01
DB $01,$01,$00,$00,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$04,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; /////////////////
; //             //
; //  Tile Data  //
; //             //
; /////////////////

gamebg_tile_data:
DB $18,$00,$3C,$00,$3C,$00,$7E,$00,$7E,$00,$3C,$00,$00,$18,$00,$18
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$18,$18,$24,$18,$24,$42,$3C,$42,$3C,$24,$18,$00,$3C,$00,$3C
DB $40,$04,$00,$18,$00,$32,$00,$38,$18,$04,$3C,$5A,$3C,$7E,$3C,$18
DB $18,$00,$18,$00,$24,$5A,$18,$A5,$99,$00,$99,$24,$24,$00,$24,$00
