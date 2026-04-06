module race_mod_42 (
    input clk,
    input [63:0] sig_in_42,
    output reg [63:0] sig_out_42
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(negedge clk) begin
        sig_out_42 = sig_in_42 + 1'b1;
    end
endmodule
