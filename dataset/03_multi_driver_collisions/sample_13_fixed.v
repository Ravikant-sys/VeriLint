module driver_mod_13 (
    input clk,
    input [15:0] port_a_13,
    input [15:0] port_b_13,
    output reg [15:0] bus_out_13
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_13 <= port_a_13;
        else 
            bus_out_13 <= port_b_13;
    end
endmodule
