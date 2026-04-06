module driver_mod_4 (
    input clk,
    input [15:0] port_a_4,
    input [15:0] port_b_4,
    output reg [15:0] bus_out_4
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_4 <= port_a_4;
        else 
            bus_out_4 <= port_b_4;
    end
endmodule
