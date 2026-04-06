module race_mod_5 (
    input clk,
    input [7:0] sig_in_5,
    output reg [7:0] sig_out_5
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(negedge clk) begin
        sig_out_5 = sig_in_5 + 1'b1;
    end
endmodule
