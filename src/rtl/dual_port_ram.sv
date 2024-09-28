`include "/home/wonjongbot/rv32-OoO-SoC/src/rtl/rv32-ooo_soc.svh"

module dual_port_ram #(
    parameter num_entries = 512,
    parameter addr_width  = $clog2(num_entries),
    parameter data_width  = 2
) (
    input we, clk, rst,
    input [addr_width-1:0] waddr, raddr,
    input [data_width-1:0] wdata,
    output reg [data_width-1:0] q
);
  reg [data_width-1:0] mem [num_entries];

  initial begin
    //$readmemb({`PROJECT_ROOT, "src/data/tage_t0_init.bin"}, mem);
    for(int i = 0; i < 1024; i++)begin
      mem[waddr] = 0;
    end
  end

  always @(posedge clk) begin
    if(rst)
      q<= 0;
    else begin
      if (we) mem[waddr] <= wdata;
      q <= mem[raddr];
    end
  end
endmodule
