module latch_mod_9 (
    input [1:0] sel_9,
    input en,
    output reg dec_9
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_9 > 0) begin
            dec_9 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
