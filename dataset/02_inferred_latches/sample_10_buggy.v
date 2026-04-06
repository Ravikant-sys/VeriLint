module latch_mod_10 (
    input [3:0] sel_10,
    input en,
    output reg dec_10
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_10 > 0) begin
            dec_10 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
