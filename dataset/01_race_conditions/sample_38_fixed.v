module race_mod_38 (
    input clk,
    input [3:0] sig_in_38,
    output reg [3:0] sig_out_38
);
    // FIX: Use non-blocking assignment
    always @(posedge clk) begin
        sig_out_38 <= sig_in_38 + 1'b1;
    end
endmodule
