// tb.v

module tb;

  reg  [3:0] a;
  reg  [3:0] b;
  reg        op;
  wire [3:0] result;

  alu DUT (
    .a(a),
    .b(b),
    .op(op),
    .result(result)
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
    $display("Time |  a  b op | result");
    $display("-----|----------|-------");
    $monitor("%4t | %2d %2d  %b | %2d", $time, a, b, op, result);

    // TEST 1: Catch the sensitivity list bug.
    // We establish a baseline addition, then toggle ONLY the 'op' bit.
    // If 'op' is missing from the sensitivity list, the result won't update.
    a = 4'd5; b = 4'd3; op = 1'b0; #10;
    op = 1'b1; #10;

    // TEST 2: Catch the non-blocking assignment bug.
    // Perform a subtraction with completely new values.
    // If using '<=', 'result' will calculate using stale intermediate variables.
    a = 4'd10; b = 4'd7; op = 1'b1; #10;

    // Additional generic test cases
    a = 4'd8; b = 4'd2; op = 1'b0; #10;
    a = 4'd8; b = 4'd2; op = 1'b1; #10;

    $finish;
  end

endmodule