module ovclock(input Clk_100M, output reg slow_clk);
reg [26:0]counter=0;
always @(posedge Clk_100M) begin
counter <= (counter>=249999)?0:counter+1; 
slow_clk <= (counter < 125000)?1'b0:1'b1;
end //오버플로우 출력을 위해 눈에 보이는 깜빡임 정도로 클럭의 주파수를 낮춤 
endmodule
