module latch_mod_16 (
    input [2:0] sel_16,
    input en,
    output reg dec_16
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_16 > 0) begin
            dec_16 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
