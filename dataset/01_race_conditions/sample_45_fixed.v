module race_mod_45 (
    input clk,
    input [15:0] sig_in_45,
    output reg [15:0] sig_out_45
);
    // FIX: Use non-blocking assignment
    always @(posedge clk) begin
        sig_out_45 <= sig_in_45 + 1'b1;
    end
endmodule
