module driver_mod_12 (
    input clk,
    input [31:0] port_a_12,
    input [31:0] port_b_12,
    output reg [31:0] bus_out_12
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_12 <= port_a_12;
        else 
            bus_out_12 <= port_b_12;
    end
endmodule
