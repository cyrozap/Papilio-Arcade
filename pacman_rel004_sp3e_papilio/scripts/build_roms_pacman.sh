#!/bin/bash

# SHA1 sums of files required
# 8d0268dee78e47c712202b0ec4f1f51109b1f2a5 *82s123.7f
# bbcec0570aeceb582ff8238a4bc8546a23430081 *82s126.1m
# 0c4d0bee858b97632411c440bea6948a74759746 *82s126.3m
# 19097b5f60d1030f8b82d9f1d3a241f93e5c75d6 *82s126.4a
# 87117ba5082cd7a615b4ec7c02dd819003fbd669 *namcopac.6e
# 326dbbf94c6fa2e96613dedb53702f8832b47d59 *namcopac.6f
# 7e1945f6eb51f2e51806d0439f975f7a2889b9b8 *namcopac.6h
# 01b4c38108d9dc4e48da4f8d685248e1e6821377 *namcopac.6j
# 06ef227747a440831c9a3a613b76693d52a2f0a9 *pacman.5e
# 4a937ac02216ea8c96477d4a15522070507fb599 *pacman.5f

ROM_PATH_SRC="../roms/pacman"
ROM_PATH="../build"
ROMGEN_PATH="../romgen_source"

# concatenate consecutive ROM regions
cat $ROM_PATH_SRC/pacman.5e $ROM_PATH_SRC/pacman.5f > $ROM_PATH/gfx1.bin
cat $ROM_PATH_SRC/namcopac.6e $ROM_PATH_SRC/namcopac.6f $ROM_PATH_SRC/namcopac.6h $ROM_PATH_SRC/namcopac.6j > $ROM_PATH/main.bin

# generate RTL code for small PROMS
$ROMGEN_PATH/romgen $ROM_PATH_SRC/82s126.1m     PROM1_DST  9 l r e     > $ROM_PATH/prom1_dst.vhd
$ROMGEN_PATH/romgen $ROM_PATH_SRC/82s126.4a     PROM4_DST  8 l r e     > $ROM_PATH/prom4_dst.vhd
$ROMGEN_PATH/romgen $ROM_PATH_SRC/82s123.7f     PROM7_DST  4 l r e     > $ROM_PATH/prom7_dst.vhd
# $ROMGEN_PATH/romgen $ROM_PATH_SRC/82s126.1m     PROM1_DST  9 c     > $ROM_PATH/prom1_dst.vhd
# $ROMGEN_PATH/romgen $ROM_PATH_SRC/82s126.4a     PROM4_DST  8 c     > $ROM_PATH/prom4_dst.vhd
# $ROMGEN_PATH/romgen $ROM_PATH_SRC/82s123.7f     PROM7_DST  4 c     > $ROM_PATH/prom7_dst.vhd

# generate RAMB structures for larger ROMS
$ROMGEN_PATH/romgen $ROM_PATH/gfx1.bin          GFX1      13 l r e > $ROM_PATH/gfx1.vhd
$ROMGEN_PATH/romgen $ROM_PATH/main.bin          ROM_PGM_0 14 l r e > $ROM_PATH/rom0.vhd

# this is ROM area not used but required
$ROMGEN_PATH/romgen $ROM_PATH/gfx1.bin          ROM_PGM_1 13 l r e > $ROM_PATH/rom1.vhd

echo done
