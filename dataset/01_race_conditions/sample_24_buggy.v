module race_mod_24 (
    input clk,
    input [7:0] sig_in_24,
    output reg [7:0] sig_out_24
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(posedge clk) begin
        sig_out_24 = sig_in_24 + 1'b1;
    end
endmodule
