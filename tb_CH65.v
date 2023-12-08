`timescale 1ns / 1ps
module tb_CH65;
 reg clk,Rst_tx,start;
 reg [7:0] data;
 wire Rs232_tx;
 wire done;
 
 CH65 dut(.clk(clk),.Rst_tx(Rst_tx),.start(start),.data(data),.Rs232_tx(Rs232_tx),.done(done));
 
 always #5 clk=~clk;
 
 initial
  begin
   clk=1'b1;
   Rst_tx=1'b1;
   start=1'b0;
   data=8'b11101010;
   #10;
   Rst_tx=1'b0;
   start=1'b1;
   #200;
   $finish(2);
  end
 
endmodule
