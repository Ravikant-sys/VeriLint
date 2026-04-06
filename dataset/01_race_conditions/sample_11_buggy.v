module race_mod_11 (
    input clk,
    input [63:0] sig_in_11,
    output reg [63:0] sig_out_11
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(posedge clk) begin
        sig_out_11 = sig_in_11 + 1'b1;
    end
endmodule
