module race_mod_21 (
    input clk,
    input [63:0] sig_in_21,
    output reg [63:0] sig_out_21
);
    // FIX: Use non-blocking assignment
    always @(posedge clk) begin
        sig_out_21 <= sig_in_21 + 1'b1;
    end
endmodule
