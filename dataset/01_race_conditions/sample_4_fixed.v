module race_mod_4 (
    input clk,
    input [7:0] sig_in_4,
    output reg [7:0] sig_out_4
);
    // FIX: Use non-blocking assignment
    always @(negedge clk) begin
        sig_out_4 <= sig_in_4 + 1'b1;
    end
endmodule
