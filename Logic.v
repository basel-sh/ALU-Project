module Logic
#(parameter Width = 16)
(
	input      [Width-1:0] A,B,
	input      [2:0] F,
	output reg Z,N,P,
	output reg [Width-1:0] Out
);


always@(*) begin
    case(F)
        3'b000:					//AND
	begin
		Out = A & B;
		Z = ~|Out;		//Zero Flag
        N = Out[Width-1];	//Negative Flag
        P = ~^Out;		//Parity Flag
	end
////////////////////////////////////////////////////////////
        3'b001:					//OR 
	begin
		Out = A | B;
		Z = ~|Out;		//Zero Flag
        N = Out[Width-1];	//Negative Flag
        P = ~^Out;		//Parity Flag
	end
////////////////////////////////////////////////////////////
        3'b010:					//XOR 
	begin
		Out = A ^ B;		
		Z = ~|Out;		//Zero Flag
        N = Out[Width-1];	//Negative Flag
        P = ~^Out;		//Parity Flag
	end
////////////////////////////////////////////////////////////
        3'b011:					//NOT 
	begin
		Out = ~A;		
		Z = ~|Out;		//Zero Flag
        N = Out[Width-1];	//Negative Flag
        P = ~^Out;		//Parity Flag
	end
////////////////////////////////////////////////////////////
        default: 
	begin
		Out = 1'b0;		
		Z = 1'b0;		//Zero Flag
        N = 1'b0;		//Negative Flag
        P = 1'b0;		//Parity Flag
	end
////////////////////////////////////////////////////////////
    endcase

end
endmodule

