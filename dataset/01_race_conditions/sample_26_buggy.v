module race_mod_26 (
    input clk,
    input [15:0] sig_in_26,
    output reg [15:0] sig_out_26
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(posedge clk) begin
        sig_out_26 = sig_in_26 + 1'b1;
    end
endmodule
