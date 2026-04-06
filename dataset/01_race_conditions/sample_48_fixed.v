module race_mod_48 (
    input clk,
    input [31:0] sig_in_48,
    output reg [31:0] sig_out_48
);
    // FIX: Use non-blocking assignment
    always @(posedge clk) begin
        sig_out_48 <= sig_in_48 + 1'b1;
    end
endmodule
