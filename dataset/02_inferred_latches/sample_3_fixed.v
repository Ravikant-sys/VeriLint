module latch_mod_3 (
    input [2:0] sel_3,
    input en,
    output reg dec_3
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_3 > 0) begin
            dec_3 = 1'b1;
        end else begin
            dec_3 = 1'b0;
        end
    end
endmodule
