module latch_mod_20 (
    input [3:0] sel_20,
    input en,
    output reg dec_20
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_20 > 0) begin
            dec_20 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
