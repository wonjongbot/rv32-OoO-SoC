// todo: test out the functinality of ghr
// set up infra to test predictor with trace
module tage_top (
    input logic clk, rst,
    input logic [31:0] update_pc,
    input logic [31:0] branch_pc,
    input logic update_valid,
    input logic update_taken,
    input logic [1:0] update_pred,
    output logic [1:0] branch_pred,

    output logic [31:0] debug_ghr
);
  logic [31:0] ghr;
  logic [1:0] ghr_t0;

  assign ghr_t0 = ghr[1:0];

  assign debug_ghr = ghr;

  tage_t0 t0 (
    .clk(clk),
    .rst(rst),
    .ghr_t0(ghr_t0),
    .branch_pc(branch_pc),
    .update_pc(update_pc),
    .update_valid(update_valid),
    .update_taken(update_taken),
    .update_pred(update_pred),
    .branch_pred(branch_pred)
  );

  // ghr update logic
  always_ff @(posedge clk)begin
    ghr <= ghr;
    if(rst)
      ghr <= 32'b0;
    else begin
      if(update_valid)begin
        if(update_taken)
          ghr <= {ghr[30:0], 1'b1};
        else
          ghr <= {ghr[30:0], 1'b0};
      end
    end
  end
endmodule
