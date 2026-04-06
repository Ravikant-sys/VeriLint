module driver_mod_39 (
    input clk,
    input [7:0] port_a_39,
    input [7:0] port_b_39,
    output reg [7:0] bus_out_39
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_39 <= port_a_39;
        else 
            bus_out_39 <= port_b_39;
    end
endmodule
