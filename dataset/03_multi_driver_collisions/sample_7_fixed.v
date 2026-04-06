module driver_mod_7 (
    input clk,
    input [7:0] port_a_7,
    input [7:0] port_b_7,
    output reg [7:0] bus_out_7
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_7 <= port_a_7;
        else 
            bus_out_7 <= port_b_7;
    end
endmodule
