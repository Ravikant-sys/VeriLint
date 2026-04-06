module driver_mod_1 (
    input clk,
    input [15:0] port_a_1,
    input [15:0] port_b_1,
    output reg [15:0] bus_out_1
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_1 <= port_a_1;
        else 
            bus_out_1 <= port_b_1;
    end
endmodule
