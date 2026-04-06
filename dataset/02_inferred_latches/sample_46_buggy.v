module latch_mod_46 (
    input [4:0] sel_46,
    input en,
    output reg dec_46
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_46 > 0) begin
            dec_46 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
