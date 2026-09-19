// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
  reg  [1:0] sel;
  wire [7:0] dout;

  // TODO: instantiate DUT here
  lut DUT (
    .sel(sel),
    .dout(dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // TODO: apply different input combinations
    sel = 2'b00; #5;
    sel = 2'b01; #5;
    sel = 2'b10; #5;
    sel = 2'b11; #5;

    $finish;
  end

  initial
    $monitor($time, " sel=%b | dout=%b", sel, dout); // change as required

endmodule