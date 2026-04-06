module race_mod_8 (
    input clk,
    input [7:0] sig_in_8,
    output reg [7:0] sig_out_8
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(posedge clk) begin
        sig_out_8 = sig_in_8 + 1'b1;
    end
endmodule
