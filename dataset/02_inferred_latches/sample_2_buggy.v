module latch_mod_2 (
    input [1:0] sel_2,
    input en,
    output reg dec_2
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_2 > 0) begin
            dec_2 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
