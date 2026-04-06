module driver_mod_45 (
    input clk,
    input [15:0] port_a_45,
    input [15:0] port_b_45,
    output reg [15:0] bus_out_45
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_45 <= port_a_45;
        else 
            bus_out_45 <= port_b_45;
    end
endmodule
