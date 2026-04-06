module race_mod_21 (
    input clk,
    input [63:0] sig_in_21,
    output reg [63:0] sig_out_21
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(posedge clk) begin
        sig_out_21 = sig_in_21 + 1'b1;
    end
endmodule
