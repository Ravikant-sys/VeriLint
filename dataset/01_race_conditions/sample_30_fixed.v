module race_mod_30 (
    input clk,
    input [15:0] sig_in_30,
    output reg [15:0] sig_out_30
);
    // FIX: Use non-blocking assignment
    always @(posedge clk) begin
        sig_out_30 <= sig_in_30 + 1'b1;
    end
endmodule
