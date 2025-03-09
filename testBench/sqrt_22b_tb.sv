module sqrt_22b_tb;
  logic [21:0] value;
  logic [10:0] sqrt;

  sqrt_22b s1(
    .value(value),
    .sqrt(sqrt)
  );

  initial begin
    value = 100;
    #10;
    value = 167;
    #10;
    value = 1287293;
    #10;
    value = 734628;
    #10;
    value = 5677;
    #10;
    value = 19471;
    #10;
    value = 6346;
    #10;
    value = 50;
    #10;
    $finish;
  end

endmodule: sqrt_22b_tb