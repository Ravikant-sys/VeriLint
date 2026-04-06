module latch_mod_45 (
    input [4:0] sel_45,
    input en,
    output reg dec_45
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_45 > 0) begin
            dec_45 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
