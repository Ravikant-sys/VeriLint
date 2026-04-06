module latch_mod_46 (
    input [4:0] sel_46,
    input en,
    output reg dec_46
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_46 > 0) begin
            dec_46 = 1'b1;
        end else begin
            dec_46 = 1'b0;
        end
    end
endmodule
