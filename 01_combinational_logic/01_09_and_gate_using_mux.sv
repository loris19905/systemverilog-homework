`timescale 1ns / 1ns

module mux
(
  input  d0, d1,
  input  sel,
  output y
);

  assign y = sel ? d1 : d0;

endmodule

//----------------------------------------------------------------------------

module and_gate_using_mux
(
    input  a,
    input  b,
    output o
);

  logic low_mux_data;
  
  mux i_mux_low
  (
    .d0 (1'b0        ),
    .d1 (1'b1        ),
    .sel(a           ),
    .y  (low_mux_data)
  );

  mux i_mux_middle
  (
    .d0 (1'b0         ),
    .d1 (low_mux_data ),
    .sel(b            ),
    .y  (o            )
  );
  
  // TODO

  // Implement and gate using instance(s) of mux,
  // constants 0 and 1, and wire connections


endmodule

//----------------------------------------------------------------------------

module testbench;

  logic a, b, o;
  int i, j;

  and_gate_using_mux inst (a, b, o);

  initial
    begin
      for (i = 0; i <= 1; i++)
      for (j = 0; j <= 1; j++)
      begin
        a = i;
        b = j;

        # 1;

        $display ("TEST %b & %b = %b", a, b, o);

        if (o !== (a & b))
          begin
            $display ("%s FAIL: %h EXPECTED", `__FILE__, a & b);
            $finish;
          end
      end

      $display ("%s PASS", `__FILE__);
      $finish;
    end

endmodule
