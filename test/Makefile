# Makefile for 12-hour clock project simulation using cocotb
# More info: https://docs.cocotb.org/en/stable/quickstart.html

# Default simulator and language
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Source directory (relative to test dir)
SRC_DIR = $(PWD)/../src

# List all source files here (Verilog)
PROJECT_SOURCES = \
  clock_12h.v \
  tt_um_clock_12h_wrapper.v

# Output directory for simulation builds
SIM_BUILD = sim_build/rtl

# Compile arguments and sources for RTL simulation
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/, $(PROJECT_SOURCES))

# Testbench Verilog (if any, else remove)
VERILOG_SOURCES += $(PWD)/tb.v  # Optional: remove if only using cocotb test.py

# Top-level module (Verilog testbench or DUT wrapper)
TOPLEVEL = tt_um_clock_12h_wrapper

# Name of the Python test file (without .py extension)
MODULE = test

# Extra compile args if needed
COMPILE_ARGS += -I$(SRC_DIR)

# Include cocotb build system
include $(shell cocotb-config --makefiles)/Makefile.sim
