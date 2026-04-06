module race_mod_40 (
    input clk,
    input [63:0] sig_in_40,
    output reg [63:0] sig_out_40
);
    // FIX: Use non-blocking assignment
    always @(posedge clk) begin
        sig_out_40 <= sig_in_40 + 1'b1;
    end
endmodule
