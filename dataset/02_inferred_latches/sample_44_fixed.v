module latch_mod_44 (
    input [4:0] sel_44,
    input en,
    output reg dec_44
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_44 > 0) begin
            dec_44 = 1'b1;
        end else begin
            dec_44 = 1'b0;
        end
    end
endmodule
