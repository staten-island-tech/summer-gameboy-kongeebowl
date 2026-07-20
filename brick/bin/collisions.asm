;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module collisions
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _CollideBricksAgainstBall
	.globl _CollidePaddleAgainstBall
	.globl _IncreaseScore
	.globl _UpdateBrick
	.globl _CheckTopOrBottomBrick
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
;source/default/collisions.c:9: void CollidePaddleAgainstBall(){
;	---------------------------------
; Function CollidePaddleAgainstBall
; ---------------------------------
_CollidePaddleAgainstBall::
	add	sp, #-8
;source/default/collisions.c:10: int16_t xd = (int16_t)(ballX>>4)-(int16_t)(paddleX>>4);
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
	ld	hl, #_paddleX
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
;source/default/collisions.c:12: xd = ABS(xd);
	ld	h, b
	bit	7, h
	jr	Z, 00112$
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
00112$:
;source/default/collisions.c:14: if(xd<=PADDLE_SIZE/2+BALL_RADIUS){
	ld	e, b
	ld	d, #0x00
	ld	a, #0x13
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00203$
	bit	7, d
	jr	NZ, 00204$
	cp	a, a
	jr	00204$
00203$:
	bit	7, d
	jr	Z, 00204$
	scf
00204$:
	jp	C, 00110$
;source/default/collisions.c:16: int16_t yd =(int16_t)(ballY>>4)-(int16_t)(paddleY>>4);
	ld	hl, #_ballY
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ld	hl, #_paddleY
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	(hl), e
;source/default/collisions.c:18: yd = ABS(yd);
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00114$
	inc	hl
	ld	de, #0x0000
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	(hl), e
	jr	00115$
00114$:
	ldhl	sp,	#6
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
00115$:
	ldhl	sp,	#4
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
;source/default/collisions.c:20: if(yd<=(PADDLE_HALF_THICKNESS+BALL_RADIUS)){
	ld	(hl-), a
	ld	a, #0x05
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00205$
	bit	7, d
	jr	NZ, 00206$
	cp	a, a
	jr	00206$
00205$:
	bit	7, d
	jr	Z, 00206$
	scf
00206$:
	jp	C, 00110$
;source/default/collisions.c:23: ballVelocityY=-ballVelocityY;
	xor	a, a
	ld	hl, #_ballVelocityY
	sub	a, (hl)
	ld	(hl+), a
	sbc	a, a
	sub	a, (hl)
	ld	(hl), a
;source/default/collisions.c:25: NR10_REG=0X2B;
	ld	a, #0x2b
	ldh	(_NR10_REG + 0), a
;source/default/collisions.c:26: NR11_REG=0X81;
	ld	a, #0x81
	ldh	(_NR11_REG + 0), a
;source/default/collisions.c:27: NR12_REG=0X41;
	ld	a, #0x41
	ldh	(_NR12_REG + 0), a
;source/default/collisions.c:28: NR13_REG=0X5C;
	ld	a, #0x5c
	ldh	(_NR13_REG + 0), a
;source/default/collisions.c:29: NR14_REG=0X86;
	ld	a, #0x86
	ldh	(_NR14_REG + 0), a
;source/default/collisions.c:31: if(xd>PADDLE_SIZE/2-PADDLE_HALF_THICKNESS){
	ld	e, b
	ld	d, #0x00
	ld	a, #0x0e
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00207$
	bit	7, d
	jr	NZ, 00208$
	cp	a, a
	jr	00208$
00207$:
	bit	7, d
	jr	Z, 00208$
	scf
00208$:
	jp	NC, 00105$
;source/default/collisions.c:34: ballVelocityX=ABS(ballVelocityX);
	ld	a, (_ballVelocityX)
	ld	hl, #_ballVelocityX + 1
	ld	b, (hl)
	ld	de, #0x0000
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#1
	ld	(hl-), a
	ld	(hl), e
	ld	a, (#_ballVelocityX)
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, (#_ballVelocityX + 1)
	ldhl	sp,	#7
	ld	(hl), a
;source/default/collisions.c:35: ballX=MAX(ballX,paddleX+1+PADDLE_SIZE/2+((PADDLE_HALF_THICKNESS-BALL_RADIUS)<<4));
	ld	a, (#_paddleX)
	ldhl	sp,	#2
	ld	(hl), a
	ld	a, (#_paddleX + 1)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (#_ballX)
	ldhl	sp,	#4
	ld	(hl), a
	ld	a, (#_ballX + 1)
	ldhl	sp,	#5
	ld	(hl), a
;source/default/collisions.c:34: ballVelocityX=ABS(ballVelocityX);
	ld	a, b
	rlca
	and	a,#0x01
	ld	c, a
;source/default/collisions.c:32: if(paddleX<ballX){
	ld	de, #_paddleX
	ld	hl, #_ballX
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00102$
;source/default/collisions.c:34: ballVelocityX=ABS(ballVelocityX);
	ld	a, c
	or	a, a
	jr	Z, 00116$
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
00116$:
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(#_ballVelocityX),a
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(#_ballVelocityX + 1),a
;source/default/collisions.c:35: ballX=MAX(ballX,paddleX+1+PADDLE_SIZE/2+((PADDLE_HALF_THICKNESS-BALL_RADIUS)<<4));
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#6
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00118$
	ldhl	sp,	#4
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
00118$:
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(#_ballX),a
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(#_ballX + 1),a
	jr	00105$
00102$:
;source/default/collisions.c:38: ballVelocityX=-ABS(ballVelocityX);
	ld	a, c
	or	a, a
	jr	Z, 00120$
	pop	bc
	push	bc
	jr	00121$
00120$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00121$:
	xor	a, a
	sub	a, c
	ld	hl, #_ballVelocityX
	ld	(hl+), a
	sbc	a, a
	sub	a, b
	ld	(hl), a
;source/default/collisions.c:39: ballX=MIN(ballX,paddleX-1-PADDLE_SIZE/2-((PADDLE_HALF_THICKNESS-BALL_RADIUS)<<4));
	ldhl	sp,#2
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	dec	bc
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00122$
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00122$:
	ld	hl, #_ballX
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00105$:
;source/default/collisions.c:42: ballY=MIN(ballY,paddleY-((1+PADDLE_HALF_THICKNESS+BALL_RADIUS)<<4));
	ld	a, (_paddleY)
	ld	hl, #_paddleY + 1
	ld	b, (hl)
	add	a, #0xa0
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ld	a, (_ballY)
	ld	e, a
	ld	hl, #_ballY + 1
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jr	C, 00125$
	ld	e, c
	ld	d, b
00125$:
	ld	hl, #_ballY
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00110$:
;source/default/collisions.c:48: }
	add	sp, #8
	ret
;source/default/collisions.c:50: void CollideBricksAgainstBall(){
;	---------------------------------
; Function CollideBricksAgainstBall
; ---------------------------------
_CollideBricksAgainstBall::
	add	sp, #-11
;source/default/collisions.c:52: int16_t verticalSide=SIGN(ballVelocityY);
	ld	a, (_ballVelocityY)
	ld	hl, #_ballVelocityY + 1
	bit	7, (hl)
	ld	a, #0xff
	jr	NZ, 00114$
	ld	a, #0x01
00114$:
	ldhl	sp,	#9
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl), a
;source/default/collisions.c:53: int16_t horizontalSide=SIGN(ballVelocityX);
	ld	a, (_ballVelocityX)
	ld	hl, #_ballVelocityX + 1
	bit	7, (hl)
	ld	a, #0xff
	jr	NZ, 00116$
	ld	a, #0x01
00116$:
	ldhl	sp,	#0
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl), a
;source/default/collisions.c:55: int16_t checkHorizontal = (ballX>>4)+horizontalSide*BALL_RADIUS;
	ld	a, (#_ballX)
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (#_ballX + 1)
	ldhl	sp,	#8
	ld	(hl), a
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	pop	bc
	push	bc
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, (hl)
	add	a, c
	ld	c, a
	ld	a, e
	adc	a, b
	ldhl	sp,	#2
	ld	(hl), c
	inc	hl
	ld	(hl), a
;source/default/collisions.c:56: int16_t checkVertical = (ballY>>4)+verticalSide*BALL_RADIUS;
	ld	hl, #_ballY
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
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, bc
	ld	c, l
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), c
	inc	hl
;source/default/collisions.c:58: uint8_t topBottomOrWall = CheckTopOrBottomBrick(ballX>>4,checkVertical);
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	inc	hl
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_CheckTopOrBottomBrick
;source/default/collisions.c:61: if(topBottomOrWall!=0){
	ldhl	sp,#6
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	Z, 00105$
;source/default/collisions.c:63: ballVelocityY=-verticalSide*ABS(ballVelocityY);
	ld	de, #0x0000
	ldhl	sp,	#9
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#8
	ld	(hl-), a
	ld	(hl), e
	ld	a, (_ballVelocityY)
	ld	hl, #_ballVelocityY + 1
	bit	7, (hl)
	jr	Z, 00117$
	ld	de, #0x0000
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#10
	ld	(hl-), a
	ld	(hl), e
	jr	00118$
00117$:
	ld	a, (#_ballVelocityY)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (#_ballVelocityY + 1)
	ldhl	sp,	#10
	ld	(hl), a
00118$:
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ld	hl, #_ballVelocityY
	ld	a, c
	ld	(hl+), a
;source/default/collisions.c:66: ballVelocityY+=SIGN(ballVelocityY)*BALL_SPEEDUP;
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	bit	7, b
	jr	Z, 00119$
	ld	hl, #0xffff
	jr	00120$
00119$:
	ld	hl, #0x0001
00120$:
	ld	e, l
	ld	d, h
	add	hl, hl
	add	hl, de
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #_ballVelocityY
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;source/default/collisions.c:69: if(topBottomOrWall!=WALL){
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00102$
;source/default/collisions.c:71: blocksLeft--;
	ld	hl, #_blocksLeft
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;source/default/collisions.c:74: NR10_REG=0X00;
	xor	a, a
	ldh	(_NR10_REG + 0), a
;source/default/collisions.c:75: NR11_REG=0X81;
	ld	a, #0x81
	ldh	(_NR11_REG + 0), a
;source/default/collisions.c:76: NR12_REG=0X43;
	ld	a, #0x43
	ldh	(_NR12_REG + 0), a
;source/default/collisions.c:77: NR13_REG=0X73;
	ld	a, #0x73
	ldh	(_NR13_REG + 0), a
;source/default/collisions.c:78: NR14_REG=0X86;
	ld	a, #0x86
	ldh	(_NR14_REG + 0), a
;source/default/collisions.c:80: IncreaseScore(5);
	ld	de, #0x0005
	call	_IncreaseScore
;source/default/collisions.c:82: UpdateBrick(topBottomOrWall,ballX>>4,checkVertical);
	ldhl	sp,	#4
	ld	b, (hl)
	ld	a, (_ballX)
	ld	e, a
	ld	hl, #_ballX + 1
	ld	c, (hl)
	srl	c
	rr	e
	srl	c
	rr	e
	srl	c
	rr	e
	srl	c
	rr	e
	push	bc
	inc	sp
	ldhl	sp,	#7
	ld	a, (hl)
	call	_UpdateBrick
	jr	00105$
00102$:
;source/default/collisions.c:86: NR10_REG=0X4A;
	ld	a, #0x4a
	ldh	(_NR10_REG + 0), a
;source/default/collisions.c:87: NR11_REG=0X81;
	ld	a, #0x81
	ldh	(_NR11_REG + 0), a
;source/default/collisions.c:88: NR12_REG=0X43;
	ld	a, #0x43
	ldh	(_NR12_REG + 0), a
;source/default/collisions.c:89: NR13_REG=0X56;
	ld	a, #0x56
	ldh	(_NR13_REG + 0), a
;source/default/collisions.c:90: NR14_REG=0X86;
	ld	a, #0x86
	ldh	(_NR14_REG + 0), a
00105$:
;source/default/collisions.c:95: topBottomOrWall = CheckTopOrBottomBrick(checkHorizontal,ballY>>4);
	ld	hl, #_ballY
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
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_CheckTopOrBottomBrick
;source/default/collisions.c:99: if(topBottomOrWall!=0){
	ldhl	sp,#10
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	Z, 00111$
;source/default/collisions.c:102: ballVelocityX=-horizontalSide*ABS(ballVelocityX);
	ld	de, #0x0000
	pop	hl
	push	hl
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	(hl), e
	ld	a, (_ballVelocityX)
	ld	hl, #_ballVelocityX + 1
	bit	7, (hl)
	jr	Z, 00121$
	dec	hl
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	c, a
	sbc	a, a
	sub	a, (hl)
	ld	b, a
	jr	00122$
00121$:
	ld	a, (_ballVelocityX)
	ld	c, a
	ld	hl, #_ballVelocityX + 1
	ld	b, (hl)
00122$:
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ld	hl, #_ballVelocityX
	ld	a, c
	ld	(hl+), a
;source/default/collisions.c:105: ballVelocityX+=SIGN(ballVelocityX)*BALL_SPEEDUP;
	ld	a, b
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ld	a, (#_ballVelocityX + 1)
	ldhl	sp,	#5
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00123$
	ldhl	sp,	#8
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
	jr	00124$
00123$:
	ldhl	sp,	#8
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00124$:
	ldhl	sp,#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl)
	ld	(#_ballVelocityX),a
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(#_ballVelocityX + 1),a
;source/default/collisions.c:108: if(topBottomOrWall!=WALL){
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00107$
;source/default/collisions.c:111: blocksLeft--;
	ld	hl, #_blocksLeft
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;source/default/collisions.c:115: NR10_REG=0X00;
	xor	a, a
	ldh	(_NR10_REG + 0), a
;source/default/collisions.c:116: NR11_REG=0X81;
	ld	a, #0x81
	ldh	(_NR11_REG + 0), a
;source/default/collisions.c:117: NR12_REG=0X43;
	ld	a, #0x43
	ldh	(_NR12_REG + 0), a
;source/default/collisions.c:118: NR13_REG=0X73;
	ld	a, #0x73
	ldh	(_NR13_REG + 0), a
;source/default/collisions.c:119: NR14_REG=0X86;
	ld	a, #0x86
	ldh	(_NR14_REG + 0), a
;source/default/collisions.c:122: IncreaseScore(5);
	ld	de, #0x0005
	call	_IncreaseScore
;source/default/collisions.c:125: UpdateBrick(topBottomOrWall,checkHorizontal,ballY>>4);
	ld	a, (#_ballY)
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (#_ballY + 1)
	ldhl	sp,	#6
	ld	(hl), a
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	push	af
	inc	sp
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	call	_UpdateBrick
	jr	00111$
00107$:
;source/default/collisions.c:130: NR10_REG=0X4A;
	ld	a, #0x4a
	ldh	(_NR10_REG + 0), a
;source/default/collisions.c:131: NR11_REG=0X81;
	ld	a, #0x81
	ldh	(_NR11_REG + 0), a
;source/default/collisions.c:132: NR12_REG=0X43;
	ld	a, #0x43
	ldh	(_NR12_REG + 0), a
;source/default/collisions.c:133: NR13_REG=0X56;
	ld	a, #0x56
	ldh	(_NR13_REG + 0), a
;source/default/collisions.c:134: NR14_REG=0X86;
	ld	a, #0x86
	ldh	(_NR14_REG + 0), a
00111$:
;source/default/collisions.c:137: }
	add	sp, #11
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
