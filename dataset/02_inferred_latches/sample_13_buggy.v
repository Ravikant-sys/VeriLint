module latch_mod_13 (
    input [2:0] sel_13,
    input en,
    output reg dec_13
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_13 > 0) begin
            dec_13 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
