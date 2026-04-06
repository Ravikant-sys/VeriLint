module race_mod_14 (
    input clk,
    input [15:0] sig_in_14,
    output reg [15:0] sig_out_14
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(posedge clk) begin
        sig_out_14 = sig_in_14 + 1'b1;
    end
endmodule
