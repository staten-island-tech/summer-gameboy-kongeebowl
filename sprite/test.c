#include "smirk.h"
#include <gb/gb.h>

int main() {
  SPRITES_8x16;
  set_sprite_data(0, 8, smirk);
  set_sprite_tile(0, 0);
  move_sprite(0, 75, 75);
  SHOW_SPRITES;
  return 0;
}
