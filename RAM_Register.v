module RAMRegister(
input [7:0]Write_data, input [3:0]Write_addr, input [3:0]Aaddr,
input [3:0]Baddr,
input CLK_In,
input [2:0] Opcode,
input Write_Enable, output reg [7:0]OperandA, output reg [7:0]OperandB );
reg [7:0] RAMRegister [15:0]; //레지스터 어레이 주소 name 
integer i;
initial begin OperandA=0; OperandB=0;
for(i=0; i<16; i=i+1) RAMRegister[i] =8'b00000000;
integer j;
end
//RAM 레지스터 안의 값 초기화
always @(posedge CLK_In) begin
if (Opcode==4'b001 | Opcode==4'b110 |Opcode==4'b111 ) begin //immediate 를 사용하는 opcode 들을 분리
OperandA <= RAMRegister[Aaddr];
OperandB <= {4'b0000,Baddr}; //OperandB 는 스위치 입력으로 4bit 이기 때문에0000 을 앞에 붙여줌
end
else begin
OperandA <= RAMRegister[Aaddr]; 
OperandB <= RAMRegister[Baddr]; 
end
end
always @( negedge CLK_In) begin
RAMRegister[0] <=8'b00000000; //register 의 0 주소안의 값은 항상 0 으로 리셋 
if(Opcode==3'b000&Write_addr==4'b0000&Aaddr==4'b0000&Baddr==4'b0000&Write_Enable==1'b0) begin 
for(j=0; j<16; j=j+1)begin
RAMRegister[j] <=8'b00000000; //Ram 의 0 주소는 항상 0 으로 유지하기 때문에 0 에 쓰는 동작은 할수 없음. 불가능한 opcode 를 사용하여
end //controlblock 에서 받은 opcode 으 모든 bit 가 0 일때 Ram 안의 모든 값 0 으로 초기화
end
if (Write_Enable==1'b1) begin
RAMRegister[Write_addr] <=Write_data; //write_enable 이 1 일때 RAM 에 data 를 쓴다
end

end
endmodule
