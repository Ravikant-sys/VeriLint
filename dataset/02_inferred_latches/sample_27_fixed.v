module latch_mod_27 (
    input [4:0] sel_27,
    input en,
    output reg dec_27
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_27 > 0) begin
            dec_27 = 1'b1;
        end else begin
            dec_27 = 1'b0;
        end
    end
endmodule
