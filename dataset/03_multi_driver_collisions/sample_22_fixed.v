module driver_mod_22 (
    input clk,
    input [31:0] port_a_22,
    input [31:0] port_b_22,
    output reg [31:0] bus_out_22
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_22 <= port_a_22;
        else 
            bus_out_22 <= port_b_22;
    end
endmodule
