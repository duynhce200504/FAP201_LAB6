# FAP201 Lab06 – beginner-friendly reproducible reference package (V2)

## What is included?
- `src/lab06_game.vhd`: full seven-round Simon-like game core
- `src/key_conditioner.vhd`: 2-FF input synchronizer, debounce, one-pulse press
- `src/lab06_top_ledonly.vhd`: physical board path using 3 LEDs / 3 keys / 50 MHz
- `src/sevenseg_74hc595.vhd`: optional ACG525 74HC595 three-wire scoreboard adapter; assumptions must be verified
- `src/lab06_top_74hc595.vhd`: optional complete physical top with scoreboard
- `sim/lab06_game_tb.vhd`: self-checking win 1..7, prefix, replay, fail, multiple keys
- `sim/key_conditioner_tb.vhd`: self-checking debounce stimulus
- `scripts/run_sim.sh` and `scripts/run_sim.bat`: build and simulate with GHDL
- `constraints/*.cst.txt`: CANDIDATE ONLY, NEVER USE WITHOUT board schematic and course table
- `evidence/test_matrix.csv`: data collection form

## Simulation
- Windows: install GHDL with VHDL-2008 support and run `scripts\run_sim.bat`.
- MSYS2 UCRT64 / Linux: `bash scripts/run_sim.sh`.
- Expect note: `KEY_CONDITIONER_TB: ALL CHECKS PASS`
- Expect note: `LAB06_GAME_TB: ALL CHECKS PASS`
- Open `waveforms/lab06_game.ghw` in GTKWave.

## Board (do NOT skip safety checks)
1. Confirm exact ACG525 board revision and target `GW5A-LV25UG324C2/I1`.
2. Validate six LED/KEY pins + clock against official **course board GPIO** table.
3. Verify button and LED logical active polarity using a known-good Lab01 project.
4. Add only `key_conditioner.vhd`, `lab06_game.vhd`, `lab06_top_ledonly.vhd` as design files.
5. Synthesis top: `lab06_top_ledonly` (not a testbench).
6. Set G_STABLE_CYCLES=1000000, G_OFF_TICKS=15000000, G_SHOW_TICKS=20000000 for a verified 50MHz clock.
7. Assign verified GPIO pins, valid IO standards and 20 ns clock constraint in Gowin course version.
8. Synthesize, P&R, check I/O report/timing and only then program.
9. When displaying pattern, each LED flashes one after another. Once input phase starts, LEDs go OFF and student reproduces the pattern using matching buttons. After WIN or LOSE press KEY0 to replay.

## 7-segment display: STRICT validation gate
ACG525 pin table suggests 74HC595 (DS, SH_CP, ST_CP), not direct seven segment a-g outputs.
The adapter assumes chain order `{8-bit segments, 8-bit digit select}`, MSB-first, active-low segments and active-high digit select. These are **not independently hardware-tested**.
Use official board schematic / vendor working 7-seg demo to verify (a) chain order, (b) segment bit order, (c) active level, (d) timing, (e) board pin mapping before selecting optional top `lab06_top_74hc595`.
Do NOT call full Lab06 board test complete when only the LED-only path has been verified.

## HONEST VERIFICATION STATUS
The sources and expected behaviors were authored and reviewed statically. GHDL and Gowin are not installed in the authoring environment; no claim is made that compiled simulation, synthesis, bitstream generation, or physical board tests have already passed. Student/instructor must execute and record real evidence.
