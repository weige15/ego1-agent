module top #(
    parameter int unsigned TOGGLE_PERIOD_CYCLES = 20_000_000
) (
    input  logic clk,
    input  logic rst,
    output logic led
);

    logic [31:0] counter = 32'd0;

    always_ff @(posedge clk) begin
        if (rst) begin
            counter <= 32'd0;
            led     <= 1'b0;
        end else begin
            if (counter == TOGGLE_PERIOD_CYCLES - 1) begin
                counter <= 32'd0;
                led     <= ~led;
            end else begin
                counter <= counter + 1'b1;
            end
        end
    end

endmodule
