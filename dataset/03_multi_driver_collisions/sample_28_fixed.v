module driver_mod_28 (
    input clk,
    input [31:0] port_a_28,
    input [31:0] port_b_28,
    output reg [31:0] bus_out_28
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_28 <= port_a_28;
        else 
            bus_out_28 <= port_b_28;
    end
endmodule
