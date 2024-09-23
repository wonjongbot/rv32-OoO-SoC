`include "../rtl/tage_t0.sv"
`timescale 1ns/1ns

module tb_tage_top_tb;

  logic clk, rst;
  logic [31:0] update_pc;
  logic [31:0] branch_pc;
  logic update_valid;
  logic update_taken;
  logic [1:0] update_pred;
  logic [1:0] branch_pred;

  logic [31:0] debug_ghr;

  tage_top dut (.*);

  initial begin
      clk = 0;
  end

  always #5 clk = ~clk;

  initial begin
    rst = 0;
    branch_pc = 0;
    update_pc = 0;
    update_valid = 0;
    update_taken = 0;
    update_pred = 0;
  end

  initial begin
    #20 rst = 1;
    #10 rst = 0;
    #10;

    update_valid = 1;
    update_taken = 1;
    #10 update_taken = 0;
    #10 update_taken = 0;
    #10 update_taken = 1;
    #10 update_taken = 1;
    #10 update_taken = 1;

    $display("GHR: %b", debug_ghr);
    #10 $display("GHR: %b", debug_ghr);

    $finish;


  end

endmodule
