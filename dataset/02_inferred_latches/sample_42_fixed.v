module latch_mod_42 (
    input [3:0] sel_42,
    input en,
    output reg dec_42
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_42 > 0) begin
            dec_42 = 1'b1;
        end else begin
            dec_42 = 1'b0;
        end
    end
endmodule
