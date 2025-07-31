# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_clock_12h_wrapper(dut):
    dut._log.info("Starting 12h Clock Wrapper Test")

    # Internal clock: 100 KHz (10 us period)
    cocotb.start_soon(Clock(dut.clk, 10, units="us").start())

    # Initialize inputs
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    # Apply reset (active low)
    dut._log.info("Applying reset...")
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1
    dut._log.info("Reset released")

    # Pulse ui_in[0] as internal clock for DUT
    dut.ui_in.value = 0b00000000  # clk=0, rst=0
    await ClockCycles(dut.clk, 1)

    for cycle in range(10000):  # Simulate ~10,000 ticks
        dut.ui_in.value = dut.ui_in.value ^ 0b00000001  # Toggle clk bit (ui_in[0])
        await ClockCycles(dut.clk, 1)

        hour = int(dut.uo_out.value & 0x0F)
        am_pm = int((dut.uo_out.value >> 4) & 0x01)

        dut._log.info(f"Cycle {cycle:05d} → Hour: {hour:02d} {'PM' if am_pm else 'AM'}")

        # Optional check: ensure hour is in [1, 12]
        assert 1 <= hour <= 12, f"Invalid hour {hour} at cycle {cycle}"

    dut._log.info("✅ 12h clock simulation completed successfully")
