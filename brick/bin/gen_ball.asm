;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module ball
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ball_metasprites
	.globl _ball_metasprite0
	.globl _ball_tiles
	.globl _ball_palettes
	.globl b___func_ball
	.globl ___func_ball
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
;source/gen/graphics/ball.c:8: BANKREF(ball)
;	---------------------------------
; Function __func_ball
; ---------------------------------
	b___func_ball	= 0
___func_ball::
	.local b___func_ball 
	___bank_ball = b___func_ball 
	.globl ___bank_ball 
	.area _CODE
_ball_palettes:
	.dw #0x7fff
	.dw #0x56b5
	.dw #0x318c
	.dw #0x0000
_ball_tiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
_ball_metasprite0:
	.db #0xfc	; -4
	.db #0xfc	; -4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_ball_metasprites:
	.dw _ball_metasprite0
	.area _INITIALIZER
	.area _CABS (ABS)
