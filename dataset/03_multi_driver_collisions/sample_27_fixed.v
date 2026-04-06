module driver_mod_27 (
    input clk,
    input [7:0] port_a_27,
    input [7:0] port_b_27,
    output reg [7:0] bus_out_27
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_27 <= port_a_27;
        else 
            bus_out_27 <= port_b_27;
    end
endmodule
