module race_mod_12 (
    input clk,
    input [7:0] sig_in_12,
    output reg [7:0] sig_out_12
);
    // FIX: Use non-blocking assignment
    always @(posedge clk) begin
        sig_out_12 <= sig_in_12 + 1'b1;
    end
endmodule
