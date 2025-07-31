module clock_12h(
    input clk,
    input rst,
    output reg [3:0] hours,      
    output reg [5:0] minutes,    
    output reg [5:0] seconds,    
    output reg am_pm             
);

    always @(posedge clk or posedge rst) begin
    if (rst) begin
        hours   <= 4'd11;   // 12:00:00 AM
        minutes <= 6'd0;
        seconds <= 6'd0;
        am_pm   <= 1'b0;    // AM
    end else begin
      if (seconds == 6'd59) begin
            seconds <= 6'd0;
        if (minutes == 6'd59) begin
                minutes <= 6'd0;
                if (hours == 4'd11) begin
                    hours <= 4'd12;
                    am_pm <= ~am_pm;  
                end else if (hours == 4'd12) begin
                    hours <= 4'd1;
                end else begin
                    hours <= hours + 1;
                end
            end else begin
                minutes <= minutes + 1;
            end
        end else begin
            seconds <= seconds + 1;
        end
    end
end
endmodule


module tt_um_clock_12h_wrapper (
    input  wire [7:0] ui_in,     // [0] = clk, [1] = rst
    output wire [7:0] uo_out,    // [3:0] hours, [7:4] AM/PM + unused
    input  wire [7:0] uio_in,    // Not used
    output wire [7:0] uio_out,   // Not used
    output wire [7:0] uio_oe,    // Not used
    input  wire       ena,       // Can be ignored
    input  wire       clk,       // Not used (external clock not required)
    input  wire       rst_n      // Not used
);

  // Internal wires for outputs from clock_12h
  wire [3:0] hours;
  wire [5:0] minutes;
  wire [5:0] seconds;
  wire       am_pm;

  // Instantiate the actual 12h clock module
  clock_12h clock_inst (
    .clk(ui_in[0]),         // use ui_in[0] as clock input
    .rst(ui_in[1]),         // use ui_in[1] as reset
    .hours(hours),
    .minutes(minutes),
    .seconds(seconds),
    .am_pm(am_pm)
  );

  // Pack outputs into uo_out (example mapping: use bits [3:0] for hours and [4] for am_pm)
  assign uo_out = {3'b000, am_pm, hours};  // [7:5] = 0, [4] = am_pm, [3:0] = hours

  // IO not used
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

  // Avoid unused signal warnings
  wire _unused = &{ena, clk, rst_n};

endmodule

