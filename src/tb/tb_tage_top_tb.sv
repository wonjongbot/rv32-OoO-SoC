`include "../rtl/tage_t0.sv"
`include "../rtl/rv32-ooo_soc.svh"

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

  int fd, fetch_cnt, r, stats;

  logic [31:0] trace_pc;

  typedef struct{
    int pc;
    byte taken;
  } trace_t;


  trace_t trace;

  initial begin
    fetch_cnt = 0;
    fd = $fopen({`PROJECT_ROOT,"src/data/DIST-INT-1"}, "r");
    if (fd == 0) begin
      $display("ERR: COULD NOT OPEN FILE");
      $finish;
    end
  end

  initial begin
    #20 rst = 1;
    #10 rst = 0;
    #10;

    // TEST 1: GHR UPDATE TEST
    $display("\n----------\nTEST 1:GHR update test");
    update_valid = 1;
    update_taken = 1;
    #10 update_taken = 0;
    #10 update_taken = 0;
    #10 update_taken = 1;
    #10 update_taken = 1;
    #10 update_taken = 1;
    #10 if (debug_ghr != 32'h00000027)begin
      $display("MISMATCHING GHR");
    end
    else
      $display("GHR match");
    $display("----------");
    // END OF TEST 1

    // TEST 2
    /*
    r = $fread(stats, fd);
    if(r != 4 || r == 0) begin
      $display("END OF FILE, THIS PROBS SHOULDNT HAPPEN");
    end

    $display("%d instructions\n", stats);
    */

    while(!$feof(fd) && fetch_cnt < 10) begin
      // maybe read by chunks (in multiples of 4 bytes for performance -- read by 20 bytes?)
      r = $fread(trace, fd);
      if (r == 0) begin
        $display("END OF FILE! THIS REALLY SHOULDNT BE REACHED");
        break;
      end
      $display("pc: {%h} - taken: {%h}", trace.pc, trace.taken);
      trace_pc = {<<8{trace.pc}};
      $display("input to dut: %h", trace_pc);
      fetch_cnt++;
    end

    $display("%d instructions fetched", fetch_cnt);
    // END OF TEST 2

    $finish;


  end

endmodule
