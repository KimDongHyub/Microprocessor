module ControlBlock( input CLK_In,input [3:0] User_input0, input [3:0] User_input1, output reg [15:0] Opcode, output reg [3:0] State);
reg [3:0]temp1;
reg [3:0]RAMread;
reg [3:0]OIM1; 
reg [3:0]OIM2; 
reg [3:0]OIM3; 
reg [3:0]OIM4;
initial begin Opcode[15:0]=0; 
State<=1;
end //초기화
//opcode input mode
always @(posedge CLK_In ) begin
if (User_input1 == 4'b1000) begin
State<=1; //버튼 4 번을 눌렀을때 idle 모드로 복귀하도록 설정 end
else begin
case (State) 1: begin Opcode<={4'b0000,User_input0[3:0],8'b00100000}; //슬라이드 스위치의 현재상태를 표시하기 위한 opcode
if ( User_input1 == 4'b0100) begin

Opcode<={4'b0000,4'b0000,3'b000,4'b0000,1'b0};//3 번 버튼을 눌렀을때 모든 비트가 0 인 안쓰는 opcode 를 보냄
end
if ( User_input0 == 4'b0010 & User_input1 == 4'b0001) begin State <=2;
Opcode<={4'b0000,User_input0[3:0],8'b00100000}; //슬라이드 스위치가 2 일때 state 2 로, 스위치의 상태 표시
end
if ( User_input0 == 4'b0100 & User_input1 == 4'b0001) begin State <=4;
Opcode<={4'b0000,User_input0[3:0],8'b00100000};//슬라이드 스위치가 4 일때 state4 로, 스위치의 상태 표시
end
if ( User_input0 == 4'b1000 & User_input1 == 4'b0001) begin State <=8;
Opcode<={4'b0000,User_input0[3:0],8'b00100000};//슬라이드 스위치가 8 일때 state8 로, 스위치의 상태 표시
end
end //Idle Mode
2:begin
Opcode<={4'b0000,User_input0[3:0],8'b00100000}; //스위치의 현재 상태 표시 if(User_input1 == 4'b0001 ) begin
temp1<=User_input0; //스위치 입력을 임시로 저장 
Opcode<={4'b0000,User_input0[3:0],8'b00100000};
State<=3; //button1 을 눌렀을때 state3 로 넘어감 end
if (User_input1 == 4'b1000) begin
State<=1; //button4 를 넣으면 state1 로 복귀
end
end //Data Save Mode(1)

3:begin Opcode<={4'b0000,User_input0[3:0],8'b00100000}; 
if(User_input1 == 4'b0001 ) begin
Opcode[0]<=1; //[0]=1 이므로 레지스터에 저장 Opcode[4:1]<=temp1; //임시로 저장한 것을 사용
Opcode[7:5]<=3'b001;
Opcode[11:8]<=User_input0; //저장할 값
Opcode[15:12]<=4'b0000; State<=1;
end
if (User_input1 == 4'b1000) begin State<=1;
end
end //Data Save Mode(2)
4:begin Opcode<={4'b0000,User_input0[3:0],8'b00100000};
if(User_input1 == 4'b0001 ) begin
RAMread<=User_input0; //임시로 RAMread 에 스위치 입력 저장
State<=5;
end
if (User_input1 == 4'b1000) begin State<=1;
end
end //Data read Mode(1) 5:begin
Opcode <= {4'b0000,RAMread,3'b000,8'b0000,1'b0}; //임시로 저장했던 RAMread 주소의값을 출력
if(User_input1 == 4'b0001 ) 
  begin State<=1;
end
if (User_input1 == 4'b1000) begin

State<=1; end
end
8:begin Opcode<={4'b0000,User_input0[3:0],8'b00100000}; 
if(User_input1 == 4'b0001) begin
OIM1<=User_input0; //스위치 임시저장
State<=9;
end
if (User_input1 == 4'b1000) begin State<=1;
end
end //op input mode(1)
9:begin Opcode<={4'b0000,User_input0[3:0],8'b00100000}; 
if(User_input1 == 4'b0001) begin
OIM2<=User_input0; //스위치 임시저장
State<=10;
end
if (User_input1 == 4'b1000) begin State<=1;
end
end //op input mode(2)
10:begin Opcode<={4'b0000,User_input0[3:0],8'b00100000}; 
if(User_input1 == 4'b0001) begin
OIM3<=User_input0; //스위치 임시저장
State<=12;
end
if (User_input1 == 4'b1000) begin

State<=1;
end
end //op input mode(3)
12:begin Opcode<={4'b0000,User_input0[3:0],8'b00100000}; 
if(User_input1 == 4'b0001) begin
OIM4<=User_input0; //스위치 임시저장
State<=15; end
if (User_input1 == 4'b1000) begin State<=1;
end
end //op input mode(4)
15:begin
Opcode<= {OIM1,OIM2,OIM3,OIM4};
//동작과 동시에 이게 7seg 에도 값을 표현함. 
if ( User_input1 == 4'b0001 | User_input1 == 4'b1000) begin
State<=1; end
end endcase end
end endmodule
