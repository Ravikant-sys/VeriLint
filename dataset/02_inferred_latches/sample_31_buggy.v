module latch_mod_31 (
    input [2:0] sel_31,
    input en,
    output reg dec_31
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_31 > 0) begin
            dec_31 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
