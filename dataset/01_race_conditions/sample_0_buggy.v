module race_mod_0 (
    input clk,
    input [63:0] sig_in_0,
    output reg [63:0] sig_out_0
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(negedge clk) begin
        sig_out_0 = sig_in_0 + 1'b1;
    end
endmodule
