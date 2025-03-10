module arc_tan(
  input   signed logic [10:0]  Gx, Gy,
  output  signed logic [1:0]   angle // 0: 0, 1:45, 2:90, 3:135
);

  always_comb begin
    if (Gx == 0 & Gy == 0) begin
      angle = 2'b00; // 0
    end
    else if (Gx == 0) begin
      angle = 2'b10; // 90
    end
    else if (Gy == 0) begin
      angle = 2'b00; // 0
    end
    else begin
      if      ((Gx > 0) && (Gy > 0)) begin
        if (Gy > Gx)  angle = 2'b01; // 45
        else          angle = 2'b00; // 0
      end
      else if ((Gx < 0) && (Gy < 0)) begin
        if (Gy > Gx)  angle = 2'b00; // 45
        else          angle = 2'b01; // 0
      end
      else if ((Gx > 0) && (Gy < 0)) begin
        if (-Gy > Gx) angle = 2'b11; // 135
        else          angle = 2'b00; // 0
      end
      else begin
        if (Gy > -Gx) angle = 2'b11; // 135
        else          angle = 2'b00; // 0
      end
    end
  end
  
endmodule: arc_tan