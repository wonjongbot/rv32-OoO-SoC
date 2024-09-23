`include "dual_port_ram.sv"

module tage_t0 (
    input clk, rst,
    input logic [1:0] ghr_t0,
    input logic [31:0] branch_pc,
    input logic [31:0] update_pc,
    input logic update_valid,
    input logic update_taken,
    input logic [1:0] update_pred,
    output logic [1:0] branch_pred
);
  logic we;

  logic [9:0] raddr, waddr;
  logic [1:0] wdata, q;

  assign raddr = {ghr_t0, branch_pc[7:0]};
  assign waddr = {ghr_t0, update_pc[7:0]};

  // bypass when branch_pc == update_pc
  assign branch_pred = (rst) ? 0 : (raddr == waddr) ? wdata : q;
  //assign we = update_valid;

  parameter num_entries = 1024;
  parameter addr_width = $clog2(num_entries);
  parameter data_width = 2;
  // [2 valid bit][1:0 predicton bits]

  always_comb begin
    we = 0;
    wdata = 0;
    if (update_valid) begin
      we = 1;
      case (update_pred)
        2'b00:   wdata = (update_taken) ? update_pred + 1 : update_pred;
        2'b01:   wdata = (update_taken) ? update_pred + 1 : update_pred - 1;
        2'b10:   wdata = (update_taken) ? update_pred + 1 : update_pred - 1;
        2'b11:   wdata = (update_taken) ? update_pred : update_pred - 1;
        default: ;
      endcase
    end
  end

  dual_port_ram #(
      .num_entries(num_entries),
      .addr_width (addr_width),
      .data_width (data_width)
  ) ptable (
      .clk(clk),
      .rst(rst),
      .we(we),
      .raddr(raddr),
      .waddr(waddr),
      .wdata(wdata),
      .q(q)
  );
endmodule
