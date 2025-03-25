module chip_top
  import definitions_pkg::*;
  (
    input   logic clk,
    input   logic rstN,
    input   logic rx,
    output  logic tx
  );

  logic rx_rd;
  logic [FIFO_WIDTH-1:0] rx_rd_data;
  logic rx_empty, rx_valid;

  logic [FIFO_WIDTH-1:0] tx_wr_data;
  logic tx_wr;
  logic tx_full;

  uart_top uart(
    .clk(clk),
    .rstN(rstN),
    .rx(rx),
    .tx(tx),
    .rx_rd(rx_rd),
    .rx_rd_data(rx_rd_data),
    .rx_empty(rx_empty), 
    .rx_valid(rx_valid),
    .tx_wr_data(tx_wr_data),
    .tx_wr(tx_wr),
    .tx_full(tx_full)
  );

  canny_edge_top canny_edge(
    .clk(clk),
    .rstN(rstN),
    .pixel_in(rd_data),
    .pixel_in_valid(rx_valid),
    .pixel_out(tx_wr_data),
    .pixel_out_valid(tx_wr)
  );

endmodule: chip_top