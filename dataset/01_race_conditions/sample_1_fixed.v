module race_mod_1 (
    input clk,
    input [15:0] sig_in_1,
    output reg [15:0] sig_out_1
);
    // FIX: Use non-blocking assignment
    always @(posedge clk) begin
        sig_out_1 <= sig_in_1 + 1'b1;
    end
endmodule
