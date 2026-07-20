;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.6.0 #16555 (Linux)
;--------------------------------------------------------
	.module test
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _set_sprite_data
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute ram data
;--------------------------------------------------------
	.area _DABS (ABS)
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
;test.c:4: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;test.c:5: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x04
	ldh	(_LCDC_REG + 0), a
;test.c:6: set_sprite_data(0, 8, smirk);
	ld	de, #_smirk
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;/usr/share/gbdk-2020/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #_shadow_OAM+2
	ld	(hl), #0x00
;/usr/share/gbdk-2020/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM+0
;/usr/share/gbdk-2020/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x4b
	ld	(hl+), a
	ld	(hl), #0x4b
;test.c:9: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;test.c:10: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
