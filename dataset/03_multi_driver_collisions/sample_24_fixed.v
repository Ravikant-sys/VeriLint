module driver_mod_24 (
    input clk,
    input [15:0] port_a_24,
    input [15:0] port_b_24,
    output reg [15:0] bus_out_24
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_24 <= port_a_24;
        else 
            bus_out_24 <= port_b_24;
    end
endmodule
