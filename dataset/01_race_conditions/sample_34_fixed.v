module race_mod_34 (
    input clk,
    input [7:0] sig_in_34,
    output reg [7:0] sig_out_34
);
    // FIX: Use non-blocking assignment
    always @(negedge clk) begin
        sig_out_34 <= sig_in_34 + 1'b1;
    end
endmodule
