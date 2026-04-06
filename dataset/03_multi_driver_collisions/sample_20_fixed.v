module driver_mod_20 (
    input clk,
    input [15:0] port_a_20,
    input [15:0] port_b_20,
    output reg [15:0] bus_out_20
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_20 <= port_a_20;
        else 
            bus_out_20 <= port_b_20;
    end
endmodule
