module latch_mod_36 (
    input [1:0] sel_36,
    input en,
    output reg dec_36
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_36 > 0) begin
            dec_36 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
