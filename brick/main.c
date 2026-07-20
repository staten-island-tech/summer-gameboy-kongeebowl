#include "gb/hardware.h"
#include <gb/gb.h>
int main(void) {

  DISPLAY_ON;
  SHOW_SPRITES;
  SHOW_BKG;
  SPRITES_8x8;

  NR52_REG = 0x80;
  NR51_REG = 0xFF;
  NR50_REG = 0x77;

  set_sprite_palette(0, 1, BlackAndWhitePalette);
  set_bkg_palette(0, 1, BlackAndWhitePalette);

  set_bkg_data(0, Bricks_TILE_COUNT, Bricks_tiles);
  set_bkg_data(USERINTERFACE_TILES_START, UserInterface_TILE_COUNT,
               UserInterface_tiles);
  set_bkg_data(FONT_TILES_START, Font_TILE_COUNT, Font_tiles);

  set_sprite_data(0, paddle_TILE_COUNT, paddle_tiles);
  set_sprite_data(paddle_TILE_COUNT, ball_TILE_COUNT, ball_tiles);
  return 0;
}
