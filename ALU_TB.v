`timescale 1ns/1ps


module ALU_tb
#(parameter Width = 16);
  reg [Width-1:0] A,B;
  reg [4:0] F;
  reg Cin;
  wire[Width-1:0] Out;
  wire[5:0] Status;

// Instanstaite of ALI Block
ALU#(.Width(Width)) U_ALU (
    .A(A),
    .B(B),
    .Cin(Cin),
    .F(F),
    .Out(Out),
    .Status(Status)
);


initial
begin
        $display(" time    |        A        |        B        | Cin |   F   |       Out       | Status");
        $display("----------------------------------------------------------------------------------------");
	F   = 5'b00000;
	repeat(100)

	begin
	A   = $random;
	B   = $random;
	Cin = 1;        //$random;
	#1
        $display("%5t  | %b  %b   %b  %b  | %b   %b",
                $time, A, B, Cin, F, Out, Status);
	F = F + 1;
	#10;

	end


end
endmodule
