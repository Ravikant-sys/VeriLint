module latch_mod_12 (
    input [2:0] sel_12,
    input en,
    output reg dec_12
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_12 > 0) begin
            dec_12 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
