module race_mod_25 (
    input clk,
    input [3:0] sig_in_25,
    output reg [3:0] sig_out_25
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(negedge clk) begin
        sig_out_25 = sig_in_25 + 1'b1;
    end
endmodule
