module race_mod_41 (
    input clk,
    input [3:0] sig_in_41,
    output reg [3:0] sig_out_41
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(posedge clk) begin
        sig_out_41 = sig_in_41 + 1'b1;
    end
endmodule
