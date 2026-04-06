module driver_mod_8 (
    input clk,
    input [15:0] port_a_8,
    input [15:0] port_b_8,
    output reg [15:0] bus_out_8
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_8 <= port_a_8;
        else 
            bus_out_8 <= port_b_8;
    end
endmodule
