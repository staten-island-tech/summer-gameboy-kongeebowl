;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module paddle
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _paddle_metasprites
	.globl _paddle_metasprite0
	.globl _paddle_tiles
	.globl _paddle_palettes
	.globl b___func_paddle
	.globl ___func_paddle
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;source/gen/graphics/paddle.c:8: BANKREF(paddle)
;	---------------------------------
; Function __func_paddle
; ---------------------------------
	b___func_paddle	= 0
___func_paddle::
	.local b___func_paddle 
	___bank_paddle = b___func_paddle 
	.globl ___bank_paddle 
	.area _CODE
_paddle_palettes:
	.dw #0x7fff
	.dw #0x56b5
	.dw #0x318c
	.dw #0x0000
_paddle_tiles:
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xe8	; 232
	.db #0xff	; 255
	.db #0xa8	; 168
	.db #0xa8	; 168
	.db #0xff	; 255
	.db #0xe8	; 232
	.db #0xe8	; 232
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x17	; 23
	.db #0xff	; 255
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0x17	; 23
	.db #0x17	; 23
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_paddle_metasprite0:
	.db #0xfc	; -4
	.db #0xf0	; -16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_paddle_metasprites:
	.dw _paddle_metasprite0
	.area _INITIALIZER
	.area _CABS (ABS)
