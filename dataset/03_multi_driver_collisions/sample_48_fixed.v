module driver_mod_48 (
    input clk,
    input [15:0] port_a_48,
    input [15:0] port_b_48,
    output reg [15:0] bus_out_48
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_48 <= port_a_48;
        else 
            bus_out_48 <= port_b_48;
    end
endmodule
