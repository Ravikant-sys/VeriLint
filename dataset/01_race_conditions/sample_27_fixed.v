module race_mod_27 (
    input clk,
    input [7:0] sig_in_27,
    output reg [7:0] sig_out_27
);
    // FIX: Use non-blocking assignment
    always @(negedge clk) begin
        sig_out_27 <= sig_in_27 + 1'b1;
    end
endmodule
