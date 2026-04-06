module race_mod_15 (
    input clk,
    input [31:0] sig_in_15,
    output reg [31:0] sig_out_15
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(posedge clk) begin
        sig_out_15 = sig_in_15 + 1'b1;
    end
endmodule
