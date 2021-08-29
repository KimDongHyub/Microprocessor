module ALU(
input [2:0] Opcode, input [7:0] OperandA, input [7:0] OperandB, output reg [7:0] Result,);
reg [15:0] ovResult; 
reg [7:0] stResult;
always@(OperandA or OperandB) begin
case(Opcode)
output reg overflow, output reg underflow
overflow<=0; 
underflow<=0;
3'b000: //000 코드 일 때 덧셈 begin
stResult<=OperandA+OperandB; //정상 동작인 결과
ovResult<=OperandA+OperandB; //오류 동작인 결과
if(ovResult>255) //result 가 255 까지밖에 저장 하지 못하므로 더 큰 bit 수를 가진 ovResult 에도 값을저장, 255 보다 클 경우,
begin
overflow<=1; //overflow 를 1 로 설정하고
Result<=255; //result 는 255
end
else begin
Result<=stResult; //정상동작인경우 결과는 정상동작 결과 end
end 3'b001:
begin stResult<=OperandA+OperandB;
ovResult<=OperandA+OperandB;
if(ovResult>255) //addi 명령어의 경우에도 똑같이 oveflow 발생시표시
begin overflow<=1;
end
else begin
Result<=stResult; 
end
Result<=255;

end 3'b010:
begin
if(OperandA<OperandB) //부호없는 연산이므로 OperandA<B 이면 오류
begin
underflow<=1; //underflow=1
end else
Result<=0; //result =0 으로 설정
begin
Result<=OperandA-OperandB; //A>=B 이면 정상동작
end end
3'b011: begin
Result<=(OperandA&OperandB); //&연산
end 3'b100:
begin
Result<=(OperandA|OperandB); //or 연산
end 3'b101:
begin
Result<=~(OperandA); //not 연산
end 3'b110:
begin
Result<=(OperandA <<OperandB); //shift left 연산
end 3'b111:
begin

Result<=(OperandA >>OperandB); //shift right 연산 end
endcase end
