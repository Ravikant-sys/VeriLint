module race_mod_20 (
    input clk,
    input [7:0] sig_in_20,
    output reg [7:0] sig_out_20
);
    // FIX: Use non-blocking assignment
    always @(negedge clk) begin
        sig_out_20 <= sig_in_20 + 1'b1;
    end
endmodule
