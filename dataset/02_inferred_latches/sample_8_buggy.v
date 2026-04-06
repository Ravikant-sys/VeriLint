module latch_mod_8 (
    input [2:0] sel_8,
    input en,
    output reg dec_8
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_8 > 0) begin
            dec_8 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
