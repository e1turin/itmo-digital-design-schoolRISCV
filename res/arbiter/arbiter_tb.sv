`timescale 1ns / 1ps


module arbiter_tb;

  localparam N = 8; 
  
  logic clk = 0;
  logic arst = 1;
  logic ready;
  
  logic [N-1:0] t_data_i [1:0];
  logic [N-1:0] t_data_o;
  logic [  1:0] t_valid_i;
  logic         t_valid_o;

  logic [N-1:0] test_data_out;
  assign test_data_out = t_data_o;

  logic test_valid_out;
  assign test_valid_out = t_valid_o;

  arbiter # ( 
    .BIT_DEPTH ( N )
  ) dut ( 
     .clk       ( clk       ),
     .arstn     ( arst      ),
     .t_data_i  ( t_data_i  ),
     .t_valid_i ( t_valid_i ),
     .t_data_o  ( t_data_o  ),
     .t_valid_o ( t_valid_o )
  );

`ifdef ICARUS
    //iverilog memory dump init workaround
    initial $dumpvars;
    initial $dumpvars(0, dut.t_data_i[0]);
    initial $dumpvars(0, dut.t_data_i[1]);
`endif

  initial forever clk = #10 ~clk;

  initial
  begin
    t_data_i[0] = 'd7;
    t_data_i[1] = 'd15;
    t_valid_i[0] = 1;
    t_valid_i[1] = 1;

    #3 arst = 'd0;
    #3 arst = 'd1;

    repeat(2)
    begin
      @(posedge clk);
      #5 $display("data out = %0d and valid = %0d", test_data_out, test_valid_out);
    end
    
    t_valid_i[0] = 1;
    t_valid_i[1] = 0;
    
    repeat(1)
    begin
      @(posedge clk);
      #5 $display("data out = %0d and valid = %0d", test_data_out, test_valid_out);
    end

    t_valid_i[0] = 0;
    t_valid_i[1] = 0;

    repeat(2)
    begin
      @(posedge clk);
      #5 $display("data out = %0d and valid = %0d", test_data_out, test_valid_out);
    end
    
    #20 $stop;
  end

endmodule
