module latch_mod_5 (
    input [3:0] sel_5,
    input en,
    output reg dec_5
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_5 > 0) begin
            dec_5 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
