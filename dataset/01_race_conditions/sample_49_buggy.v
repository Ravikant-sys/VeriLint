module race_mod_49 (
    input clk,
    input [7:0] sig_in_49,
    output reg [7:0] sig_out_49
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(negedge clk) begin
        sig_out_49 = sig_in_49 + 1'b1;
    end
endmodule
