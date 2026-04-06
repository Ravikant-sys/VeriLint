module latch_mod_7 (
    input [2:0] sel_7,
    input en,
    output reg dec_7
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_7 > 0) begin
            dec_7 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
