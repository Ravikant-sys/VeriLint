module latch_mod_47 (
    input [3:0] sel_47,
    input en,
    output reg dec_47
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_47 > 0) begin
            dec_47 = 1'b1;
        end else begin
            dec_47 = 1'b0;
        end
    end
endmodule
