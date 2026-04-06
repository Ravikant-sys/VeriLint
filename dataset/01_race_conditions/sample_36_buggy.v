module race_mod_36 (
    input clk,
    input [3:0] sig_in_36,
    output reg [3:0] sig_out_36
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(posedge clk) begin
        sig_out_36 = sig_in_36 + 1'b1;
    end
endmodule
