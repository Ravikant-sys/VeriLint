module race_mod_6 (
    input clk,
    input [31:0] sig_in_6,
    output reg [31:0] sig_out_6
);
    // FIX: Use non-blocking assignment
    always @(posedge clk) begin
        sig_out_6 <= sig_in_6 + 1'b1;
    end
endmodule
