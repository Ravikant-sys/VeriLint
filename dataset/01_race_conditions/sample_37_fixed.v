module race_mod_37 (
    input clk,
    input [3:0] sig_in_37,
    output reg [3:0] sig_out_37
);
    // FIX: Use non-blocking assignment
    always @(negedge clk) begin
        sig_out_37 <= sig_in_37 + 1'b1;
    end
endmodule
