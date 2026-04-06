module latch_mod_5 (
    input [3:0] sel_5,
    input en,
    output reg dec_5
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_5 > 0) begin
            dec_5 = 1'b1;
        end else begin
            dec_5 = 1'b0;
        end
    end
endmodule
