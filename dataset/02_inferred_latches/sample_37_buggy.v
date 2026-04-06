module latch_mod_37 (
    input [3:0] sel_37,
    input en,
    output reg dec_37
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_37 > 0) begin
            dec_37 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
