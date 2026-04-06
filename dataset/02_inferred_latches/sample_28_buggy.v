module latch_mod_28 (
    input [3:0] sel_28,
    input en,
    output reg dec_28
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_28 > 0) begin
            dec_28 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
