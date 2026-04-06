module race_mod_19 (
    input clk,
    input [15:0] sig_in_19,
    output reg [15:0] sig_out_19
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(negedge clk) begin
        sig_out_19 = sig_in_19 + 1'b1;
    end
endmodule
