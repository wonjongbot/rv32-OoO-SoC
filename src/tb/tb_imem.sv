`include "../rtl/imem.sv"

module imem_tb;
    // Parameters matching the imem module
    parameter IMEM_SIZE = 16;
    parameter IMEM_WORDSIZE = 32;


    // Testbench signals
    logic        clk;
    logic [31:0] addr1;
    logic [31:0] addr2;
    logic [IMEM_WORDSIZE - 1:0] instr1;
    logic [IMEM_WORDSIZE - 1:0] instr2;

    // Instantiate the imem module
    imem #(
      .IMEM_SIZE(IMEM_SIZE),
      .IMEM_WORDSIZE(IMEM_WORDSIZE)
    ) uut (
        .clk(clk),
        .addr1(addr1),
        .addr2(addr2),
        .instr1(instr1),
        .instr2(instr2)
    );

    // Clock generation (not strictly necessary here but included for completeness)
    initial clk = 0;
    always #5 clk = ~clk; // 100MHz clock frequency

    // Test sequence
    initial begin
      /*
        // Initialize instruction memory directly (alternative to using $readmemh)
        // This step is optional if you're using the $readmemh with a file
        uut.imem[0] = 32'hdeadbeef;
        uut.imem[1] = 32'h0a0a0a0a;
        uut.imem[2] = 32'h0b0b0b0b;
        uut.imem[3] = 32'h12345678;
        */

        // Wait for the memory initialization (if needed)
        #10;

      for (int i = 0; i < 8; i++) 
        begin
          addr1 = 32'h0000_0000 + i*8;
          addr2 = addr1 + 4;
          #10
          // Display fetched instructions
          $display("Test Case %d:",i);
          $display("Time: %0t ns, addr1: %h, instr1: %h", $time, addr1, instr1);
          $display("Time: %0t ns, addr2: %h, instr2: %h", $time, addr2, instr2);
          $display("");
        end

        // End of simulation
        #10
        $finish;
    end

endmodule
