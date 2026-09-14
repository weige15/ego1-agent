`timescale 1ns/1ps

module top_tb;

    logic clk;
    logic rst;
    logic led;

    initial clk = 1'b0;

    always #5 clk = ~clk;

    top #(
        .HALF_PERIOD_CYCLES(4)
    ) dut (
        .clk(clk),
        .rst(rst),
        .led(led)
    );

    initial begin
        rst = 1'b1;

        repeat (2) @(posedge clk);

        rst = 1'b0;

        repeat (4) @(posedge clk);
        #1;

        if (led !== 1'b1) begin
            $fatal(1, "LED should be ON");
        end

        repeat (4) @(posedge clk);
        #1;

        if (led !== 1'b0) begin
            $fatal(1, "LED should be OFF");
        end

        $display("TEST PASS");

        $finish;
    end

endmodule
