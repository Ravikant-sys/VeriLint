module race_mod_17 (
    input clk,
    input [31:0] sig_in_17,
    output reg [31:0] sig_out_17
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(negedge clk) begin
        sig_out_17 = sig_in_17 + 1'b1;
    end
endmodule
