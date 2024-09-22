`include "rv32-ooo_soc.svh"

module dual_port_ram
  #(
    parameter num_entries = 512,
    parameter addr_width = $clog2(num_entries),
    parameter data_width = 2
  )(
    input we, clk,
    input [addr_width-1:0] waddr, raddr,
    input [data_width-1:0] wdata,
    output reg [data_width-1:0] q
  );
  reg [data_width-1:0] mem [0:num_entries-1];
  
  initial begin
    $readmemb({`PROJECT_ROOT, "src/data/tage_t0_init.bin"}, mem);
  end
  
  always @(posedge clk)
    begin
      if(we)
        mem[waddr] <= wdata;
      q<=mem[raddr];
    end
endmodule