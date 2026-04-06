module latch_mod_6 (
    input [3:0] sel_6,
    input en,
    output reg dec_6
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_6 > 0) begin
            dec_6 = 1'b1;
        end else begin
            dec_6 = 1'b0;
        end
    end
endmodule
