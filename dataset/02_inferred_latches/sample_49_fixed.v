module latch_mod_49 (
    input [1:0] sel_49,
    input en,
    output reg dec_49
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_49 > 0) begin
            dec_49 = 1'b1;
        end else begin
            dec_49 = 1'b0;
        end
    end
endmodule
