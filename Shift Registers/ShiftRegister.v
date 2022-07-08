`timescale 1ps / 1fs

module shift_register_a(
input si, clk, rst, en,
output reg [18:0]so
);

always @(posedge clk,negedge rst)
	if(rst!=1)
		so <= 19'b0000000000000000000;
	else begin 
		if(en==1)
			so <= {so[17:0], si};
		else
			so <= so;
	     end
	
endmodule

module shift_register_b(
input si, clk, rst, en,
output reg [21:0]so
);

always @(posedge clk, negedge rst)
	if(rst!=1)
		so <= 22'b0000000000000000000000;
	else begin 
		if(en==1)
			so <= {so[20:0], si};
		else
			so <= so;
	     end
	
endmodule

module shift_register_c(
input si, clk, rst, en,
output reg [22:0]so
);

always @(posedge clk,negedge rst)
	if(rst!=1)
		so <= 23'b00000000000000000000000;
	else begin 
		if(en==1)
			so <= {so[21:0], si};
		else
			so <= so;
	     end
	
endmodule