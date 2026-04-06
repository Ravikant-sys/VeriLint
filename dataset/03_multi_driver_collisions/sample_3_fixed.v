module driver_mod_3 (
    input clk,
    input [15:0] port_a_3,
    input [15:0] port_b_3,
    output reg [15:0] bus_out_3
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_3 <= port_a_3;
        else 
            bus_out_3 <= port_b_3;
    end
endmodule
