module latch_mod_19 (
    input [4:0] sel_19,
    input en,
    output reg dec_19
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_19 > 0) begin
            dec_19 = 1'b1;
        end else begin
            dec_19 = 1'b0;
        end
    end
endmodule
