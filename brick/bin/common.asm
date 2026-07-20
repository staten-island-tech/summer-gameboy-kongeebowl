;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module common
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _joypadCurrent
	.globl _joypadPrevious
	.globl _ballState
	.globl _topScore
	.globl _score
	.globl _stage
	.globl _ballVelocityY
	.globl _ballVelocityX
	.globl _ballAngle
	.globl _ballY
	.globl _ballX
	.globl _blocksLeft
	.globl _paddleXSpeed
	.globl _paddleY
	.globl _paddleX
	.globl _BlackAndWhitePalette
	.globl _RandomNumber
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
_paddleX::
	.ds 2
_paddleY::
	.ds 2
_paddleXSpeed::
	.ds 2
_blocksLeft::
	.ds 2
_ballX::
	.ds 2
_ballY::
	.ds 2
_ballAngle::
	.ds 2
_ballVelocityX::
	.ds 2
_ballVelocityY::
	.ds 2
_stage::
	.ds 1
_score::
	.ds 2
_topScore::
	.ds 2
_ballState::
	.ds 1
_joypadPrevious::
	.ds 1
_joypadCurrent::
	.ds 1
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
;source/default/common.c:27: uint8_t RandomNumber(uint8_t min, uint8_t max)
;	---------------------------------
; Function RandomNumber
; ---------------------------------
_RandomNumber::
	ld	l, a
;source/default/common.c:31: return min + (DIV_REG % (max - min)); 
	ld	c, l
	ld	b, #0x00
	ld	a, e
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
	ldh	a, (_DIV_REG + 0)
	ld	d, #0x00
	push	hl
	ld	e, a
	call	__modsint
	pop	hl
	ld	a, c
	add	a, l
;source/default/common.c:32: }
	ret
_BlackAndWhitePalette:
	.dw #0x7fff
	.dw #0x56b5
	.dw #0x14a5
	.dw #0x0000
	.area _CODE
	.area _INITIALIZER
__xinit__paddleX:
	.dw #0x0000
__xinit__paddleY:
	.dw #0x0000
__xinit__paddleXSpeed:
	.dw #0x0000
__xinit__blocksLeft:
	.dw #0x0000
__xinit__ballX:
	.dw #0x0000
__xinit__ballY:
	.dw #0x0000
__xinit__ballAngle:
	.dw #0x002d
__xinit__ballVelocityX:
	.dw #0x0000
__xinit__ballVelocityY:
	.dw #0x0000
__xinit__stage:
	.db #0x00	; 0
__xinit__score:
	.dw #0x0000
__xinit__topScore:
	.dw #0x0000
__xinit__ballState:
	.db #0x00	; 0
__xinit__joypadPrevious:
	.db #0x00	; 0
__xinit__joypadCurrent:
	.db #0x00	; 0
	.area _CABS (ABS)
