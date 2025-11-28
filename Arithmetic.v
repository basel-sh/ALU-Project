module Arithmetic
#(parameter Width=16)(
input  [Width-1:0] A,B,
input Cin,
input [2:0] F,
output reg [Width-1:0] Out,
output reg Cout,
output reg [5:0] Status,
output reg C,Z,N,V,P,Af
);

reg [Width:0] temp;
reg overflow;

always @(*) begin

case(F)
3'b001:
begin
temp=A+1;
Out=temp[Width-1:0];
Cout=temp[Width];
if(A[Width-1]^Out[Width-1])
	overflow=1'b1;
else
	overflow=1'b0;
end
//////////////////////////////////
3'b011:
begin
temp=A-1;
Out=temp[Width-1:0];
Cout=temp[Width];
if(A[Width-1]^Out[Width-1])
	overflow=1'b1;
else
	overflow=1'b0;
end
//////////////////////////////////
3'b100:
begin
temp=A+B;
Out=temp[Width-1:0];
Cout=temp[Width];
if( (A[Width-1] & B[Width-1]& ~Out[Width-1]) | ( ~A[Width-1] & ~B[Width-1]& Out[Width-1]) )
	overflow=1'b1;
else
	overflow=1'b0;
end
//////////////////////////////////
3'b101:
begin
temp=A+B+Cin;
Out=temp[Width-1:0];
Cout=temp[Width];
if( (A[Width-1] & B[Width-1]& ~Out[Width-1]) | ( ~A[Width-1] & ~B[Width-1]& Out[Width-1]) )
	overflow=1'b1;
else
	overflow=1'b0;
end
//////////////////////////////////
3'b110:
begin
temp=A-B;
Out=temp[Width-1:0];
Cout=temp[Width];
if( (A[Width-1] & ~B[Width-1]& ~Out[Width-1]) | ( ~A[Width-1] & B[Width-1]& Out[Width-1]) )
	overflow=1'b1;
else
	overflow=1'b0;
end
//////////////////////////////////
3'b111:
begin
temp=A-B-Cin;
Out=temp[Width-1:0];
Cout=temp[Width];
if( (A[Width-1] & ~B[Width-1]& ~Out[Width-1]) | ( ~A[Width-1] & B[Width-1]& Out[Width-1]) )
	overflow=1'b1;
else
	overflow=1'b0;
end
//////////////////////////////////
default:
begin
Out=0;
Cout=0;
overflow=0;
end
//////////////////////////////////
endcase


///////////////////// FLAGS ///////////////////////
C  = (F[2] | F[0]) ? Cout                          : 1'b0;                     		// Carry flag
Z  = (F[2] | F[0]) ? (Out=={Width{1'b0}})          : 1'b0;                     		// Zero flag
N  = (F[2] | F[0]) ? Out[Width-1]                  : 1'b0;                     		// Negative flag (MSB for signed)
V  = (F[2] | F[0]) ? overflow                      : 1'b0;                     		// Over Flow Flag
P  = (F[2] | F[0]) ? ~^Out                         : 1'b0;                     		// Parity flag (1 if even number of 1s)
Af = (F[2] | F[0]) ? ((A[3:0]+B[3:0]+Cin)>4'hF)    : 1'b0;                     		// Aux flag

// The if condition here is just to make the Flags = o when the two not used OP Codes in the Project Details



Status={C,Z,N,V,P,Af}; // Concatenate

end
endmodule
