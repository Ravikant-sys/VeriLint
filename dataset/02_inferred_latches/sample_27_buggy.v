module latch_mod_27 (
    input [4:0] sel_27,
    input en,
    output reg dec_27
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_27 > 0) begin
            dec_27 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
