module race_mod_2 (
    input clk,
    input [31:0] sig_in_2,
    output reg [31:0] sig_out_2
);
    // FIX: Use non-blocking assignment
    always @(negedge clk) begin
        sig_out_2 <= sig_in_2 + 1'b1;
    end
endmodule
