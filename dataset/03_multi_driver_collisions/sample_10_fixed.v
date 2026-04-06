module driver_mod_10 (
    input clk,
    input [7:0] port_a_10,
    input [7:0] port_b_10,
    output reg [7:0] bus_out_10
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_10 <= port_a_10;
        else 
            bus_out_10 <= port_b_10;
    end
endmodule
