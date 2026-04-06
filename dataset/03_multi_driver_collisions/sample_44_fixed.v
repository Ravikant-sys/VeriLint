module driver_mod_44 (
    input clk,
    input [15:0] port_a_44,
    input [15:0] port_b_44,
    output reg [15:0] bus_out_44
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_44 <= port_a_44;
        else 
            bus_out_44 <= port_b_44;
    end
endmodule
