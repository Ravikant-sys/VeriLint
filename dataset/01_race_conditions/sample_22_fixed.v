module race_mod_22 (
    input clk,
    input [31:0] sig_in_22,
    output reg [31:0] sig_out_22
);
    // FIX: Use non-blocking assignment
    always @(posedge clk) begin
        sig_out_22 <= sig_in_22 + 1'b1;
    end
endmodule
