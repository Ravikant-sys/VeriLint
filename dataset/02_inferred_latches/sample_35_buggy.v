module latch_mod_35 (
    input [3:0] sel_35,
    input en,
    output reg dec_35
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_35 > 0) begin
            dec_35 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
