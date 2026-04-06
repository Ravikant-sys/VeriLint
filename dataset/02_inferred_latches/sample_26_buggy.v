module latch_mod_26 (
    input [1:0] sel_26,
    input en,
    output reg dec_26
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_26 > 0) begin
            dec_26 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
