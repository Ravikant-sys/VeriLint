module latch_mod_45 (
    input [4:0] sel_45,
    input en,
    output reg dec_45
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_45 > 0) begin
            dec_45 = 1'b1;
        end else begin
            dec_45 = 1'b0;
        end
    end
endmodule
