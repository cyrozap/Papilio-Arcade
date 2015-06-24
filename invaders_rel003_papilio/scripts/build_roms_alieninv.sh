#!/bin/bash

# SHA1 sums of files required
# 8adcb7cd4492fa6649d9ee81172d8dff56621d64 *1e.bin
# 7e02651692113db31fd469868ae5ffdb0f941ecf *1f.bin
# b693667656e5d8f44eeb2ea730f4d4db436da579 *1g.bin
# eec34b3d5585bae03c7b80585daaa05ddfcc2164 *1h.bin

ROM_PATH_SRC="../roms/alieninv"
ROM_PATH="../build"
ROMGEN_PATH="../romgen_source"

# concatenate consecutive ROM regions
cat $ROM_PATH_SRC/1h.bin $ROM_PATH_SRC/1g.bin $ROM_PATH_SRC/1f.bin $ROM_PATH_SRC/1e.bin > $ROM_PATH/invaders_rom.bin

# generate RAMB structures for larger ROMS
$ROMGEN_PATH/romgen $ROM_PATH/invaders_rom.bin INVADERS_ROM 13 l r e > $ROM_PATH/invaders_rom.vhd

echo done
