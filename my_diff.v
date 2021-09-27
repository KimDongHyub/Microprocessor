module my_dff(input DFF_CLOCK, D, output reg Q);
always @ (posedge DFF_CLOCK) begin Q <= D;
end //debouce 를 위한 플립플롭 
endmodule
