module latch_mod_1 (
    input [3:0] sel_1,
    input en,
    output reg dec_1
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_1 > 0) begin
            dec_1 = 1'b1;
        end else begin
            dec_1 = 1'b0;
        end
    end
endmodule
