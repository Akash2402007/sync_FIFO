
`timescale 1ns / 1ps

module sync_fifo #(
    parameter DEPTH = 8,
    parameter DATA_WIDTH = 8
)(
    input clk,
    input rst_n,
    input wr_en,
    input rd_en,

    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,

    output full,
    output empty
);

    // FIFO memory
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Pointers
    reg [$clog2(DEPTH):0] w_ptr, r_ptr;

    // FIFO status flags
    assign full  = (w_ptr - r_ptr == DEPTH);
    assign empty = (w_ptr == r_ptr);

    // Write operation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            w_ptr <= 0;
        end
        else if (wr_en && !full) begin
            mem[w_ptr % DEPTH] <= data_in;
            w_ptr <= w_ptr + 1'b1;
        end
    end

    // Read operation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            r_ptr <= 0;
            data_out <= 0;
        end
        else if (rd_en && !empty) begin
            data_out <= mem[r_ptr % DEPTH];
            r_ptr <= r_ptr + 1'b1;
        end
    end

endmodule
