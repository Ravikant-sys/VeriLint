module race_mod_3 (
    input clk,
    input [31:0] sig_in_3,
    output reg [31:0] sig_out_3
);
    // FIX: Use non-blocking assignment
    always @(negedge clk) begin
        sig_out_3 <= sig_in_3 + 1'b1;
    end
endmodule
