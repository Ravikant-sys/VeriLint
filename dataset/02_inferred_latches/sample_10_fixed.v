module latch_mod_10 (
    input [3:0] sel_10,
    input en,
    output reg dec_10
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_10 > 0) begin
            dec_10 = 1'b1;
        end else begin
            dec_10 = 1'b0;
        end
    end
endmodule
