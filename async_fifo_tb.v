
`timescale 1ns / 1ps

module sync_fifo_tb;

    reg clk, rst_n, wr_en, rd_en;
    reg [7:0] data_in;

    wire [7:0] data_out;
    wire full, empty;

    // DUT: Design Under Test
    sync_fifo uut (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus generation
    initial begin

        rst_n = 0;
        wr_en = 0;
        rd_en = 0;
        data_in = 0;

        // Reset
        #10;
        rst_n = 1;

        // Write 4 values
        repeat (4) begin
            @(negedge clk);
            wr_en = 1;
            data_in = $random;
        end

        @(negedge clk);
        wr_en = 0;

        // Read 4 values
        repeat (4) begin
            @(negedge clk);
            rd_en = 1;
        end

        @(negedge clk);
        rd_en = 0;

        #20;
        $finish;

    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t | rst_n=%b | wr_en=%b | rd_en=%b | data_in=%d | data_out=%d | full=%b | empty=%b",
                 $time, rst_n, wr_en, rd_en, data_in, data_out, full, empty);
    end

endmodule
