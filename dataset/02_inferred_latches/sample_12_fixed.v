module latch_mod_12 (
    input [2:0] sel_12,
    input en,
    output reg dec_12
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_12 > 0) begin
            dec_12 = 1'b1;
        end else begin
            dec_12 = 1'b0;
        end
    end
endmodule
