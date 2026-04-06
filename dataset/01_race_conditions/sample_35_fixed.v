module race_mod_35 (
    input clk,
    input [3:0] sig_in_35,
    output reg [3:0] sig_out_35
);
    // FIX: Use non-blocking assignment
    always @(posedge clk) begin
        sig_out_35 <= sig_in_35 + 1'b1;
    end
endmodule
