module race_mod_18 (
    input clk,
    input [15:0] sig_in_18,
    output reg [15:0] sig_out_18
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(negedge clk) begin
        sig_out_18 = sig_in_18 + 1'b1;
    end
endmodule
