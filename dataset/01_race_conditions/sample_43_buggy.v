module race_mod_43 (
    input clk,
    input [31:0] sig_in_43,
    output reg [31:0] sig_out_43
);
    // BUG: Mixing blocking assignment in sequential logic
    always @(posedge clk) begin
        sig_out_43 = sig_in_43 + 1'b1;
    end
endmodule
