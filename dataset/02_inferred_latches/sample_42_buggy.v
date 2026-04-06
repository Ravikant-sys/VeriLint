module latch_mod_42 (
    input [3:0] sel_42,
    input en,
    output reg dec_42
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_42 > 0) begin
            dec_42 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
