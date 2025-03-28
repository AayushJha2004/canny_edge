module uart_top_tb;
  import definitions_pkg::*;

  logic clk;
  logic rstN;
  logic rx;
  logic tx;
  logic [FIFO_WIDTH-1:0] rx_rd_data;
  logic rx_valid;
  logic [FIFO_WIDTH-1:0] tx_wr_data;
  logic tx_wr;

  // Clock generation
  localparam CLK_PERIOD = 10;
  always #(CLK_PERIOD/2) clk = ~clk;

  // Instantiate DUT
  uart_top dut (
    .clk(clk),
    .rstN(rstN),
    .rx(rx),
    .tx(tx),
    .rx_rd_data(rx_rd_data),
    .rx_valid(rx_valid),
    .tx_wr_data(tx_wr_data),
    .tx_wr(tx_wr)
  );

  assign rx = tx;

  // Reset and test sequence
  initial begin
    clk = 0;
    rstN = 0;
    tx_wr = 0;
    tx_wr_data = 8'h00;

    // Apply reset
    #100;
    rstN = 1;
    #100;

    // Transmit a few bytes
    for (int i = 0; i < 10; i++) begin
      tx_wr_data = i;
      tx_wr = 1;
      #CLK_PERIOD;
      tx_wr = 0;
      @(posedge dut.tx_done);
      #CLK_PERIOD;
    end

    // Wait for reception to complete
    #1000;

    // Read received data
    if (rx_valid) begin
      $display("Received Data: %h", rx_rd_data);
    end

    #500;
    $finish;
  end
endmodule