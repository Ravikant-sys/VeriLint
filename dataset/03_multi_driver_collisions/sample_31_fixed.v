module driver_mod_31 (
    input clk,
    input [7:0] port_a_31,
    input [7:0] port_b_31,
    output reg [7:0] bus_out_31
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_31 <= port_a_31;
        else 
            bus_out_31 <= port_b_31;
    end
endmodule
