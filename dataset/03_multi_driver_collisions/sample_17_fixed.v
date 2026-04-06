module driver_mod_17 (
    input clk,
    input [31:0] port_a_17,
    input [31:0] port_b_17,
    output reg [31:0] bus_out_17
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_17 <= port_a_17;
        else 
            bus_out_17 <= port_b_17;
    end
endmodule
