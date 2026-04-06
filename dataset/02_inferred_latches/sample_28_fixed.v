module latch_mod_28 (
    input [3:0] sel_28,
    input en,
    output reg dec_28
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_28 > 0) begin
            dec_28 = 1'b1;
        end else begin
            dec_28 = 1'b0;
        end
    end
endmodule
