# Makefile
PROJECT_ROOT := /home/wonjongbot/rv32-OoO-SoC

#defaults
SIM ?= questa
TOPLEVEL_LANG ?= verilog

export PYTHONPATH := /home/wonjongbot/rv32-OoO-SoC/src/tb:$(PYTHONPATH)

VERILOG_SOURCES += /home/wonjongbot/rv32-OoO-SoC/src/rtl/tage_top.sv

TOPLEVEL = tage_top

MODULE = tb_tage_top

#SIM_BUILD = /home/wonjongbot/rv32-OoO-SoC/src/tb/sim_build

#SIM_ARGS += -pli $(shell cocotb-config --lib-name-path vpi questa)

WAVES=1
SIM_ARGS += "-voptargs=+acc=npr"
SIM_BUILD = /home/wonjongbot/rv32-OoO-SoC/sim_build

RESULTS_FILE := /home/wonjongbot/rv32-OoO-SoC/logs/results.xml
TRANSCRIPT_FILE := /home/wonjongbot/rv32-OoO-SoC/logs/transcript
WAVEFORM_FILE := /home/wonjongbot/rv32-OoO-SoC/waves/waveform.wlf
#VSIM_ARGS += -modelsimini $(PROJECT_ROOT)/config/modelsim.ini
#SIM_ARGS += -logfile $(TRANSCRIPT_FILE)
SIM_ARGS += -wlf $(WAVEFORM_FILE)

export COCOTB_RESULTS_FILE = $(RESULTS_FILE)


#VCD_NAME=my_waveform.vcd
#SIM_ARGS="-vcdfile my_waveform.vcd -vcdfileopt=on"

# Custom target to run the simulation and convert WLF to VCD
.PHONY: vcd
include $(shell cocotb-config --makefiles)/Makefile.sim

vcd: all
	wlf2vcd vsim.wlf -o vsim.vcd