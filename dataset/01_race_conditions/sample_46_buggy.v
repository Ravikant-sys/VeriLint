module race_mod_46 (
    input clk,
    input [7:0] sig_in_46,
    output reg [7:0] sig_out_46
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(posedge clk) begin
        sig_out_46 = sig_in_46 + 1'b1;
    end
endmodule
