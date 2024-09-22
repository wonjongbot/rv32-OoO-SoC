`include "../rtl/tage_t0.sv"
`timescale 1ns/1ns 

module tb_tage_t0;
  
  logic clk;
  logic [31:0] branch_pc;
  logic [31:0] update_pc;
  logic update_valid;
  logic update_taken;
  logic [1:0] update_pred;
  logic [1:0] branch_pred;
  
  tage_t0 dut (.*);
  
  initial begin
    clk = 0;
    
    branch_pc = 0;
    update_pc = 0;
    update_valid = 0;
    update_taken = 0;
    update_pred = 0;
  end
  
  always #5 clk = ~clk;
  
  initial begin
    // $dumpfile("dump.vcd");
    // $dumpvars(1);
    #20
    
    // for (int i = 0; i < 100; i++) begin
    //   a = $urandom;
    // end
    
    $display("PC = %h, branch_pred = %b", branch_pc, branch_pred);
    #5
    
    update_valid = 1;
    update_pc = branch_pc;
    update_taken = 1;
    update_pred = branch_pred;
    #5
    update_valid = 0;
    #10
    
    branch_pc = 0;
    #5
    $display("PC = %h, branch_pred = %b", branch_pc, branch_pred);
    
    $finish;
  	end
  
  
endmodule