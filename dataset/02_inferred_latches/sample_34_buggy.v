module latch_mod_34 (
    input [3:0] sel_34,
    input en,
    output reg dec_34
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_34 > 0) begin
            dec_34 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
