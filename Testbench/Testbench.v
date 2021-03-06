`timescale 1ps / 1fs

module Testbench;
	reg clk = 0;
	reg [8:0] img [0:65536];
	reg [8:0] img_encrypted [0:65536];
	reg [0:63] secret_key = 64'b1101000_1100001_1110010_1100100_1110111_1100001_1110010_1100101; 
	reg [0:21] public_key = 22'b11_0100_1110_0001_1001_0001;
	integer i=0, j =0;
	
	wire [18:0] so1;
	wire [21:0] so2;
	wire [22:0] so3;
	reg [0:2] si;
	reg [0:2] en = 3'b000;
	reg [0:2] rst = 3'b111;
	reg majority_logic;
	
	shift_register_a lfsra(si[0], clk, rst[0], en[0], so1);
	shift_register_b lfsrb(si[1], clk, rst[1], en[1], so2);
	shift_register_c lfsrc(si[2], clk, rst[2], en[2], so3);
	
	initial 
	begin
		$readmemh("ps2_pic.txt", img);
	#1 rst = 3'b000;
	#2 rst = 3'b111;
	end
	
	always
	   #5 clk = ~clk;
	
	
    always @(posedge clk)
        begin
            if(j<8)
            begin
                if(i<64)
                begin
                    en = 3'b111;
                    si[0] = secret_key[i]^so1[13]^so1[16]^so1[17]^so1[18];
                    si[1] = secret_key[i]^so2[20]^so2[21];
                    si[2] = secret_key[i]^so3[7]^so3[20]^so3[21]^so3[22];
                    i = i+1;
                end
                if(i<86 && i>=64)
                begin
                    si[0] = public_key[i-64]^so1[13]^so1[16]^so1[17]^so1[18];
                    si[1] = public_key[i-64]^so2[20]^so2[21];
                    si[2] = public_key[i-64]^so3[7]^so3[20]^so3[21]^so3[22];
                    i = i+1;
                end
                if(i<186 && i>=86)
                begin
                    en = 3'b000;
                    majority_logic = (so1[8]&so2[10])|(so1[8]&so3[10])|(so2[10]&so3[10]);
                    if(so1[8] == majority_logic)
                    begin
                    en[0] = 1;
                    si[0] = so1[13]^so1[16]^so1[17]^so1[18];
                    #1 en[0] = 0;
                    end
                    if(so2[10] == majority_logic)
                    begin
                    en[1] = 1;
                    si[0] = so2[20]^so2[21];
                    #1 en[1] = 0;
                    end
                    if(so3[10] == majority_logic)
                    begin
                    en[2] = 1;
                    si[0] = so3[7]^so3[20]^so3[21]^so3[22];
                    #1 en[2] = 0;
                    end
                    i = i+1;
                end
                if(i<65722 && i>=186)
                begin 
                    majority_logic = (so1[8]&so2[10])|(so1[8]&so3[10])|(so2[10]&so3[10]);
                    img_encrypted[i-186][j] = img[i-186][j]^so1[18]^so2[21]^so3[22];
                    if(so1[8] == majority_logic)
                    begin
                    en[0] = 1;
                    si[0] = so1[13]^so1[16]^so1[17]^so1[18];
                    #1 en[0] = 0;
                    end
                    if(so2[10] == majority_logic)
                    begin
                    en[1] = 1;
                    si[0] = so2[20]^so2[21];
                    #1 en[1] = 0;
                    end
                    if(so3[10] == majority_logic)
                    begin
                    en[2] = 1;
                    si[0] = so3[7]^so3[20]^so3[21]^so3[22];
                    #1 en[2] = 0;
                    end
                    i=i+1;
                end
                if(i == 65722)
                begin
                    j = j + 1;
                    i=0;
                end
            end
        end
	
	initial
	#5257760 begin
		$writememh("Encrypted_image.hex",img_encrypted); 
	$finish;
	end
	
endmodule
