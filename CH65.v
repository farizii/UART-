module CH65 #(parameter data_width=8)(
  input clk,
  input Rst_tx,
  input start,
  input [data_width-1:0] data,
  output reg Rs232_tx,
  output reg done
);
 
  localparam idle_state=0, start_state=1, data_state=2, stop_state=3;
  
  reg [1:0] state;
  reg [3:0] count;

  always @(posedge clk or posedge Rst_tx) begin
  if (Rst_tx) begin
      state <= idle_state;
      done <= 1'b0;
      count <= 4'b0;
      end
      else
    case(state)
      idle_state: begin
                    Rs232_tx <= 1'b1;
                    done <= 1'b0;
                    if (start)
                      state <= start_state;
                    else
                      state <= idle_state;
                  end
      start_state: begin
                     Rs232_tx <= 1'b0;
                     state <= data_state;
                  end
      data_state: begin
                    Rs232_tx <= data[(data_width-1) - count];
                    if (count < data_width) begin
                      count <= count + 1'b1;
                      state <= data_state;
                    end
                    else if (count == data_width) begin
                      count <= 4'b0;
                      state <= stop_state;
                    end
                  end
      stop_state: begin
                    Rs232_tx <= 1'b1;
                    done <= 1'b1;
                    state <= idle_state;
                  end
      default: begin
                  state <= idle_state;
               end
    endcase
  end

//  always @(posedge clk or posedge Rst_tx) begin
//    if (Rst_tx) begin
//      state <= idle_state;
//      done <= 1'b0;
//      count <= 4'b0;
//    end
//    else begin
//      state <= next_state;
//    end
//  end
endmodule
