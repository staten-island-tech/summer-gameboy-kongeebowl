#!/bin/bash

# Ensure target directories exist before running tools
mkdir -p source/gen/graphics
mkdir -p headers/gen/graphics

# Function to safely run png2asset only if the file exists and is valid
run_png2asset() {
  local input_file="$1"
  shift # Remove the first argument, leaving the rest for png2asset

  if [ ! -f "$input_file" ]; then
    echo "❌ ERROR: File does not exist -> $input_file"
    return 1
  elif [ ! -s "$input_file" ]; then
    echo "❌ ERROR: File is empty (0 bytes) -> $input_file"
    return 1
  fi

  # Run the compiler tool
  /opt/gbdk/bin/png2asset "$input_file" "$@"
}

# Sprites
echo "Processing sprites..."
run_png2asset graphics/paddle.png -c source/gen/graphics/paddle.c -sw 32 -sh 8 -spr8x8 -keep_palette_order -noflip
run_png2asset graphics/Ball.png -c source/gen/graphics/ball.c -sw 8 -sh 8 -spr8x8 -keep_palette_order -noflip

# Background Tiles
echo "Processing backgrounds..."
run_png2asset graphics/UserInterface.png -c source/gen/graphics/UserInterface.c -map -use_map_attributes -keep_palette_order -noflip
run_png2asset graphics/Bricks.png -c source/gen/graphics/Bricks.c -map -use_map_attributes -keep_palette_order -noflip
run_png2asset graphics/Font.png -c source/gen/graphics/Font.c -map -use_map_attributes -keep_palette_order -noflip

# Move .h files to their proper location after generation completes
find source/gen/graphics/ -type f -name "*.h" -exec mv {} headers/gen/graphics/ \;

echo "Execution finished. Check above for any ❌ errors!"
