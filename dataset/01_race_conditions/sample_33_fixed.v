module race_mod_33 (
    input clk,
    input [3:0] sig_in_33,
    output reg [3:0] sig_out_33
);
    // FIX: Use non-blocking assignment
    always @(negedge clk) begin
        sig_out_33 <= sig_in_33 + 1'b1;
    end
endmodule
