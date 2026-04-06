module driver_mod_14 (
    input clk,
    input [7:0] port_a_14,
    input [7:0] port_b_14,
    output reg [7:0] bus_out_14
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_14 <= port_a_14;
        else 
            bus_out_14 <= port_b_14;
    end
endmodule
