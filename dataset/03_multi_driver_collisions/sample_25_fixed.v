module driver_mod_25 (
    input clk,
    input [7:0] port_a_25,
    input [7:0] port_b_25,
    output reg [7:0] bus_out_25
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_25 <= port_a_25;
        else 
            bus_out_25 <= port_b_25;
    end
endmodule
