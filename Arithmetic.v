module Arithmetic
#(parameter Width=16)
(
	input       [Width-1:0] A,B,
	input       Cin,
	input       [2:0] F,
	output reg  [Width-1:0] Out,
	output reg  Cout,
	output reg  [5:0] Status,
	output reg  C,Z,N,V,P,Af
);

reg [Width:0] temp;
reg overflow;

always @(*) 
begin

	case(F)
	3'b001:					//INC
	begin
		temp=A+1;
		Out=temp[Width-1:0];
		Cout=temp[Width];
		if(A[Width-1]^Out[Width-1])
			overflow=1'b1;
		else
			overflow=1'b0;
	end
////////////////////////////////////////////////////////////
	3'b011:					//DEC
		begin
		temp=A-1;
		Out=temp[Width-1:0];
		Cout=temp[Width];
		if(A[Width-1]^Out[Width-1])
			overflow=1'b1;
		else
			overflow=1'b0;
	end
////////////////////////////////////////////////////////////
	3'b100:					//ADD
		begin
		temp=A+B;
		Out=temp[Width-1:0];
		Cout=temp[Width];
		if( (A[Width-1] & B[Width-1]& ~Out[Width-1]) | ( ~A[Width-1] & ~B[Width-1]& Out[Width-1]) )
			overflow=1'b1;
		else
			overflow=1'b0;
	end
////////////////////////////////////////////////////////////
	3'b101:					//ADD_CARRY
	begin
		temp=A+B+Cin;
		Out=temp[Width-1:0];
		Cout=temp[Width];
		if( (A[Width-1] & B[Width-1]& ~Out[Width-1]) | ( ~A[Width-1] & ~B[Width-1]& Out[Width-1]) )
			overflow=1'b1;
		else
			overflow=1'b0;
	end
////////////////////////////////////////////////////////////
	3'b110:					//SUB
	begin
		temp=A-B;
		Out=temp[Width-1:0];
		Cout=temp[Width];
		if( (A[Width-1] & ~B[Width-1]& ~Out[Width-1]) | ( ~A[Width-1] & B[Width-1]& Out[Width-1]) )
			overflow=1'b1;
		else
			overflow=1'b0;
	end
////////////////////////////////////////////////////////////
	3'b111:					//SUB_BORROW
	begin
		temp=A-B-Cin;
		Out=temp[Width-1:0];
		Cout=temp[Width];
		if( (A[Width-1] & ~B[Width-1]& ~Out[Width-1]) | ( ~A[Width-1] & B[Width-1]& Out[Width-1]) )
			overflow=1'b1;
		else
			overflow=1'b0;
	end
////////////////////////////////////////////////////////////
	default:
	begin
		Out=0;
		Cout=0;
		overflow=0;
	end
////////////////////////////////////////////////////////////
	endcase


////////////////////////////////////////////////////////////
	C  = (F[2] | F[0]) ? Cout                          : 1'b0;                     		// Carry Flag
	Z  = (F[2] | F[0]) ? (Out=={Width{1'b0}})          : 1'b0;                     		// Zero Flag
	N  = (F[2] | F[0]) ? Out[Width-1]                  : 1'b0;                     		// Negative Flag
	V  = (F[2] | F[0]) ? overflow                      : 1'b0;                     		// Overflow Flag
	P  = (F[2] | F[0]) ? ~^Out                         : 1'b0;                     		// Parity Flag 
	Af = (F[2] | F[0]) ? ((A[3:0]+B[3:0]+Cin)>4'hF)    : 1'b0;                     		// Auxiliary Flag

// The if condition here is just to make the Flags = 0 when the two not used OP Codes in the Project Details



	Status={C,Z,N,V,P,Af}; // Concatenate

end
endmodule
