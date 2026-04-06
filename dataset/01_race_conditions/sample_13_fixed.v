module race_mod_13 (
    input clk,
    input [15:0] sig_in_13,
    output reg [15:0] sig_out_13
);
    // FIX: Use non-blocking assignment
    always @(posedge clk) begin
        sig_out_13 <= sig_in_13 + 1'b1;
    end
endmodule
