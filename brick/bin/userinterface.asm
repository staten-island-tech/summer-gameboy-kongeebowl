;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module userinterface
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _IncreaseScore
	.globl _ResetUserInterface
	.globl _UpdateScore
	.globl _DrawNumber
	.globl _strlen
	.globl _uitoa
	.globl _set_bkg_tile_xy
	.globl _set_bkg_tiles
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
;source/default/userinterface.c:9: void DrawNumber(uint8_t x,uint8_t y, uint16_t number,uint8_t digits){
;	---------------------------------
; Function DrawNumber
; ---------------------------------
_DrawNumber::
	add	sp, #-17
	ld	c, a
	ldhl	sp,	#16
	ld	(hl), e
;source/default/userinterface.c:11: unsigned char buffer[]="00000000";
	ldhl	sp,	#0
	ld	a,#0x30
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x30
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x30
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x30
	ld	(hl+),a
	ld	(hl+), a
	ld	(hl), #0x00
;source/default/userinterface.c:14: uitoa(number, buffer, 10);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	bc
	ld	a, #0x0a
	push	af
	inc	sp
	ld	hl, #3
	add	hl, sp
	push	hl
	push	de
	call	_uitoa
	add	sp, #5
	pop	bc
;source/default/userinterface.c:17: uint8_t len =strlen(buffer);
	ld	hl, #0
	add	hl, sp
	push	hl
	call	_strlen
	pop	hl
	ldhl	sp,	#9
	ld	(hl), e
;source/default/userinterface.c:22: for(uint8_t i=0;i<digits-len;i++){
	ld	b, #0x00
00104$:
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl+), a
	xor	a, a
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
	ldhl	sp,	#15
	ld	(hl-), a
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, b
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#12
	ld	e, l
	ld	d, h
	ldhl	sp,	#14
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 00141$
	bit	7, d
	jr	NZ, 00142$
	cp	a, a
	jr	00142$
00141$:
	bit	7, d
	jr	Z, 00142$
	scf
00142$:
	jr	NC, 00101$
;source/default/userinterface.c:23: VBK_REG=1; set_bkg_tile_xy(x,y,0);
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
	push	bc
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#19
	ld	e, (hl)
	ld	a, c
	call	_set_bkg_tile_xy
	pop	bc
;source/default/userinterface.c:24: VBK_REG=0;set_bkg_tile_xy(x++,y,USERINTERFACE_TILES_START+42);
	xor	a, a
	ldh	(_VBK_REG + 0), a
	ld	a, c
	inc	c
	push	bc
	ld	h, #0x3b
	push	hl
	inc	sp
	ldhl	sp,	#19
	ld	e, (hl)
	call	_set_bkg_tile_xy
	pop	bc
;source/default/userinterface.c:22: for(uint8_t i=0;i<digits-len;i++){
	inc	b
	jr	00104$
00101$:
;source/default/userinterface.c:29: for(uint8_t i=0;i<len;i++){
	ld	b, #0x00
00107$:
	ld	a, b
	ldhl	sp,	#9
	sub	a, (hl)
	jr	NC, 00109$
;source/default/userinterface.c:31: VBK_REG=1;set_bkg_tile_xy(x,y,0);
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
	push	bc
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#19
	ld	e, (hl)
	ld	a, c
	call	_set_bkg_tile_xy
	pop	bc
;source/default/userinterface.c:32: VBK_REG=0;set_bkg_tile_xy(x++,y,(buffer[i]-'0')+USERINTERFACE_TILES_START+42);
	xor	a, a
	ldh	(_VBK_REG + 0), a
	ld	e, b
	ld	d, #0x00
	ld	hl, #0
	add	hl, sp
	add	hl, de
	ld	a, (hl)
	add	a, #0x0b
	ld	d, a
	ld	a, c
	inc	c
	push	bc
	push	de
	inc	sp
	ldhl	sp,	#19
	ld	e, (hl)
	call	_set_bkg_tile_xy
	pop	bc
;source/default/userinterface.c:29: for(uint8_t i=0;i<len;i++){
	inc	b
	jr	00107$
00109$:
;source/default/userinterface.c:34: }
	add	sp, #17
	pop	hl
	add	sp, #3
	jp	(hl)
;source/default/userinterface.c:37: void UpdateScore(){
;	---------------------------------
; Function UpdateScore
; ---------------------------------
_UpdateScore::
;source/default/userinterface.c:39: DrawNumber(16,2,topScore,4);
	ld	a, #0x04
	push	af
	inc	sp
	ld	a, (_topScore)
	ld	e, a
	ld	hl, #_topScore + 1
	ld	d, (hl)
	push	de
	ld	e, #0x02
	ld	a, #0x10
	call	_DrawNumber
;source/default/userinterface.c:40: DrawNumber(16,5,score,4);
	ld	a, #0x04
	push	af
	inc	sp
	ld	a, (_score)
	ld	e, a
	ld	hl, #_score + 1
	ld	d, (hl)
	push	de
	ld	e, #0x05
	ld	a, #0x10
	call	_DrawNumber
;source/default/userinterface.c:41: DrawNumber(17,10,stage+1,2);
	ld	a, (_stage)
	ld	b, #0x00
	ld	c, a
	inc	bc
	ld	a, #0x02
	push	af
	inc	sp
	push	bc
	ld	e, #0x0a
	ld	a, #0x11
	call	_DrawNumber
;source/default/userinterface.c:42: }
	ret
;source/default/userinterface.c:44: void ResetUserInterface(){
;	---------------------------------
; Function ResetUserInterface
; ---------------------------------
_ResetUserInterface::
;source/default/userinterface.c:47: set_bkg_based_tiles(0,0,20,18,UserInterface_map,USERINTERFACE_TILES_START);
;/opt/gbdk/include/gb/gb.h:1182: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x11
;/opt/gbdk/include/gb/gb.h:1183: set_bkg_tiles(x, y, w, h, tiles);
	ld	de, #_UserInterface_map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;/opt/gbdk/include/gb/gb.h:1184: _map_tile_offset = 0;
	xor	a, a
	ld	(#__map_tile_offset),a
;source/default/userinterface.c:49: UpdateScore();
;source/default/userinterface.c:50: }
	jp	_UpdateScore
;source/default/userinterface.c:52: void IncreaseScore(uint16_t amount){
;	---------------------------------
; Function IncreaseScore
; ---------------------------------
_IncreaseScore::
;source/default/userinterface.c:53: score+=amount;
	ld	hl, #_score
	ld	a, (hl)
	add	a, e
	ld	(hl+), a
	ld	a, (hl)
	adc	a, d
	ld	(hl), a
;source/default/userinterface.c:54: topScore =MAX(topScore,score);
	ld	de, #_score
	ld	hl, #_topScore
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00103$
	ld	a, (_topScore)
	ld	hl, #_topScore + 1
	ld	c, (hl)
	jr	00104$
00103$:
	ld	a, (_score)
	ld	hl, #_score + 1
	ld	c, (hl)
00104$:
	ld	hl, #_topScore
	ld	(hl+), a
	ld	(hl), c
;source/default/userinterface.c:55: UpdateScore();
;source/default/userinterface.c:56: }
	jp	_UpdateScore
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
