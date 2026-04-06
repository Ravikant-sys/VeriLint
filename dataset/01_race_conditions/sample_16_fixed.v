module race_mod_16 (
    input clk,
    input [31:0] sig_in_16,
    output reg [31:0] sig_out_16
);
    // FIX: Use non-blocking assignment
    always @(negedge clk) begin
        sig_out_16 <= sig_in_16 + 1'b1;
    end
endmodule
