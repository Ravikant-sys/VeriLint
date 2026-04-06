module latch_mod_14 (
    input [2:0] sel_14,
    input en,
    output reg dec_14
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_14 > 0) begin
            dec_14 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
