// tb.v

module tb;

  reg  [1:0] A;
  reg  [1:0] B;
  wire       GT;
  wire       LT;
  wire       EQ;

  integer i, j;

  comp2 DUT (
    .A(A),
    .B(B),
    .GT(GT),
    .LT(LT),
    .EQ(EQ)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        A = i;
        B = j;
        #5;
        
        if ((GT + LT + EQ) != 1) begin
          $display("Error at time %0t: A=%d, B=%d -> GT=%b, LT=%b, EQ=%b", $time, A, B, GT, LT, EQ);
        end
      end
    end
    $finish;
  end

endmodule