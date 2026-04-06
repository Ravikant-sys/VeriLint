module latch_mod_47 (
    input [3:0] sel_47,
    input en,
    output reg dec_47
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_47 > 0) begin
            dec_47 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
