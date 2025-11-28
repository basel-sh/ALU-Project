module Shift #(parameter Width=16)
(
input  [Width-1:0] A,
input  [2:0] F,
output reg C,Z,N,P,
output reg [Width-1:0] Out
);
reg Cshift;

always @(*) begin
    

    case (F)
        3'b000: begin
	    {C,Out} = {A,1'b0};
        end

        3'b001: begin
	    {Out,C} = {1'b0,A}; 
        end

        3'b010: begin
	    {C,Out} = {A,1'b0};
        end

        3'b011: begin
	    {Out,C} = {A[Width-1],A};
        end

        3'b100: begin
            {C,Out} = {A,A[Width-1]};
        end

        3'b101: begin
	    {Out,C} = {A[0],A};
        end

	3'b110:
	begin

	 Cshift = C;
	{C,Out} = {A,Cshift};
	end

	3'b111:
	begin

	 Cshift = C;
	{Out,C} = {Cshift,A};
	end

        default: begin
            Out = {Width{1'b0}};
            C   = 1'b0;
	    Z = 1'b0;
   	    N = 1'b0;
    	    P = 1'b0;
        end
    endcase


	Z = ~|Out;
    	N = Out[Width-1];
    	P = ~^Out;
    
end

endmodule
