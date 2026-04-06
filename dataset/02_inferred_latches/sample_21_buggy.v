module latch_mod_21 (
    input [3:0] sel_21,
    input en,
    output reg dec_21
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_21 > 0) begin
            dec_21 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
