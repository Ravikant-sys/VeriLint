module race_mod_39 (
    input clk,
    input [3:0] sig_in_39,
    output reg [3:0] sig_out_39
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(negedge clk) begin
        sig_out_39 = sig_in_39 + 1'b1;
    end
endmodule
