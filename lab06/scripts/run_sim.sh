#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p build waveforms
cd build
ghdl -a --std=08 ../src/key_conditioner.vhd ../src/lab06_game.vhd ../src/sevenseg_74hc595.vhd ../src/lab06_top_ledonly.vhd ../src/lab06_top_74hc595.vhd \
    ../sim/key_conditioner_tb.vhd ../sim/lab06_game_tb.vhd
ghdl -e --std=08 key_conditioner_tb
ghdl -r --std=08 key_conditioner_tb --wave=../waveforms/key_conditioner.ghw
ghdl -e --std=08 lab06_game_tb
ghdl -r --std=08 lab06_game_tb --wave=../waveforms/lab06_game.ghw
printf '\nSUCCESS: inspect PASS messages and waveforms/*.ghw\n'
