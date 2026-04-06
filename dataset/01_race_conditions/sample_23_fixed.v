module race_mod_23 (
    input clk,
    input [31:0] sig_in_23,
    output reg [31:0] sig_out_23
);
    // FIX: Use non-blocking assignment
    always @(negedge clk) begin
        sig_out_23 <= sig_in_23 + 1'b1;
    end
endmodule
