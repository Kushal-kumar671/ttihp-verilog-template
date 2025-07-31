module tb;

  reg [7:0] ui_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;
  reg [7:0] uio_in;
  reg ena;
  reg clk;
  reg rst_n;

  // Instantiate the wrapper
  tt_um_clock_12h_wrapper uut (
    .ui_in(ui_in),
    .uo_out(uo_out),
    .uio_in(uio_in),
    .uio_out(uio_out),
    .uio_oe(uio_oe),
    .ena(ena),
    .clk(clk),
    .rst_n(rst_n)
  );

  // Clock generator
  initial begin
    clk = 0;
    forever #1 clk = ~clk; // 1ns period -> 500 MHz (for sim speedup)
  end

  // Stimulus
  initial begin
    // Initial values
    ui_in = 8'b0;
    uio_in = 8'b0;
    ena = 1;
    rst_n = 1;

    // Apply reset
    ui_in[1] = 1; // rst
    #10;
    ui_in[1] = 0; // deassert reset

    // Run for a while
    #1000000;
    $finish;
  end

  // Drive ui_in[0] with clock
  always @ (posedge clk) begin
    ui_in[0] <= ~ui_in[0];  // Toggle user clock bit
  end

  // Monitor output
  initial begin
    $display("Time format: HH:MM AM/PM");
    $monitor("Hour: %0d %s", 
              uo_out[3:0], 
              (uo_out[4] ? "PM" : "AM"));
  end

endmodule
