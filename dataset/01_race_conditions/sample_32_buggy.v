module race_mod_32 (
    input clk,
    input [15:0] sig_in_32,
    output reg [15:0] sig_out_32
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(negedge clk) begin
        sig_out_32 = sig_in_32 + 1'b1;
    end
endmodule
