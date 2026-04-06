module race_mod_10 (
    input clk,
    input [31:0] sig_in_10,
    output reg [31:0] sig_out_10
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(posedge clk) begin
        sig_out_10 = sig_in_10 + 1'b1;
    end
endmodule
