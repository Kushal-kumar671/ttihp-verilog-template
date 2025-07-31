![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# 12-Hour Digital Clock — Tiny Tapeout Project

- [📝 Project Documentation](docs/info.md)

## What is Tiny Tapeout?

Tiny Tapeout is an educational project that makes it easier and cheaper than ever to get your digital and analog designs manufactured on a real chip.

To learn more and get started, visit [tinytapeout.com](https://tinytapeout.com).

## 🕒 About This Project

This project implements a **12-hour digital clock** in Verilog with AM/PM tracking. The core logic counts seconds, minutes, and hours in a traditional 12-hour format and flips the AM/PM bit every 12 hours.

### Features

- 12-hour time format (1–12)
- AM/PM output
- Resettable time
- Wrapper module for Tiny Tapeout compatibility

## 🛠️ Set Up Your Verilog Project

1. Add your Verilog files to the `src` folder:
   - `clock_12h.v`
   - `tt_um_clock_12h_wrapper.v`

2. Edit [`info.yaml`](info.yaml) to:
   - Set the correct `top_module`: `tt_um_clock_12h_wrapper`
   - Add the above source files under `source_files`
   - Set pinout mappings (e.g., `ui[0]` = clk, `ui[1]` = rst, etc.)

3. Edit [`docs/info.md`](docs/info.md) to describe how your clock works.

4. Adapt or write a new testbench in [`test/test.py`](test/test.py) using cocotb:
   - Simulates toggling clock
   - Monitors `uo_out` to decode time and AM/PM state

To simulate locally, run:

```bash
cd test
make
