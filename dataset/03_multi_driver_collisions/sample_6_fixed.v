module driver_mod_6 (
    input clk,
    input [7:0] port_a_6,
    input [7:0] port_b_6,
    output reg [7:0] bus_out_6
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_6 <= port_a_6;
        else 
            bus_out_6 <= port_b_6;
    end
endmodule
