`timescale 1ns / 1ps


module arbiter # (
  parameter BIT_DEPTH = 32
) (
  input   logic                 clk,
  input   logic                 arstn,
  input   logic [BIT_DEPTH-1:0] t_data_i    [1:0],
  input   logic [          1:0] t_valid_i,
  output  logic [BIT_DEPTH-1:0] t_data_o,
  output  logic                 t_valid_o,
  output  logic [          1:0] t_number_o
);
  
  logic [1:0] req_queue;  
  logic [BIT_DEPTH-1:0] t_data_queue [1:0];

  logic update_f;
  // As we have 2 transactions at all 
  // if first transation is completed (we mustn't skip it), 
  // it is time to update.
  assign update_f = (~req_queue[0]);

  always_ff @(posedge clk or negedge arstn)
  begin
    if (!arstn || update_f) 
    begin
      t_data_queue[0] <= t_data_i[0];
      t_data_queue[1] <= t_data_i[1];
    end
  end

  logic grant_ptr;

  always_comb
  begin
    casez (req_queue)
      2'b?1:   grant_ptr = 'd0;
      2'b10:   grant_ptr = 'd1;

      default: grant_ptr = 'd0;
    endcase
  end

  always_ff @(posedge clk or negedge arstn)
  begin
    if (!arstn)
      req_queue <= 0;
    else if (update_f)
      req_queue <= t_valid_i;
    else
      req_queue[grant_ptr] <= 'd0;
  end

  logic not_empty_queue_f;
  assign not_empty_queue_f = |req_queue;

  always_comb
  begin
    t_valid_o = not_empty_queue_f;
    t_data_o  = t_data_queue[grant_ptr];
    case (grant_ptr)
      1'd0: t_number_o = 'b01;
      1'd1: t_number_o = 'b10;
    endcase
  end

endmodule