module latch_mod_41 (
    input [3:0] sel_41,
    input en,
    output reg dec_41
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_41 > 0) begin
            dec_41 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
