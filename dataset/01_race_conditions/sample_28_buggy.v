module race_mod_28 (
    input clk,
    input [3:0] sig_in_28,
    output reg [3:0] sig_out_28
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(posedge clk) begin
        sig_out_28 = sig_in_28 + 1'b1;
    end
endmodule
