module clock_div(input Clk_100M, output reg slow_clk);
reg [26:0]counter=0;
always @(posedge Clk_100M) begin
counter <= (counter>=9999)?0:counter+1; 
slow_clk <= (counter < 5000)?1'b0:1'b1;
end //입력받은 클럭으로 더 느린 클럭을 만듦 
endmodule
