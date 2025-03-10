`timescale 1ps/1ps

module arc_tan_tb;
  logic signed [10:0] Gx, Gy;
  logic signed [1:0]  angle;

  arc_tan atan(
    .Gx(Gx), .Gy(Gy),
    .angle(angle)
  );

  initial begin
    Gx = 11'sb11110110101;
    Gy = 11'sb11110110000;
    #10;
    for (int i = -1024; i <= 1024; i++) begin
      for (int j = -1024; j <= 1024; j++) begin
        Gx = i;
        Gy = j;
        #10;
      end
    end
    $finish;
  end
endmodule: arc_tan_tb