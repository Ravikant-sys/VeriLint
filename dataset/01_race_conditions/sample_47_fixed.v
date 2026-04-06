module race_mod_47 (
    input clk,
    input [63:0] sig_in_47,
    output reg [63:0] sig_out_47
);
    // FIX: Use non-blocking assignment
    always @(posedge clk) begin
        sig_out_47 <= sig_in_47 + 1'b1;
    end
endmodule
