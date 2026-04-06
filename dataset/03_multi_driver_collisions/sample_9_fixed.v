module driver_mod_9 (
    input clk,
    input [31:0] port_a_9,
    input [31:0] port_b_9,
    output reg [31:0] bus_out_9
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_9 <= port_a_9;
        else 
            bus_out_9 <= port_b_9;
    end
endmodule
