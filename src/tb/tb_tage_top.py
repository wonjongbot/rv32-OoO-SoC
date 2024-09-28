# tb_tage_top.py (testing ghr)

import cocotb
from cocotb.triggers import Timer


async def generate_clock(dut):
	"""Generate clock pulses."""

	for cycle in range(100):
		dut.clk.value = 0
		await Timer(5, units="ns")
		dut.clk.value = 1
		await Timer(5, units="ns")


@cocotb.test()
async def my_first_test(dut):
	# define ports
	clk_i = dut.clk
	rst_i = dut.rst
	update_pc_i = dut.update_pc
	branch_pc_i = dut.branch_pc
	update_valid_i = dut.update_valid
	update_taken_i = dut.update_taken
	update_pred_i = dut.update_pred
	branch_pred_o = dut.branch_pred
	debug_ghr_o = dut.debug_ghr

	ghr_in = dut.t0.ghr_t0

	# initialize input values
	rst_i.value = 0
	branch_pc_i.value = 0
	update_pc_i.value = 0
	update_valid_i.value = 0
	update_taken_i.value = 0
	update_pred_i.value = 0

	await cocotb.start(generate_clock(dut))

	await Timer(20, units="ns")
	rst_i.value = 1
	await Timer(10, units="ns")
	rst_i.value = 0
	await Timer(10, units="ns")

	print("TEST 1: GHR update test")
	update_valid_i.value = 1
	update_taken_i.value = 1
	await Timer(10, units="ns")
	update_taken_i.value = 0
	await Timer(10, units="ns")
	update_taken_i.value = 0
	await Timer(10, units="ns")
	update_taken_i.value = 1
	await Timer(10, units="ns")
	update_taken_i.value = 1
	await Timer(10, units="ns")
	update_taken_i.value = 1
	await Timer(10, units="ns")

	dut._log.info("ghr = %s", debug_ghr_o.value.binstr)
	print("GHRT0 = %s", ghr_in.value.binstr)
	assert debug_ghr_o.value == 0x00000027

