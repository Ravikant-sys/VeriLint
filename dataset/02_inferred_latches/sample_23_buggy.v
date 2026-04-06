module latch_mod_23 (
    input [4:0] sel_23,
    input en,
    output reg dec_23
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_23 > 0) begin
            dec_23 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
