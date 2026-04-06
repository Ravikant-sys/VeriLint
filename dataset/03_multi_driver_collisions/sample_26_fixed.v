module driver_mod_26 (
    input clk,
    input [7:0] port_a_26,
    input [7:0] port_b_26,
    output reg [7:0] bus_out_26
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_26 <= port_a_26;
        else 
            bus_out_26 <= port_b_26;
    end
endmodule
