module latch_mod_4 (
    input [3:0] sel_4,
    input en,
    output reg dec_4
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_4 > 0) begin
            dec_4 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
