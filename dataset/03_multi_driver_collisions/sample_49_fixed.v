module driver_mod_49 (
    input clk,
    input [15:0] port_a_49,
    input [15:0] port_b_49,
    output reg [15:0] bus_out_49
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_49 <= port_a_49;
        else 
            bus_out_49 <= port_b_49;
    end
endmodule
