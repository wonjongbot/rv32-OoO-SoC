`include "rv32-ooo_soc.svh"

module imem #(parameter IMEM_SIZE = 256,
             parameter IMEM_WORDSIZE = 32)(
  input  logic        clk,
  input  logic [31:0] addr1,
  input  logic [31:0] addr2,
  output logic [IMEM_WORDSIZE - 1:0] instr1,
  output logic [IMEM_WORDSIZE - 1:0] instr2
);

  parameter IMEM_ADDR_WIDTH = $clog2(IMEM_SIZE);

  logic [IMEM_ADDR_WIDTH-1:0] index1;
  logic [IMEM_ADDR_WIDTH-1:0] index2;

  assign index1 = addr1[IMEM_ADDR_WIDTH+1:2];
  assign index2 = addr2[IMEM_ADDR_WIDTH+1:2];

  // Instruction memory array
  logic [IMEM_WORDSIZE - 1:0] imem [0:IMEM_SIZE-1];

  // Initialize instruction memory from a file (optional)
  initial begin
    $readmemh({`PROJECT_ROOT, "src/data/imem_init.hex"}, imem);
  end

  always_ff @(posedge clk) begin
    instr1 <= imem[index1];
    instr2 <= imem[index2];
  end
endmodule
