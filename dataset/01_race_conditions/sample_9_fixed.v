module race_mod_9 (
    input clk,
    input [63:0] sig_in_9,
    output reg [63:0] sig_out_9
);
    // FIX: Use non-blocking assignment
    always @(posedge clk) begin
        sig_out_9 <= sig_in_9 + 1'b1;
    end
endmodule
