module race_mod_44 (
    input clk,
    input [3:0] sig_in_44,
    output reg [3:0] sig_out_44
);
    // FIX: Use non-blocking assignment
    always @(posedge clk) begin
        sig_out_44 <= sig_in_44 + 1'b1;
    end
endmodule
