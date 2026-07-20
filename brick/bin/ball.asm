;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module ball
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _UpdateBall
	.globl _ResetBall
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
;source/default/ball.c:6: void ResetBall(){
;	---------------------------------
; Function ResetBall
; ---------------------------------
_ResetBall::
;source/default/ball.c:8: ballX=BALLSTART_X;
	ld	hl, #_ballX
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x04
;source/default/ball.c:9: ballY=BALLSTART_Y;
	ld	hl, #_ballY
	ld	a, #0x80
	ld	(hl+), a
	ld	(hl), #0x06
;source/default/ball.c:10: ballVelocityX=0;
	xor	a, a
	ld	hl, #_ballVelocityX
	ld	(hl+), a
	ld	(hl), a
;source/default/ball.c:11: ballVelocityY=0;
	xor	a, a
	ld	hl, #_ballVelocityY
	ld	(hl+), a
	ld	(hl), a
;source/default/ball.c:12: }
	ret
;source/default/ball.c:14: uint8_t UpdateBall(uint8_t lastSprite){
;	---------------------------------
; Function UpdateBall
; ---------------------------------
_UpdateBall::
	dec	sp
	dec	sp
	ldhl	sp,	#1
	ld	(hl), a
;source/default/ball.c:17: ballX+=ballVelocityX>>4;
	ld	hl, #_ballVelocityX
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ld	hl, #_ballX
	ld	a, (hl)
	add	a, c
	ld	(hl+), a
	ld	a, (hl)
	adc	a, b
	ld	(hl), a
;source/default/ball.c:18: ballY+=ballVelocityY>>4;
	ld	hl, #_ballVelocityY
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ld	hl, #_ballY
	ld	a, (hl)
	add	a, c
	ld	(hl+), a
	ld	a, (hl)
	adc	a, b
;source/default/ball.c:21: if((ballY>>4)>144){
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	e, c
	ld	d, b
	ld	a, #0x90
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	NC, 00102$
;source/default/ball.c:24: return 0;
	xor	a, a
	jr	00104$
00102$:
;source/default/ball.c:27: lastSprite = move_metasprite(ball_metasprites[0],paddle_TILE_COUNT,lastSprite,(ballX>>4)+7,(ballY>>4)+15);
	ld	a, c
	add	a, #0x0f
	ldhl	sp,	#0
	ld	(hl), a
	ld	hl, #_ballX
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	a, c
	add	a, #0x07
	ld	c, a
	ld	hl, #_ball_metasprites
	ld	a,	(hl+)
	ld	h, (hl)
;/opt/gbdk/include/gb/metasprites.h:169: __current_metasprite = metasprite;
	ld	e, a
	ld	d, h
	ld	hl, #___current_metasprite
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;/opt/gbdk/include/gb/metasprites.h:170: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x03
;/opt/gbdk/include/gb/metasprites.h:171: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_prop),a
;/opt/gbdk/include/gb/metasprites.h:172: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	d, a
	ld	e, c
	ld	a, (hl)
	call	___move_metasprite
;source/default/ball.c:29: return 1;
	ld	a, #0x01
00104$:
;source/default/ball.c:30: }
	inc	sp
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
