module race_mod_7 (
    input clk,
    input [3:0] sig_in_7,
    output reg [3:0] sig_out_7
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(posedge clk) begin
        sig_out_7 = sig_in_7 + 1'b1;
    end
endmodule
