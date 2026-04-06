module driver_mod_41 (
    input clk,
    input [15:0] port_a_41,
    input [15:0] port_b_41,
    output reg [15:0] bus_out_41
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_41 <= port_a_41;
        else 
            bus_out_41 <= port_b_41;
    end
endmodule
