module race_mod_13 (
    input clk,
    input [15:0] sig_in_13,
    output reg [15:0] sig_out_13
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(posedge clk) begin
        sig_out_13 = sig_in_13 + 1'b1;
    end
endmodule
