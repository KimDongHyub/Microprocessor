module TOP(
input [3:0]Slide_Switch,
input [3:0]Button, //slide switch 와 button 이 입력
output [3:0]LED, output [6:0] segment0, output [6:0] segment1,
output [1:0] seg_enable, //led 와 segment 가 출력
input CLK
);
wire [3:0]User_Input1; wire [3:0]User_Input0; wire CLK_In;
wire [3:0]State;
wire [15:0]Opcode; wire [7:0]Result;
wire [7:0]OperandA; wire [7:0]OperandB;
 
wire overflow; //overflow 신호를 top 에서 연결하기 위해 wire underflow; //underflow 신호를 top 에서 연결하기 위해
IOBlock ioblock (.seg_enable(seg_enable),.Slide_Switch(Slide_Switch),.underflow(underflow),.overflow(ove rflow),.Button(Button),.LED(LED),.segment0(segment0),.segment1(segment1),.CLK(CLK),. User_Input0(User_Input0),.User_Input1(User_Input1),.CLK_In(CLK_In),.Result(Result),. State(State));
ControlBlock controlblock (.CLK_In(CLK_In),.User_input0(User_Input0),.User_input1(User_Input1),.Opcode(Opcod e),.State(State));
RAMRegister ramregister (.Opcode(Opcode[7:5]),.CLK_In(CLK_In),.Write_Enable(Opcode[0]),.Write_addr(Opcode[ 4:1]),.Aaddr(Opcode[15:12]),.Baddr(Opcode[11:8]),.OperandA(OperandA),.OperandB(Opera ndB),.Write_data(Result));
ALU alu (.OperandA(OperandA),.OperandB(OperandB),.underflow(underflow),.overflow(overflow),. Result(Result),.Opcode(Opcode[7:5]));
Endmodule
