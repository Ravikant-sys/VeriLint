module driver_mod_40 (
    input clk,
    input [7:0] port_a_40,
    input [7:0] port_b_40,
    output reg [7:0] bus_out_40
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_40 <= port_a_40;
        else 
            bus_out_40 <= port_b_40;
    end
endmodule
