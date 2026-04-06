module latch_mod_6 (
    input [3:0] sel_6,
    input en,
    output reg dec_6
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_6 > 0) begin
            dec_6 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
