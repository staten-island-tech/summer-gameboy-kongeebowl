;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module paddle
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _UpdatePaddle
	.globl _ResetPaddle
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
;source/default/paddle.c:5: void ResetPaddle(){
;	---------------------------------
; Function ResetPaddle
; ---------------------------------
_ResetPaddle::
;source/default/paddle.c:8: paddleX=80<<4;
	ld	hl, #_paddleX
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x05
;source/default/paddle.c:9: paddleY=130<<4;
	ld	hl, #_paddleY
	ld	a, #0x20
	ld	(hl+), a
	ld	(hl), #0x08
;source/default/paddle.c:10: paddleXSpeed=0;
	xor	a, a
	ld	hl, #_paddleXSpeed
	ld	(hl+), a
	ld	(hl), a
;source/default/paddle.c:12: }
	ret
;source/default/paddle.c:13: uint8_t UpdatePaddle(){
;	---------------------------------
; Function UpdatePaddle
; ---------------------------------
_UpdatePaddle::
	add	sp, #-12
;source/default/paddle.c:15: if(joypadCurrent & J_LEFT){
	ld	a, (_joypadCurrent)
	bit	1, a
	jr	Z, 00111$
;source/default/paddle.c:16: paddleXSpeed=-600;
	ld	hl, #_paddleXSpeed
	ld	a, #0xa8
	ld	(hl+), a
	ld	(hl), #0xfd
	jr	00112$
00111$:
;source/default/paddle.c:18: }else if(joypadCurrent & J_RIGHT){
	rrca
	jr	NC, 00108$
;source/default/paddle.c:19: paddleXSpeed=600;
	ld	hl, #_paddleXSpeed
	ld	a, #0x58
	ld	(hl+), a
	ld	(hl), #0x02
	jr	00112$
00108$:
;source/default/paddle.c:24: if(paddleXSpeed>30)paddleXSpeed-=30;
	ld	a, (_paddleXSpeed)
	ld	c, a
	ld	hl, #_paddleXSpeed + 1
	ld	b, (hl)
	ld	e, b
	ld	d, #0x00
	ld	a, #0x1e
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00258$
	bit	7, d
	jr	NZ, 00259$
	cp	a, a
	jr	00259$
00258$:
	bit	7, d
	jr	Z, 00259$
	scf
00259$:
	jr	NC, 00105$
	ld	a, c
	add	a, #0xe2
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	hl, #_paddleXSpeed
	ld	(hl), c
	inc	hl
	ld	(hl), a
	jr	00112$
00105$:
;source/default/paddle.c:25: else if(paddleXSpeed<-30)paddleXSpeed+=30;
	ld	hl, #_paddleXSpeed
	ld	a, (hl+)
	sub	a, #0xe2
	ld	a, (hl)
	sbc	a, #0xff
	ld	d, (hl)
	ld	a, #0xff
	bit	7,a
	jr	Z, 00260$
	bit	7, d
	jr	NZ, 00261$
	cp	a, a
	jr	00261$
00260$:
	bit	7, d
	jr	Z, 00261$
	scf
00261$:
	jr	NC, 00102$
	ld	hl, #0x001e
	add	hl, bc
	ld	c, l
	ld	a, h
	ld	hl, #_paddleXSpeed
	ld	(hl), c
	inc	hl
	ld	(hl), a
	jr	00112$
00102$:
;source/default/paddle.c:26: else paddleXSpeed=0;
	xor	a, a
	ld	hl, #_paddleXSpeed
	ld	(hl+), a
	ld	(hl), a
00112$:
;source/default/paddle.c:29: paddleX=CLAMP(paddleX+(paddleXSpeed>>4),LEFT_PADDLE_LIMIT,RIGHT_PADDLE_LIMIT);
	ld	hl, #_paddleXSpeed
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
	ld	a, c
	ld	hl, #_paddleX
	add	a, (hl)
	inc	hl
	ld	c, a
	ld	a, b
	adc	a, (hl)
	ld	b, a
	ld	a, #0x80
	cp	a, c
	ld	a, #0x01
	sbc	a, b
	ld	a, #0x00
	rla
	ld	e, a
	or	a, a
	jr	Z, 00123$
	ld	l, c
	ld	h, b
	jr	00124$
00123$:
	ld	hl, #0x0180
00124$:
	ld	a, l
	sub	a, #0x80
	ld	a, h
	sbc	a, #0x06
	jr	NC, 00121$
	ld	a, e
	or	a, a
	jr	NZ, 00122$
	ld	bc, #0x0180
	jr	00122$
00121$:
	ld	bc, #0x0680
00122$:
	ld	hl, #_paddleX
	ld	a, c
	ld	(hl+), a
;source/default/paddle.c:33: if(paddleX>=RIGHT_PADDLE_LIMIT){
	ld	a, b
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (#_paddleX + 1)
	ldhl	sp,	#11
	ld	(hl), a
;source/default/paddle.c:24: if(paddleXSpeed>30)paddleXSpeed-=30;
	ld	a, (#_paddleXSpeed)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (#_paddleXSpeed + 1)
	ldhl	sp,	#1
	ld	(hl), a
;source/default/paddle.c:35: paddleXSpeed=-ABS((paddleXSpeed)/4)*2;
	pop	de
	push	de
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	xor	a, a
	ld	hl, #_paddleXSpeed
	sub	a, (hl)
	inc	hl
	ld	c, a
	sbc	a, a
	sub	a, (hl)
	ld	b, a
	ldhl	sp,	#1
	ld	a, (hl)
	rlca
	and	a,#0x01
	ldhl	sp,	#4
	ld	(hl+), a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ld	a, (hl+)
	rlca
	and	a,#0x01
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
;source/default/paddle.c:33: if(paddleX>=RIGHT_PADDLE_LIMIT){
	ld	(hl+), a
	ld	a, (hl+)
	sub	a, #0x80
	ld	a, (hl)
	sbc	a, #0x06
	jp	C, 00116$
;source/default/paddle.c:34: paddleX=RIGHT_PADDLE_LIMIT;
	ld	hl, #_paddleX
	ld	a, #0x80
	ld	(hl+), a
	ld	(hl), #0x06
;source/default/paddle.c:35: paddleXSpeed=-ABS((paddleXSpeed)/4)*2;
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	Z, 00129$
	dec	hl
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
00129$:
	ldhl	sp,#10
	ld	a, (hl+)
	ld	b, (hl)
	sra	b
	sra	b
	bit	7, b
	jr	Z, 00127$
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	or	a, a
	jr	Z, 00130$
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00130$:
	sra	d
	rr	e
	sra	d
	rr	e
	jr	00128$
00127$:
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	Z, 00131$
	dec	hl
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
00131$:
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	sra	d
	rr	e
	sra	d
	rr	e
00128$:
	xor	a, a
	sub	a, e
	ld	l, a
	sbc	a, a
	sub	a, d
	ld	h, a
	add	hl, hl
	ld	a, l
	ld	c, h
	ld	hl, #_paddleXSpeed
	ld	(hl+), a
	ld	(hl), c
	jr	00117$
00116$:
;source/default/paddle.c:38: else if(paddleX<=LEFT_PADDLE_LIMIT){
	ldhl	sp,	#10
	ld	a, #0x80
	sub	a, (hl)
	inc	hl
	ld	a, #0x01
	sbc	a, (hl)
	jr	C, 00117$
;source/default/paddle.c:39: paddleX=LEFT_PADDLE_LIMIT;
	ld	hl, #_paddleX
	ld	a, #0x80
	ld	(hl+), a
	ld	(hl), #0x01
;source/default/paddle.c:40: paddleXSpeed=ABS((paddleXSpeed)/4)*2;
	pop	bc
	push	bc
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	Z, 00134$
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	b, (hl)
00134$:
	sra	b
	sra	b
	bit	7, b
	jr	Z, 00132$
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	or	a, a
	jr	Z, 00135$
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00135$:
	sra	d
	rr	e
	sra	d
	rr	e
	jr	00133$
00132$:
	pop	de
	push	de
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	Z, 00136$
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00136$:
	sra	d
	rr	e
	sra	d
	rr	e
00133$:
	ld	a, e
	add	a, a
	rl	d
	ld	hl, #_paddleXSpeed
	ld	(hl+), a
	ld	(hl), d
00117$:
;source/default/paddle.c:42: return move_metasprite(paddle_metasprites[0],0,0,(paddleX>>4)+8,(paddleY>>4)+16);
	ld	hl, #_paddleY
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
	add	a, #0x10
	ld	b, a
	ld	a, (_paddleX)
	ld	c, a
	ld	hl, #_paddleX + 1
	ld	e, (hl)
	srl	e
	rr	c
	srl	e
	rr	c
	srl	e
	rr	c
	srl	e
	rr	c
	ld	a, c
	add	a, #0x08
	ld	c, a
	ld	hl, #_paddle_metasprites
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
;/opt/gbdk/include/gb/metasprites.h:171: __current_base_prop = 0;
	xor	a, a
	ld	(#___current_base_tile), a
	ld	(#___current_base_prop),a
;/opt/gbdk/include/gb/metasprites.h:172: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ld	d, b
	ld	e, c
	xor	a, a
	call	___move_metasprite
;source/default/paddle.c:42: return move_metasprite(paddle_metasprites[0],0,0,(paddleX>>4)+8,(paddleY>>4)+16);
;source/default/paddle.c:43: }
	add	sp, #12
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
