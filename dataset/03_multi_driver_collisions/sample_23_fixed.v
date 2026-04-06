module driver_mod_23 (
    input clk,
    input [15:0] port_a_23,
    input [15:0] port_b_23,
    output reg [15:0] bus_out_23
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_23 <= port_a_23;
        else 
            bus_out_23 <= port_b_23;
    end
endmodule
