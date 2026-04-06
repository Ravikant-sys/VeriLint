module driver_mod_36 (
    input clk,
    input [15:0] port_a_36,
    input [15:0] port_b_36,
    output reg [15:0] bus_out_36
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_36 <= port_a_36;
        else 
            bus_out_36 <= port_b_36;
    end
endmodule
