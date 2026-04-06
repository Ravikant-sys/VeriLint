module race_mod_29 (
    input clk,
    input [31:0] sig_in_29,
    output reg [31:0] sig_out_29
);
    // FIX: Use non-blocking assignment
    always @(negedge clk) begin
        sig_out_29 <= sig_in_29 + 1'b1;
    end
endmodule
