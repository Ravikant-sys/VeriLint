module race_mod_1 (
    input clk,
    input [15:0] sig_in_1,
    output reg [15:0] sig_out_1
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(posedge clk) begin
        sig_out_1 = sig_in_1 + 1'b1;
    end
endmodule
