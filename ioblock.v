module IOBlock( input [7:0] Result, input [3:0] State,
 
input CLK,
input [3:0]Slide_Switch, input [3:0] Button,
output output
output
output output output
output );
reg [3:0] User_Input0, reg [3:0] User_Input1,
input overflow, //alu 로 부터 받은 overflow 신호 input underflow, //alu 로 부터 받은 underflow 신호
CLK_In, //ioblock 에서 만든 CLK_In 을 다른 모듈로 전달
reg [3:0] LED, [6:0] segment0, [6:0] segment1,
[1:0] seg_enable //segment 에 표시를 위한 output 들
reg ovf;
reg unf;
wire CLK_5M; wire CLK_125M;
wire [3:0]pButton; //button 의 debounce 과정을 거친 pButton wire CLK_in;
wire overclock; //오버플로우 및 언더플로우 표시를 위해 깜빡임을 표시하기 위한 CLK_IN 보다 더 느린클락
wire [3:0] digit_1000; wire [3:0] digit_100; wire [3:0] digit_10; wire [3:0] digit_1;
wire [14:0] mod_1000; wire [14:0] mod_100; wire [14:0] mod_10;
wire [3:0] digit_1000_100;

wire [3:0] digit_10_1; assign CLK_125M=CLK;
assign digit_1000= Result/1000; // 1000 으로 나눈 몫을 digit_1000 으로 설정 
assign mod_1000=Result-(digit_1000*1000);// 1000 으로 나눈 나머지
assign digit_100=mod_1000/100; //1000 으로 나눈 나머지를 100 을로 나눈 몫 
assign mod_100=mod_1000-(digit_100*100); //1000 으로 나눈 나머지를 100 으로나눈 나머지
assign digit_10 =mod_100/10;
assign mod_10=mod_100-(digit_10*10);
assign digit_1=mod_10; //동일하게 digit_10,mod_10,digit_1 을 설정 
assign digit_1000_100=(CLK_In)?digit_1000:digit_100;
assign digit_10_1=(CLK_In)?digit_10:digit_1;
assign seg_enable =(CLK_In)?2'b11:2'b00; //CLK_In 이 1 일 때 seg_enable 은 11,0 일 때 00
assign digit_1 = mod_10;
always@ (Result) begin //result 가 바뀔때마다 if(overflow==1)
begin
ovf<=1'b1; //ipnut overflow 가 1 이면 레지스터 ovf 가 1 이됨
end
else begin
ovf<=1'b0; //overflow 가 0 이면 ovf 는 0
end if(underflow==1) begin
unf<=1'b1;//ipnut underflow 가 1 이면 레지스터 unf 가 1 이됨 end

else begin
unf<=1'b0;//underflow 가 0 이면 unf 는 0
end end
always @( pButton ) //pButton 이 바뀔때 begin
if(ovf==1'b1 | unf==1'b1)begin //ovf 가 1 이거나 unf 가 1 이면
LED[0]<=overclock; 
 LED[1]<=overclock; 
 LED[2]<=overclock;
LED[3]<=overclock; //LED 에 overclock 의 주기로 깜빡임 출력 
User_Input1<=pButton; //User_Input1 에 pButton 의 값을 넣음
User_Input0<=Slide_Switch; //User_Input0 에 Slide_switch 값을 넣음
end
if(ovf==1'b0 & unf==1'b0) begin //ovf 가 0 이고 unf 가 0 이면 
User_Input1<=pButton; //User_Input1 에 pButton 의 값을 넣음
User_Input0<=Slide_Switch; //User_Input0 에 Slide_switch 값을 넣음 
LED<=State; //LED 에 State 를 넣음
end end
bcd7segment seg1000_100(.bcd(digit_1000_100),.segment(segment0)); //bcd7segment 모듈(1000,100)을 연결

bcd7segment seg10_1(.bcd(digit_10_1),.segment(segment1)); //bcd7segment 모듈(10,1)을 연결
debounce debounce1 (.pb_1(Button[0]),.clk(CLK_5M),.pb_out(pButton[0])); 
debounce debounce2(.pb_1(Button[1]),.clk(CLK_5M),.pb_out(pButton[1])); 
debounce debounce3 (.pb_1(Button[2]),.clk(CLK_5M),.pb_out(pButton[2])); 
debounce debounce4 (.pb_1(Button[3]),.clk(CLK_5M),.pb_out(pButton[3]));
//button 별로 debounce 된버튼을 출력하는 deboucne 모듈//////// 
clk_div A1(CLK_5M,CLK_In); //deboucne 를 위한 clk 만드는 모듈
ovclock ovclock(CLK_5M,overclock); //오버플로우 깜빡임 출력을 위해 더느린 클럭을 만드는 모듈
CLK_5MHz instance_name //IP 를 통해 만든 클럭
(// 
Clock in ports .CLK_125M(CLK_125M), // IN // 
Clock out ports .CLK_5M(CLK_5M) // OUT
// Status and control signals
);// IN)); // OUT
// INST_TAG_END ------ End INSTANTIATION Template ---------
Endmodule
////segment
module bcd7segment( input [3:0]bcd,
output reg[6:0]segment
); //0~9 에 해당하는 숫자를 segment 로 표시하는 모듈
always @(bcd) begin
case(bcd)

endmodule
