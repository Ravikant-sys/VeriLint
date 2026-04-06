module race_mod_31 (
    input clk,
    input [15:0] sig_in_31,
    output reg [15:0] sig_out_31
);
    // FIX: Use non-blocking assignment
    always @(negedge clk) begin
        sig_out_31 <= sig_in_31 + 1'b1;
    end
endmodule
