#!/bin/bash

# Clean and recreate build directories
rm -rf bin dist
mkdir -p bin dist

# Run your graphics conversion shell script
./generate-graphics.sh

# Environment Setup
export GBDK_HOME="/opt/gbdk"
export HUGETRACKER_DIR="$GBDK_HOME/lib/hUGETracker_1_0b9/hUGEDriver"

# Compiler Base Command
LCC_COMPILE_BASE="$GBDK_HOME/bin/lcc -Iheaders/gen -Iheaders/main -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG"

# Track all compiled object files in a string variable
COMPILE_OBJECT_FILES=""
BUILD_FAILED=0

# 1. Compile all generated graphics source files
echo "--- Compiling generated assets ---"
while IFS= read -r file; do
  filename=$(basename "$file" .c)
  echo "Compiling $filename ..."

  if ! $LCC_COMPILE_BASE -c -o "bin/gen_${filename}.o" "$file"; then
    BUILD_FAILED=1
  fi
  COMPILE_OBJECT_FILES="bin/gen_${filename}.o $COMPILE_OBJECT_FILES"
done < <(find source/gen/ -type f -name "*.c")

# 2. Compile all default project source files
echo "--- Compiling main project source ---"
while IFS= read -r file; do
  filename=$(basename "$file" .c)
  echo "Compiling $filename ..."

  if ! $LCC_COMPILE_BASE -c -o "bin/${filename}.o" "$file"; then
    BUILD_FAILED=1
  fi
  COMPILE_OBJECT_FILES="bin/${filename}.o $COMPILE_OBJECT_FILES"
done < <(find source/default/ -type f -name "*.c")

# 3. Link everything together into the final .gb ROM ONLY if all .o files compiled
if [ $BUILD_FAILED -eq 0 ]; then
  echo "--- Linking ROM ---"
  if $LCC_COMPILE_BASE -Wm-yC -Wl-yt3 -Wl-yo4 -Wl-ya4 -o dist/BrickBreaker.gb $COMPILE_OBJECT_FILES; then
    # 4. Run romusage if available
    if [ -f "lib/romusage" ]; then
      ./lib/romusage dist/BrickBreaker.noi -a
    fi
    echo "🎉 Build Complete: dist/BrickBreaker.gb generated!"
  else
    echo "❌ Linking failed."
  fi
else
  echo "🛑 Build stopped: One or more source files have compilation errors. See above logs."
fi
