module Logic#(parameter Width = 16)(
input [Width-1:0] A,B,
input [2:0] F,
output reg Z,N,P,
output reg [Width-1:0] Out
);


always@(*) begin
    case(F)
        3'b000: 
	begin
	Out = A & B;
	Z = ~|Out;
        N = Out[Width-1];
        P = ~^Out;
	end

        3'b001: 
	begin
	Out = A | B;
	Z = ~|Out;
        N = Out[Width-1];
        P = ~^Out;
	end

        3'b010: 
	begin
	Out = A ^ B;
	Z = ~|Out;
        N = Out[Width-1];
        P = ~^Out;
	end
        3'b011: 
	begin
	Out = ~A;
	Z = ~|Out;
        N = Out[Width-1];
        P = ~^Out;
	end
        default: 
	begin
	Out = 1'b0;
	Z = 1'b0;
        N = 1'b0;
        P = 1'b0;
	end
	
    endcase

end

endmodule
