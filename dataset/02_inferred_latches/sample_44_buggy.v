module latch_mod_44 (
    input [4:0] sel_44,
    input en,
    output reg dec_44
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_44 > 0) begin
            dec_44 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
