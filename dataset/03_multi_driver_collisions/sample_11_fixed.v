module driver_mod_11 (
    input clk,
    input [15:0] port_a_11,
    input [15:0] port_b_11,
    output reg [15:0] bus_out_11
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_11 <= port_a_11;
        else 
            bus_out_11 <= port_b_11;
    end
endmodule
