module driver_mod_35 (
    input clk,
    input [15:0] port_a_35,
    input [15:0] port_b_35,
    output reg [15:0] bus_out_35
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_35 <= port_a_35;
        else 
            bus_out_35 <= port_b_35;
    end
endmodule
