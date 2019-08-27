module patapon(input clk,
					input buttonA,buttonB,buttonC,buttonD,
					output reg [7:0] ledr,ledg,ledb,
					output enable,
					output reg [2:0] comm,
					output reg [4:0] bloodled,
					output reg a,b,c,d,e,f,g,
					output reg [2:0] testC,
					output reg [2:0] testD,
					output beep);
	
	freq4 F4(clk, clk4);
	freq10 F10(clk, clk10);
	freq440 F440(clk,clk440);
	freq1000 F1000(clk, clk1000);
	logic [7:0] wG [7:0]='{8'b11111111,
								  8'b11101111,
								  8'b10001101,
								  8'b01101110,
								  8'b01111110,
								  8'b01111110,
								  8'b10000001,
								  8'b11111111};
								  
	logic [7:0] wA [7:0]='{8'b11111111,
								  8'b11111111,
								  8'b00000011,
								  8'b11011101,
								  8'b11011110,
								  8'b11011101,
								  8'b00000011,
								  8'b11111111};
								  
	logic [7:0] wM [7:0]='{8'b11111111,
								  8'b11111111,
								  8'b00000000,
								  8'b11111011,
								  8'b11110111,
								  8'b11111011,
								  8'b00000000,
								  8'b11111111};
								  
	logic [7:0] wE [7:0]='{8'b11111111,
								  8'b11111111,
								  8'b01110110,
								  8'b01110110,
								  8'b01110110,
								  8'b01110110,
								  8'b00000000,
								  8'b11111111};
								  
	logic [7:0] wO [7:0]='{8'b11111111,
								  8'b11111111,
								  8'b10000001,
								  8'b01111110,
								  8'b01111110,
								  8'b01111110,
								  8'b10000001,
								  8'b11111111};
								  
	logic [7:0] wV [7:0]='{8'b11111111,
								  8'b11111111,
								  8'b11000000,
								  8'b10111111,
								  8'b01111111,
								  8'b10111111,
								  8'b11000000,
								  8'b11111111};
								  
	logic [7:0] wR [7:0]='{8'b11111111,
								  8'b11111111,
								  8'b01110001,
								  8'b10101110,
								  8'b10101110,
								  8'b11001110,
								  8'b00000000,
								  8'b11111111};
								  
	logic [7:0] w1 [7:0]='{8'b11111011,
								  8'b11101111,
								  8'b01110111,
								  8'b10110100,
								  8'b11000100,
								  8'b01000111,
								  8'b10110111,
								  8'b11110111};
									  
	logic [7:0] w2 [7:0]='{8'b11110111,
								  8'b11110111,
								  8'b11110111,
								  8'b00110111,
								  8'b11000100,
								  8'b11000100,
								  8'b00110111,
								  8'b11110111};
									  
	logic [7:0] w3 [7:0]='{8'b11101111,
								  8'b11111011,
								  8'b11110111,
								  8'b10110111,
								  8'b01000111,
								  8'b11000100,
								  8'b10110100,
								  8'b01110111};
			  
	reg [5:0] led;
	reg [2:0] playerblood;
	reg hadhit;
	reg A,B,C,D;
	reg [4:0] eighttenclk;
	reg [3:0] commchange;
	reg [2:0] stepcount;
	reg [3:0] jumpcount;
	reg [2:0] defendtime;
	reg [2:0] myshoottime;
	reg correctAC, correctBD ,correctBC ,correctAD ,correctC ,correctD;
	reg [1:0] countC;
	reg [1:0] countD;
	reg [2:0] shootposition;
	reg [2:0] playerposition;
	reg [2:0] win;
	reg con;
	reg reblood;
	reg usedefend;
	reg clear;
	reg close;
	reg skillclear;
	reg skillstop;
	reg sk1,sk2,sk3,sk4;
	reg walk;
	reg jump;
	reg defend;
	reg [10:0]timeclk;
	reg shoot;
	reg beepopen;
	reg stopwalk;
	reg [4:0] stage;
	reg playerdead;
	reg [3:0]dead;
   ////enemy////
	/*1*/
	reg [1:0] enemywalk1;
	reg enemyhit1;
	reg [1:0] enemyblood1;
	reg enemydead1;
	/*2*/
	reg [1:0] enemywalk2;
	reg enemyhit2;
	reg [1:0] enemyblood2;
	reg enemydead2;
	reg [3:0] enemyshoot2;
	reg enemytime2;
	reg [4:0] enemyspace2;
	reg [3:0] shootp2;
	reg firstshot2;
	reg secondshot2;
	/*3*/
	reg [1:0] enemywalk3;
	reg enemyhit3;
	reg [1:0] enemyblood3;
	reg enemydead3;
	reg [3:0] enemyshoot3;
	reg enemytime3;
	reg [4:0] enemyspace3;
	reg [3:0] shootp3;
	reg [2:0] enemyposition;
	/*4*/
	reg [1:0] enemywalk4;
	reg enemyhit4;
	reg [1:0] enemyblood4;
	reg enemydead4;
	reg [3:0] enemyshoot4;
	reg enemytime4;
	reg [4:0] enemyspace4;
	reg [3:0] shootp4;
	reg firstshot4;
	reg secondshot4;
	/*5*/
	reg [1:0] enemywalk5;
	reg enemyhit5;
	reg [2:0] enemyblood5;
	reg enemydead5;
	reg [3:0] enemyshoot5;
	reg enemytime5;
	reg [4:0] enemyspace5;
	reg [3:0] shootp5;
	reg [2:0] enemyposition5;
	reg bossdead;
	////enemy////
	initial
		begin
			bossdead=0;
			playerblood=3'b011;	
			ledr=8'b11111111;
			ledg=8'b11111111;
			ledb=8'b11111111;	
			playerdead=0;
			hadhit=1;
			usedefend=0;
			playerposition=3'b000;
			enemydead1=0;
			enemydead2=0;
			enemydead3=0;
			enemydead5=0;
			enemydead4=0;
			enemytime2=0;
			enemytime4=0;
			enemytime3=0;
			enemytime5=0;
			enemyspace2=5'b10100;
			enemyspace4=5'b10100;
			enemyspace3=5'b10100;
			enemyspace5=5'b10100;
			shootp2=3'b111;
			shootp4=3'b111;
			shootp3=3'b111;
			shootp5=3'b111;
			comm=0;
			dead=4'b0000;
			clear=1;
			enable=1;
			eighttenclk=5'b00010;
		end
	always@(posedge clk10)//make eighttenclk become 00010 per 8/10s
		begin
			if(eighttenclk>5'b01000)begin
				eighttenclk<=5'b00010;
				end
			else begin
				eighttenclk<=eighttenclk+5'b00001;
				end		
			if(playerblood==3'b001)begin
				a<=1;b<=0;c<=0;d<=1;e<=1;f<=1;g<=1;
				end
			else if(playerblood==3'b010)begin
				a<=0;b<=0;c<=1;d<=0;e<=0;f<=1;g<=0;
				end
			else if(playerblood==3'b011)begin
				a<=0;b<=0;c<=0;d<=0;e<=1;f<=1;g<=0;
				end
			else if(playerblood==3'b100)begin
				a<=1;b<=0;c<=0;d<=1;e<=1;f<=0;g<=0;
				end
			else if(playerblood==3'b101)begin
				a<=0;b<=1;c<=0;d<=0;e<=1;f<=0;g<=0;
				end
			else begin
				a<=0;b<=0;c<=0;d<=0;e<=0;f<=0;g<=1;
				end
		end
	always@(posedge clk440)
		begin
			if(beepopen==1)begin
				beep<=~beep;
				end
			else
				beep<=0;
		end
	always@(negedge hadhit,posedge defend,posedge reblood)
		begin
			if(defend)begin
				if(usedefend==0)
					playerblood<=3'b011;
				else if(reblood==1)
					playerblood<=3'b011;
				end
			else if(reblood==1)
				playerblood<=3'b011;
			else
				playerblood<=playerblood-3'b001;
		end
	always@(posedge enemyhit1)//the blood of enemy1
		begin
			enemyblood1<=enemyblood1+2'b01;
		end
	always@(posedge enemyhit2)//the blood of enemy2
		begin
			enemyblood2<=enemyblood2+2'b01;
		end
	always@(posedge enemyhit4)//the blood of enemy4
		begin
			enemyblood4<=enemyblood4+2'b01;
		end
	always@(posedge enemyhit3)//the blood of enemy3
		begin
			enemyblood3<=enemyblood3+2'b01;
		end
	always@(posedge enemyhit5)//the blood of enemy5
		begin
			enemyblood5<=enemyblood5+3'b001;
		end
	always@(posedge enemytime2)
		begin
			enemyspace2<=enemyspace2+5'b00001;
			if(enemyspace2>=5'b11111)// shooting timing
				enemyspace2<=5'b00001;
		end
	always@(posedge enemytime4)
		begin
			enemyspace4<=enemyspace4+5'b00001;
			if(enemyspace4>=5'b11111)// shooting timing
				enemyspace4<=5'b00001;
		end
	always@(posedge enemytime3)
		begin
			enemyspace3<=enemyspace3+5'b00001;
			if(enemyspace3>=5'b11111)// shooting timing
				enemyspace3<=5'b00001;
		end
	always@(posedge enemytime5)
		begin
			enemyspace5<=enemyspace5+5'b00001;
			if(enemyspace5>=5'b11111)// shooting timing
				enemyspace5<=5'b00001;
		end
	always@(posedge clk1000)//led control
		begin
		////////////////////////////////////////change cols of led
		if(commchange>=3'b111)
			commchange<=3'b000;
		else
			commchange<=commchange+3'b001;
		comm<=commchange;
		////////////////////////////////////////
		if(playerdead)begin
			beepopen<=1;
			if(dead==4'b0000&&eighttenclk==5'b00110)
				dead<=4'b0001;//g
			else if(dead==4'b0001&&eighttenclk==5'b00010)
				dead<=4'b0010;//a
			else if(dead==4'b0010&&eighttenclk==5'b00110)
				dead<=4'b0011;//m
			else if(dead==4'b0011&&eighttenclk==5'b00010)
				dead<=4'b0100;//e
			else if(dead==4'b0100&&eighttenclk==5'b00110)
				dead<=4'b0101;//o
			else if(dead==4'b0101&&eighttenclk==5'b00010)
				dead<=4'b0110;//v
			else if(dead==4'b0110&&eighttenclk==5'b00110)
				dead<=4'b0111;//e
			else if(dead==4'b0111&&eighttenclk==5'b00010)
				dead<=4'b1000;//r
			else if(dead==4'b1000&&eighttenclk==5'b00110)
				dead<=4'b0000;//" "
			/////
			if(dead==4'b0000)begin
				ledr=8'b11111111;
				ledg=8'b11111111;
				ledb=8'b11111111;
				end
			else if(dead==4'b0001)
				ledr<=wG[comm];
			else if(dead==4'b0010)
				ledr<=wA[comm];
			else if(dead==4'b0011)
				ledr<=wM[comm];
			else if(dead==4'b0100)
				ledr<=wE[comm];
			else if(dead==4'b0101)
				ledr<=wO[comm];
			else if(dead==4'b0110)
				ledr<=wV[comm];
			else if(dead==4'b0111)
				ledr<=wE[comm];
			else if(dead==4'b1000)begin
				beepopen<=0;
				ledr<=wR[comm];
				end
			
			////
			end
		/////
		else if(bossdead==1)begin
				beepopen<=0;
				if(win==3'b000&&eighttenclk==5'b00110)
					win<=3'b001;
				else if(win==3'b001&&eighttenclk==5'b00010)
					win<=3'b010;
				else if(win==3'b010&&eighttenclk==5'b00110)
					win<=3'b011;
				else if(win==3'b011&&eighttenclk==5'b00010)
					win<=3'b100;
				else if(win==3'b100&&eighttenclk==5'b00110)
					win<=3'b001;
				/////
				if(win==3'b000)begin
					ledr<=8'b11111111;
					ledg<=8'b11111111;
					ledb<=8'b11111111;
					end
				else if(win==3'b001)begin
					ledg<=w1[comm];
					beepopen<=1;
					end
				else if(win==3'b010)begin
					ledg<=w2[comm];
					beepopen<=0;
					end
				else if(win==3'b011)begin
					ledg<=w3[comm];
					beepopen<=1;
					end
				else if(win==3'b100)begin
					ledg<=w2[comm];
					beepopen<=0;
					end
				end
		/////
		else begin
			if(playerblood==3'b000)
				playerdead<=1;
			///////initial zone
			timeclk<=timeclk+1;
			if(timeclk==11'b10000000000)begin
				timeclk<=11'b00001111111;			
				end
			if(timeclk==11'b00000000000)begin
				shootp2<=3'b111;
				shootp3<=3'b111;
				shootp4<=3'b111;
				shootp5<=3'b111;
				reblood<=1;
				end
			if(eighttenclk==5'b00110)
				reblood<=0;
			////////////////////////////////////////walk to create enemy
			//////////
			//enemy1//
			//////////just appear and 2 blood
			if(stage==5'b00011&&enemydead1==0)begin
				if(eighttenclk==5'b00101&&enemywalk1==2'b00)
					enemywalk1<=2'b01;
				else if(eighttenclk==5'b00111&&enemywalk1==2'b01)
					enemywalk1<=2'b10;
				/////
				if(enemywalk1==2'b01)begin
					if(comm==3'b110)begin
						bloodled[0]<=1;bloodled[1]<=1;//enemy blood initial
						ledr[4]<=0;ledr[5]<=0;
						end
					else begin
						ledr[4]<=1;ledr[5]<=1;
						end
					end
				else if(enemywalk1==2'b10)begin
					if(comm==3'b101)begin
						ledr[4]<=0;ledr[5]<=0;
						end
					else begin
						ledr[4]<=1;ledr[5]<=1;
						end
					end
				/////
				stopwalk<=1;		
				if(shootposition==3'b101)begin
					enemyhit1<=1;
					if(enemyblood1==2'b01)
						bloodled[1]<=0;
					else if(enemyblood1==2'b10)
						bloodled[0]<=0;
					end
				else begin
					enemyhit1<=0;
					end
				if(enemyblood1>=2'b10)begin
					enemydead1<=1;
					end
				end
			//////////
			//enemy2//
			//////////3 blood and shoot
			else if(stage==5'b00101&&enemydead2==0)begin
				if(eighttenclk==5'b00101&&enemywalk2==2'b00)
					enemywalk2<=2'b01;
					
				else if(eighttenclk==5'b00111&&enemywalk2==2'b01)
					enemywalk2<=2'b10;
				/////
				if(enemywalk2==2'b01)begin
					if(comm==3'b110)begin
						bloodled[0]<=1;bloodled[1]<=1;bloodled[2]<=1;
						ledr[4]<=0;ledr[5]<=0;ledr[3]<=0;
						end
					else begin
						ledr[4]<=1;ledr[5]<=1;ledr[3]<=1;
						end
					end
				else if(enemywalk2==2'b10)begin
					if(comm==3'b101)begin
						ledr[4]<=0;ledr[5]<=0;ledr[3]<=0;
						end
					else begin
						ledr[4]<=1;ledr[5]<=1;ledr[3]<=1;
						end
					end
				/////
				stopwalk<=1;	
				/////shoot
				
				if(enemyspace2==5'b00010||enemyspace2==5'b00011||enemyspace2==5'b00100)begin
					if(comm==3'b100)begin
						shootp2<=3'b100;
						ledr[4]<=0;
						end
					else if(comm==3'b111)
						ledr[4]<=1;
					end
				else if(enemyspace2==5'b00101||enemyspace2==5'b00110||enemyspace2==5'b00111)begin
					if(comm==3'b011)begin
						shootp2<=3'b011;
						ledr[4]<=0;
						end
					else if(comm==3'b100)
						ledr[4]<=1;
					end
				else if(enemyspace2==5'b01000||enemyspace2==5'b01001||enemyspace2==5'b01010)begin
					if(comm==3'b010)begin
						shootp2<=3'b010;
						ledr[4]<=0;
						end
					else if(comm==3'b011)
						ledr[4]<=1;
					end
				else if(enemyspace2==5'b01011||enemyspace2==5'b01100||enemyspace2==5'b01101)begin
					if(comm==3'b001)begin
						shootp2<=3'b001;
						ledr[4]<=0;
						end
					else if(comm==3'b010)
						ledr[4]<=1;
					end
				else if(enemyspace2==5'b01110||enemyspace2==5'b01111||enemyspace2==5'b10000)begin
					if(comm==3'b000)begin
						shootp2<=3'b000;
						ledr[4]<=0;
						end
					else if(comm==3'b001)
						ledr[4]<=1;
					end
				else if(enemyspace2==5'b10001||enemyspace2==5'b10010||enemyspace2==5'b10011)begin
					if(comm==3'b111)begin
						shootp2<=3'b111;
						ledr[4]<=0;
						end
					else if(comm==3'b000)
						ledr[4]<=1;
					end
				else begin
					if(comm==3'b111||comm==3'b000||comm==3'b001||comm==3'b010||comm==3'b011||comm==3'b111)begin
						shootp2<=3'b111;
						ledr[4]<=1;
						end
					end
				/////
				if(shootp2==3'b000&&(playerposition==3'b000||playerposition==3'b001))
					hadhit<=0;
				else
					hadhit<=1;
				/////
				if(eighttenclk==5'b00110||eighttenclk==5'b00010)
					enemytime2<=1;
				else
					enemytime2<=0;
				/////
				if(shootposition==3'b101)begin
					if(enemyblood2==2'b01)
						bloodled[2]<=0;
					else if(enemyblood2==2'b10)
						bloodled[1]<=0;
					else if(enemyblood2==2'b11)
						bloodled[0]<=0;
					enemyhit2<=1;
					end
				else begin
					enemyhit2<=0;
					end
				if(enemyblood2>=2'b11)begin
					enemydead2<=1;
					end
				end
			//////////
			//enemy3//
			//////////3 blood fly
			else if(stage==5'b00111&&enemydead3==0)begin
				if(eighttenclk==5'b00101&&enemywalk3==2'b00)
					enemywalk3<=2'b01;
				else if(eighttenclk==5'b00111&&enemywalk3==2'b01)
					enemywalk3<=2'b10;
				/////
				if(enemywalk3==2'b01)begin
					if(comm==3'b110)begin
						bloodled[0]<=1;bloodled[1]<=1;bloodled[2]<=1;
						ledr[4]<=1;ledr[5]<=1;
						end
					else begin
						ledr[4]<=1;ledr[5]<=1;
						end
					end
				else if(enemywalk3==2'b10)begin
					if(comm==3'b101)begin
						ledr[4]<=1;ledr[5]<=1;
						end
					else begin
						ledr[4]<=1;ledr[5]<=1;
						end
					end
				/////
				stopwalk<=1;
				/////jump
				if(enemyspace3>=5'b00001&&enemyspace3<=5'b00101)begin
					if(comm==3'b101)begin
						ledr[4]<=0;ledr[5]<=0;ledr[3]<=1;ledr[2]<=1;ledr[1]<=1;
						enemyposition<=3'b000;
						end
					else begin
						ledr[4]<=1;ledr[5]<=1;
						end
					end
				else if(enemyspace3>=5'b00110&&enemyspace3<=5'b01010)begin
					if(comm==3'b101)begin
						ledr[4]<=0;ledr[3]<=0;ledr[5]<=1;ledr[2]<=1;ledr[1]<=1;
						enemyposition<=3'b001;
						end
					else begin
						ledr[4]<=1;ledr[3]<=1;
						end
					end
				else if(enemyspace3>=5'b01011&&enemyspace3<=5'b01111)begin
					if(comm==3'b101)begin
						ledr[2]<=0;ledr[3]<=0;ledr[4]<=1;ledr[5]<=1;ledr[1]<=1;
						enemyposition<=3'b010;
						end
					else begin
						ledr[2]<=1;ledr[3]<=1;
						end
					end
				else if(enemyspace3>=5'b10000&&enemyspace3<=5'b10101)begin
					if(comm==3'b101)begin
						ledr[1]<=0;ledr[2]<=0;ledr[3]<=1;ledr[4]<=1;ledr[5]<=1;
						enemyposition<=3'b011;
						end
					else begin
						ledr[1]<=1;ledr[2]<=1;
						end
					end
				else if(enemyspace3>=5'b10110&&enemyspace3<=5'b11001)begin
					if(comm==3'b101)begin
						ledr[3]<=0;ledr[2]<=0;ledr[1]<=1;ledr[4]<=1;ledr[5]<=1;
						enemyposition<=3'b010;
						end
					else begin
						ledr[2]<=1;ledr[3]<=1;
						end
					end
				else if(enemyspace3>=5'b11010&&enemyspace3<=5'b11111)begin
					if(comm==3'b101)begin
						ledr[3]<=0;ledr[4]<=0;ledr[2]<=1;ledr[5]<=1;ledr[1]<=1;
						enemyposition<=3'b001;
						end
					else begin
						ledr[4]<=1;ledr[3]<=1;
						end
					end			
				/////shoot			
				if(enemyspace3==5'b00010||enemyspace3==5'b00011||enemyspace3==5'b00100)begin
					if(comm==3'b100)begin
						shootp3<=3'b100;
						ledr[4]<=0;
						end
					else if(comm==3'b111)
						ledr[4]<=1;
					end
				else if(enemyspace3==5'b00101||enemyspace3==5'b00110||enemyspace3==5'b00111)begin
					if(comm==3'b011)begin
						shootp3<=3'b011;
						ledr[4]<=0;
						end
					else if(comm==3'b100)
						ledr[4]<=1;
					end
				else if(enemyspace3==5'b01000||enemyspace3==5'b01001||enemyspace3==5'b01010)begin
					if(comm==3'b010)begin
						shootp3<=3'b010;
						ledr[4]<=0;
						end
					else if(comm==3'b011)
						ledr[4]<=1;
					end
				else if(enemyspace3==5'b01011||enemyspace3==5'b01100||enemyspace3==5'b01101)begin
					if(comm==3'b001)begin
						shootp3<=3'b001;
						ledr[4]<=0;
						end
					else if(comm==3'b010)
						ledr[4]<=1;
					end
				else if(enemyspace3==5'b01110||enemyspace3==5'b01111||enemyspace3==5'b10000)begin
					if(comm==3'b000)begin
						shootp3<=3'b000;
						ledr[4]<=0;
						end
					else if(comm==3'b001)
						ledr[4]<=1;
					end
				else if(enemyspace3==5'b10001||enemyspace3==5'b10010||enemyspace3==5'b10011)begin
					if(comm==3'b111)begin
						shootp3<=3'b111;
						ledr[4]<=0;
						end
					else if(comm==3'b000)
						ledr[4]<=1;
					end
				else begin
					if(comm==3'b111||comm==3'b000||comm==3'b001||comm==3'b010||comm==3'b011||comm==3'b111)begin
						shootp3<=3'b111;
						ledr[4]<=1;
						end
					end
				/////
				if(shootp3==3'b000&&(playerposition==3'b000||playerposition==3'b001))
					hadhit<=0;
				else
					hadhit<=1;
				/////
				if(eighttenclk==5'b00110||eighttenclk==5'b00010)
					enemytime3<=1;
				else
					enemytime3<=0;
				/////
				if(shootposition==3'b101&&(enemyposition==3'b000||enemyposition==3'b001))begin
					if(enemyblood3==2'b01)
						bloodled[2]<=0;
					else if(enemyblood3==2'b10)
						bloodled[1]<=0;
					else if(enemyblood3==2'b11)
						bloodled[0]<=0;
					enemyhit3<=1;
					end
				else begin
					enemyhit3<=0;
					end
				if(enemyblood3>=2'b11)begin
					enemydead3<=1;
					end
				end
			//////////
			//enemy4//
			//////////such as enemy2
			else if(stage==5'b01001&&enemydead4==0)begin
				if(eighttenclk==5'b00101&&enemywalk4==2'b00)
					enemywalk4<=2'b01;
					
				else if(eighttenclk==5'b00111&&enemywalk4==2'b01)
					enemywalk4<=2'b10;
				/////
				if(enemywalk4==2'b01)begin
					if(comm==3'b110)begin
						bloodled[0]<=1;bloodled[1]<=1;bloodled[2]<=1;
						ledr[4]<=0;ledr[5]<=0;ledr[3]<=0;
						end
					else begin
						ledr[4]<=1;ledr[5]<=1;ledr[3]<=1;
						end
					end
				else if(enemywalk4==2'b10)begin
					if(comm==3'b101)begin
						ledr[4]<=0;ledr[5]<=0;ledr[3]<=0;
						end
					else begin
						ledr[4]<=1;ledr[5]<=1;ledr[3]<=1;
						end
					end
				/////
				stopwalk<=1;	
				/////shoot
				
				if(enemyspace4==5'b00010||enemyspace4==5'b00011||enemyspace4==5'b00100)begin
					if(comm==3'b100)begin
						shootp4<=3'b100;
						ledr[4]<=0;
						end
					else if(comm==3'b111)
						ledr[4]<=1;
					end
				else if(enemyspace4==5'b00101||enemyspace4==5'b00110||enemyspace4==5'b00111)begin
					if(comm==3'b011)begin
						shootp4<=3'b011;
						ledr[4]<=0;
						end
					else if(comm==3'b100)
						ledr[4]<=1;
					end
				else if(enemyspace4==5'b01000||enemyspace4==5'b01001||enemyspace4==5'b01010)begin
					if(comm==3'b010)begin
						shootp4<=3'b010;
						ledr[4]<=0;
						end
					else if(comm==3'b011)
						ledr[4]<=1;
					end
				else if(enemyspace4==5'b01011||enemyspace4==5'b01100||enemyspace4==5'b01101)begin
					if(comm==3'b001)begin
						shootp4<=3'b001;
						ledr[4]<=0;
						end
					else if(comm==3'b010)
						ledr[4]<=1;
					end
				else if(enemyspace4==5'b01110||enemyspace4==5'b01111||enemyspace4==5'b10000)begin
					if(comm==3'b000)begin
						shootp4<=3'b000;
						ledr[4]<=0;
						end
					else if(comm==3'b001)
						ledr[4]<=1;
					end
				else if(enemyspace4==5'b10001||enemyspace4==5'b10010||enemyspace4==5'b10011)begin
					if(comm==3'b111)begin
						shootp4<=3'b111;
						ledr[4]<=0;
						end
					else if(comm==3'b000)
						ledr[4]<=1;
					end
				else begin
					if(comm==3'b111||comm==3'b000||comm==3'b001||comm==3'b010||comm==3'b011||comm==3'b111)begin
						shootp4<=3'b111;
						ledr[4]<=1;
						end
					end
				/////
				if(shootp4==3'b000&&(playerposition==3'b000||playerposition==3'b001))
					hadhit<=0;
				else
					hadhit<=1;
				/////
				if(eighttenclk==5'b00110||eighttenclk==5'b00010)
					enemytime4<=1;
				else
					enemytime4<=0;
				/////
				if(shootposition==3'b101)begin
					if(enemyblood4==2'b01)
						bloodled[2]<=0;
					else if(enemyblood4==2'b10)
						bloodled[1]<=0;
					else if(enemyblood4==2'b11)
						bloodled[0]<=0;
					enemyhit4<=1;
					end
				else begin
					enemyhit4<=0;
					end
				if(enemyblood4>=2'b11)begin
					enemydead4<=1;
					end
				end
			//////////
			//enemy5//
			//////////boss 5 blood fly fat
			else if(stage==5'b01100&&enemydead5==0)begin//01100
				if(eighttenclk==5'b00101&&enemywalk5==2'b00)
					enemywalk5<=2'b01;
				else if(eighttenclk==5'b00111&&enemywalk5==2'b01)
					enemywalk5<=2'b10;
				/////
				if(enemywalk5==2'b01)begin
					if(comm==3'b110)begin
						bloodled[0]<=1;bloodled[1]<=1;bloodled[2]<=1;bloodled[3]<=1;bloodled[4]<=1;
						ledr[4]<=1;ledr[5]<=1;
						end
					else begin
						ledr[4]<=1;ledr[5]<=1;
						end
					end
				else if(enemywalk5==2'b10)begin
					if(comm==3'b101)begin
						ledr[4]<=1;ledr[5]<=1;
						end
					else begin
						ledr[4]<=1;ledr[5]<=1;
						end
					end
				/////
				stopwalk<=1;
				/////jump
				if(enemyspace5>=5'b00001&&enemyspace5<=5'b00101)begin
					if(comm==3'b101||comm==3'b110)begin
						ledr[4]<=0;ledr[5]<=0;ledr[3]<=1;ledr[2]<=1;ledr[1]<=1;
						enemyposition5<=3'b000;
						end
					else begin
						ledr[4]<=1;ledr[5]<=1;
						end
					end
				else if(enemyspace5>=5'b00110&&enemyspace5<=5'b01010)begin
					if(comm==3'b101||comm==3'b110)begin
						ledr[4]<=0;ledr[3]<=0;ledr[5]<=1;ledr[2]<=1;ledr[1]<=1;
						enemyposition5<=3'b001;
						end
					else begin
						ledr[4]<=1;ledr[3]<=1;
						end
					end
				else if(enemyspace5>=5'b01011&&enemyspace5<=5'b01111)begin
					if(comm==3'b101||comm==3'b110)begin
						ledr[2]<=0;ledr[3]<=0;ledr[4]<=1;ledr[5]<=1;ledr[1]<=1;
						enemyposition5<=3'b010;
						end
					else begin
						ledr[2]<=1;ledr[3]<=1;
						end
					end
				else if(enemyspace5>=5'b10000&&enemyspace5<=5'b10101)begin
					if(comm==3'b101||comm==3'b110)begin
						ledr[1]<=0;ledr[2]<=0;ledr[3]<=1;ledr[4]<=1;ledr[5]<=1;
						enemyposition5<=3'b011;
						end
					else begin
						ledr[1]<=1;ledr[2]<=1;
						end
					end
				else if(enemyspace5>=5'b10110&&enemyspace5<=5'b11001)begin
					if(comm==3'b101||comm==3'b110)begin
						ledr[3]<=0;ledr[2]<=0;ledr[1]<=1;ledr[4]<=1;ledr[5]<=1;
						enemyposition5<=3'b010;
						end
					else begin
						ledr[2]<=1;ledr[3]<=1;
						end
					end
				else if(enemyspace5>=5'b11010&&enemyspace5<=5'b11111)begin
					if(comm==3'b101||comm==3'b110)begin
						ledr[3]<=0;ledr[4]<=0;ledr[2]<=1;ledr[5]<=1;ledr[1]<=1;
						enemyposition5<=3'b001;
						end
					else begin
						ledr[4]<=1;ledr[3]<=1;
						end
					end			
				/////shoot			
				if(enemyspace5==5'b00010||enemyspace5==5'b00011||enemyspace5==5'b00100)begin
					if(comm==3'b100)begin
						shootp5<=3'b100;
						ledr[4]<=0;ledr[3]<=0;
						end
					else if(comm==3'b111)begin
						ledr[4]<=1;
						end
					end
				else if(enemyspace5==5'b00101||enemyspace5==5'b00110||enemyspace5==5'b00111)begin
					if(comm==3'b011)begin
						shootp5<=3'b011;
						ledr[4]<=0;ledr[3]<=0;
						end
					else if(comm==3'b100)begin
						ledr[4]<=1;
						end
					end
				else if(enemyspace5==5'b01000||enemyspace5==5'b01001||enemyspace5==5'b01010)begin
					if(comm==3'b010)begin
						shootp5<=3'b010;
						ledr[4]<=0;ledr[3]<=0;
						end
					else if(comm==3'b011)begin
						ledr[4]<=1;ledr[3]<=1;
						end
					end
				else if(enemyspace5==5'b01011||enemyspace5==5'b01100||enemyspace5==5'b01101)begin
					if(comm==3'b001)begin
						shootp5<=3'b001;
						ledr[4]<=0;ledr[3]<=0;
						end
					else if(comm==3'b010)begin
						ledr[4]<=1;ledr[3]<=1;
						end
					end
				else if(enemyspace5==5'b01110||enemyspace5==5'b01111||enemyspace5==5'b10000)begin
					if(comm==3'b000)begin
						shootp5<=3'b000;
						ledr[4]<=0;ledr[3]<=0;
						end
					else if(comm==3'b001)begin
						ledr[4]<=1;ledr[3]<=1;
						end
					end
				else if(enemyspace5==5'b10001||enemyspace5==5'b10010||enemyspace5==5'b10011)begin
					if(comm==3'b111)begin
						shootp5<=3'b111;
						ledr[4]<=0;ledr[3]<=0;
						end
					else if(comm==3'b000)begin
						ledr[4]<=1;ledr[3]<=1;
						end
					end
				else begin
					if(comm==3'b111||comm==3'b000||comm==3'b001||comm==3'b010||comm==3'b011||comm==3'b111)begin
						shootp5<=3'b111;
						ledr[4]<=1;ledr[3]<=1;
						end
					end
				/////
				if(shootp5==3'b000&&(playerposition==3'b000||playerposition==3'b001||playerposition==3'b010))
					hadhit<=0;
				else
					hadhit<=1;
				/////
				if(eighttenclk==5'b00011||eighttenclk==5'b00110||eighttenclk==5'b01001)//where to change the freq of enemy's attack and jump
					enemytime5<=1;
				else
					enemytime5<=0;
				/////
				if(shootposition==3'b101&&(enemyposition5==3'b000||enemyposition5==3'b001))begin
					if(enemyblood5==3'b001)
						bloodled[4]<=0;
					else if(enemyblood5==3'b010)
						bloodled[3]<=0;
					else if(enemyblood5==3'b011)
						bloodled[2]<=0;
					else if(enemyblood5==3'b100)
						bloodled[1]<=0;
					else if(enemyblood5==3'b101)
						bloodled[0]<=0;
					enemyhit5<=1;
					end
				else begin
					enemyhit5<=0;
					end
				if(enemyblood5>=3'b101)begin
					enemydead5<=1;
					bossdead<=1;
					end
				end
			/////
			
			else begin
			   ledr[4]<=1;ledr[5]<=1;ledr[3]<=1;ledr[2]<=1;ledr[1]<=1;
				stopwalk<=0;
				end
			////////////////////////////////////////
			skillstop<=0;//skill's trigger		
			////////////////////////////////////////blue led per 8/10s
			if(eighttenclk==5'b00010)begin
				ledb[0]=0;ledb[7]=0;
				beepopen<=1;
				end
			else begin
				beepopen<=0;
				ledb[0]=1;ledb[7]=1;
				end
			////////////////////////////////////////cut each 5'binary to 4/8success 1/8test con 1/8initial
			if(((eighttenclk>=5'b00010)&&(eighttenclk<=5'b00100))||((eighttenclk>=5'b01001)&&(eighttenclk<=5'b01001)))begin
				if(A==1||B==1||C==1||D==1)begin
					con<=1;
					end
				end
			else begin
				if(A==1||B==1||C==1||D==1)begin
					con<=0;
					end
				end
			if(eighttenclk==5'b00111)begin
				if(con==0)//if lost combo clean all the data
					clear<=0;
				else
					clear<=1;
				skillclear<=1;
				end
			if(eighttenclk==5'b01000)begin//where test the whole clock
				con<=0;
				clear<=1;
				skillclear<=0;
				end
			////////////////////////////////////////led test for correct tempo
			if(clear==0)//clean each button data 
				close<=1;//close the led
			if(con==1)
				close<=0;
			if(correctAC==1)//CCCA shoot
				led[2]<=1;
			else
				led[2]<=0;
			if(correctAD==1)//DDDA jump
				led[3]<=1;
			else
				led[3]<=0;
			if(correctBC==1)//CCCB defend
				led[4]<=1;
			else
				led[4]<=0;
			if(correctBD==1)//DDDB walk
				led[5]<=1;
			else
				led[5]<=0;
			if(correctC==1)
				led[0]<=1;
			else
				led[0]<=0;
			if(correctD==1)
				led[1]<=1;
			else
				led[1]<=0;
			////////////////////////////////////////red led when push button 
			if((A==1)||(B==1)||(C==1)||(D==1))begin
				ledr[0]<=0;ledr[7]<=0;
				end
			else begin
				ledr[0]<=1;ledr[7]<=1;
				end
			////////////////////////////////////////player position and jump
			if(jump==1)begin
				if(eighttenclk==5'b00101&&jumpcount==4'b0000)
					jumpcount<=4'b0001;//1
				else if(eighttenclk==5'b00110&&jumpcount==4'b0001)
					jumpcount<=4'b0010;//2
				else if(eighttenclk==5'b01000&&jumpcount==4'b0010)
					jumpcount<=4'b0011;//3
				else if(eighttenclk==5'b00111&&jumpcount==4'b0011)
					jumpcount<=4'b0100;//stop on the top
				else if(eighttenclk==5'b00110&&jumpcount==4'b0100)
					jumpcount<=4'b1100;//stop on the top
				else if(eighttenclk==5'b00111&&jumpcount==4'b1100)
					jumpcount<=4'b1101;//stop on the top
				else if(eighttenclk==5'b01001&&jumpcount==4'b1101)
					jumpcount<=4'b0101;//down?4
				else if(eighttenclk==5'b00010&&jumpcount==4'b0101)
					jumpcount<=4'b0110;//5
				else if(eighttenclk==5'b00011&&jumpcount==4'b0110)
					jumpcount<=4'b0111;//6
				else if(eighttenclk==5'b00100&&jumpcount==4'b0111)begin
					jumpcount<=4'b0000;//end?
					skillstop<=1;
					end
				if(jumpcount==4'b0000)begin
					playerposition<=3'b000;
					if(comm==3'b000)
						ledg<=8'b11001111;
					else
						ledg<=8'b11111111;
					end
				else if(jumpcount==4'b0001)begin
					playerposition<=3'b001;
					if(comm==3'b000)
						ledg<=8'b11100111;
					else
						ledg<=8'b11111111;
					end
				else if(jumpcount==4'b0010)begin
					playerposition<=3'b010;
					if(comm==3'b000)
						ledg<=8'b11110011;
					else
						ledg<=8'b11111111;
					end
				else if(jumpcount==4'b0011)begin
					playerposition<=3'b111;
					if(comm==3'b000)
						ledg<=8'b11111001;
					else
						ledg<=8'b11111111;
					end
				else if(jumpcount==4'b1100)begin
					playerposition<=3'b111;
					if(comm==3'b000)
						ledg<=8'b11111001;
					else
						ledg<=8'b11111111;
					end
				else if(jumpcount==4'b1101)begin
					playerposition<=3'b111;
					if(comm==3'b000)
						ledg<=8'b11111001;
					else
						ledg<=8'b11111111;
					end
				else if(jumpcount==4'b0100)begin
					playerposition<=3'b111;
					if(comm==3'b000)
						ledg<=8'b11111001;
					else
						ledg<=8'b11111111;
					end
				else if(jumpcount==4'b0101)begin
					playerposition<=3'b010;
					if(comm==3'b000)
						ledg<=8'b11110011;
					else
						ledg<=8'b11111111;
					end
				else if(jumpcount==4'b0110)begin
					playerposition<=3'b001;
					if(comm==3'b000)
						ledg<=8'b11100111;
					else
						ledg<=8'b11111111;
					end
				else if(jumpcount==4'b0111)begin
					playerposition<=3'b000;
					if(comm==3'b000)
						ledg<=8'b11001111;
					else
						ledg<=8'b11111111;
					end
				end
			else begin
				if(comm==3'b000)begin
					ledg[4]<=0;ledg[5]<=0;
					end
				else begin
					ledg[4]<=1;ledg[5]<=1;
					end
				end
			////////////////////////////////////////ground and walkskill
			ledr[6]<=0;
			if(walk==1)begin
				if(eighttenclk==5'b00110&&stepcount==3'b000)
					stepcount<=3'b001;
				else if(eighttenclk==5'b00010&&stepcount==3'b001)
					stepcount<=3'b010;
				else if(eighttenclk==5'b00110&&stepcount==3'b010)
					stepcount<=3'b011;
				else if(eighttenclk==5'b00010&&stepcount==3'b011)
					stepcount<=3'b100;
				else if(eighttenclk==5'b00110&&stepcount==3'b100)begin
					stepcount<=3'b000;
					skillstop<=1;//return normal mode
					end
				if(stepcount==3'b000)begin
					if(comm==3'b111||comm==3'b001||comm==3'b010||comm==3'b011||comm==3'b101||comm==3'b110)begin//start position
						ledg[6]<=0;
						end
					else
						ledg[6]<=1;
					end
				else if(stepcount==3'b001)begin
					if(comm==3'b000||comm==3'b001||comm==3'b010||comm==3'b100||comm==3'b101||comm==3'b110)begin
						ledg[6]<=0;
						end
					else
						ledg[6]<=1;
					end
				else if(stepcount==3'b010)begin
					if(comm==3'b111||comm==3'b000||comm==3'b001||comm==3'b011||comm==3'b100||comm==3'b101)begin
						ledg[6]<=0;
						end
					else
						ledg[6]<=1;
					end
				else if(stepcount==3'b011)begin
					if(comm==3'b111||comm==3'b000||comm==3'b010||comm==3'b011||comm==3'b100||comm==3'b110)begin
						ledg[6]<=0;
						end
					else
						ledg[6]<=1;
					end
				else if(stepcount==3'b100)begin
					if(comm==3'b111||comm==3'b001||comm==3'b010||comm==3'b011||comm==3'b101||comm==3'b110)begin//start position
						ledg[6]<=0;
						end
					else
						ledg[6]<=1;
					end
				end
			else begin
				if(comm==3'b111||comm==3'b001||comm==3'b010||comm==3'b011||comm==3'b101||comm==3'b110)begin//start position
						ledg[6]<=0;
						end
					else
						ledg[6]<=1;
				end
			////////////////////////////////////////defend
			if(defend==1&&usedefend==0)begin
				if(eighttenclk==5'b00110&&defendtime==3'b000)
					defendtime<=3'b001;
				else if(eighttenclk==5'b00101&&defendtime==3'b001)
					defendtime<=3'b010;
				else if(eighttenclk==5'b00100&&defendtime==3'b010)
					defendtime<=3'b011;
				else if(eighttenclk==5'b00011&&defendtime==3'b011)
					defendtime<=3'b100;
				else if(eighttenclk==5'b00110&&defendtime==3'b100)
					defendtime<=3'b101;
				/////
				if(defendtime==3'b101)begin
					defendtime<=3'b000;
					skillstop<=1;
					usedefend<=1;
					end
				else begin
					if(comm==3'b000)begin
						ledb[4]<=0;ledb[5]<=0;
						end
					else begin
						ledb[4]<=1;ledb[5]<=1;
						end
					end
				end
			else if(defend==1)
				skillstop<=1;
			else begin
				if(comm==3'b000)begin
					ledb[4]<=1;ledb[5]<=1;
					end
				end
			////////////////////////////////////////player shoot
			if(shoot==1)begin
				if(eighttenclk==5'b00110&&myshoottime==3'b000)
					myshoottime<=3'b001;
				else if(eighttenclk==5'b01000&&myshoottime==3'b001)
					myshoottime<=3'b010;
				else if(eighttenclk==5'b00010&&myshoottime==3'b010)
					myshoottime<=3'b011;
				else if(eighttenclk==5'b00100&&myshoottime==3'b011)
					myshoottime<=3'b100;
				else if(eighttenclk==5'b00111&&myshoottime==3'b100)
					myshoottime<=3'b101;
				else if(eighttenclk==5'b01001&&myshoottime==3'b101)
					myshoottime<=3'b110;
				else if(eighttenclk==5'b00011&&myshoottime==3'b110)begin
					myshoottime<=3'b000;
					shootposition<=3'b000;
					skillstop<=1;
					end		
				if(myshoottime==3'b001)begin
					if(comm==3'b001)begin
						shootposition<=3'b001;
						ledb[4]<=0;
						end
					else
						ledb[4]<=1;
					end
				else if(myshoottime==3'b010)begin
					if(comm==3'b010)begin
						ledb[4]<=0;
						shootposition<=3'b010;
						end
					else
						ledb[4]<=1;
					end
				else if(myshoottime==3'b011)begin
					if(comm==3'b011)begin
						ledb[4]<=0;
						shootposition<=3'b011;
						end
					else
						ledb[4]<=1;
					end
				else if(myshoottime==3'b100)begin
					if(comm==3'b100)begin
						ledb[4]<=0;
						shootposition<=3'b100;
						end
					else
						ledb[4]<=1;
					end
				else if(myshoottime==3'b101)begin
					if(comm==3'b101)begin
						ledb[4]<=0;
						shootposition<=3'b101;
						end
					else
						ledb[4]<=1;
					end
				else if(myshoottime==3'b110)begin
					if(comm==3'b110)begin
						ledb[4]<=0;
						shootposition<=3'b110;
						end
					else
						ledb[4]<=1;
					end
				end
			else begin
				if(comm!=3'b000)
					ledb[4]<=1;
				end
			////////////////////////////////////////test 3combo led only D
			if(countD==2'b01)
				testD[0]<=1;
			else
				testD[0]<=0;
			if(countD==2'b10)
				testD[1]<=1;
			else
				testD[1]<=0;
			if(countD==2'b11)
				testD[2]<=1;
			else
				testD[2]<=0;
			////////////////////////////////////////test 3combo led only C
			if(countC==2'b01)
				testC[0]<=1;
			else
				testC[0]<=0;
			if(countC==2'b10)
				testC[1]<=1;
			else
				testC[1]<=0;
			if(countC==2'b11)
				testC[2]<=1;
			else
				testC[2]<=0;
		end
		end
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////trigger///////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////vvv/////////////////////////////////////////////////////////////////
	always@(posedge led[2],posedge skillstop)//CCCA shoot
		begin
			if(skillstop)begin
				sk1<=0;
				shoot<=0;
				end
			else begin
				sk1<=1;
				shoot<=1;
				end
		end
	always@(posedge led[3],posedge skillstop)//DDDA jump
		begin
			if(skillstop)begin
				sk2<=0;
				jump<=0;
				end
			else begin
				sk2<=1;
				jump<=1;
				end
		end
	always@(posedge led[4],posedge skillstop)//CCCB defend
		begin
			if(skillstop)begin
				sk3<=0;
				defend<=0;
				end
			else begin
				sk3<=1;
				defend<=1;
				end
		end
	always@(posedge led[5],posedge skillstop)//DDDB walk stage control
		begin
			if(skillstop)begin
				sk4<=0;
				walk<=0;
				end
			else if(stopwalk==1)begin
				walk<=0;
				end
			else begin
				sk4<=1;
				walk<=1;
				stage<=stage+5'b00001;
				end
		end
	/////////////////////////////////////////////////////^^^/////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////trigger///////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	always@(posedge led[1],negedge clear,posedge led[2],posedge led[3],posedge led[4],posedge led[5])//D combocount
		begin
			if(!clear)begin
				countD<=0;
				end
			else if(led[2])
				countD<=0;
			else if(led[3])
				countD<=0;
			else if(led[4])
				countD<=0;
			else if(led[5])
				countD<=0;
			else begin		
				if(countD==2'b11)begin
					countD<=2'b01;
					end
				else begin
					countD<=countD+2'b01;
				   end			
				end
		end
	always@(posedge led[0],negedge clear,posedge led[2],posedge led[3],posedge led[4],posedge led[5])//C combocount
		begin
			if(!clear)begin
				countC<=0;
				end
			else if(led[2])
				countC<=0;
			else if(led[3])
				countC<=0;
			else if(led[4])
				countC<=0;
			else if(led[5])
				countC<=0;
			else begin
				if(countC==2'b11)begin
					countC<=2'b01;
					end
				else begin
					countC<=countC+2'b01;
					end
				end
		end
	always@(posedge A,negedge clear,posedge skillclear)
		begin
				if(A)begin
					if(((eighttenclk>=5'b00010)&&(eighttenclk<=5'b00100))||((eighttenclk>=5'b01001)&&(eighttenclk<=5'b01001)))begin
						if(countC==2'b11)begin
							correctAC<=1;
							end
						else if(countD==2'b11)begin
							correctAD<=1;
							end
						else begin
							correctAC<=0;
							correctAD<=0;
							end
						end
					else begin
						correctAC<=0;
						correctAD<=0;
						end	
					end
				else begin
					correctAC<=0;
					correctAD<=0;
					end
				end
	always@(posedge B,negedge clear,posedge skillclear)
		begin
		if(B)begin
			if(((eighttenclk>=5'b00010)&&(eighttenclk<=5'b00100))||((eighttenclk>=5'b01001)&&(eighttenclk<=5'b01001)))begin
				if(countD==2'b11)begin
					correctBD<=1;
					end
				else if(countC==2'b11)begin
					correctBC<=1;
					end
				else begin
					correctBC<=0;
					correctBD<=0;
					end
				end
			else begin
				correctBD<=0;
				correctBC<=0;
				end	
		end
		else begin
			correctBD<=0;
			correctBC<=0;
			end
		end
	always@(posedge C,negedge clear,posedge skillclear)
		begin
		if(C)begin
			if(((eighttenclk>=5'b00010)&&(eighttenclk<=5'b00100))||((eighttenclk>=5'b01001)&&(eighttenclk<=5'b01001)))begin
				correctC<=1;
				end
			else begin
				correctC<=0;
				end	
		end
		else begin
			correctC<=0;
			end
		end
	always@(posedge D,negedge clear,posedge skillclear)
		begin
		if(D)begin
			if(((eighttenclk>=5'b00010)&&(eighttenclk<=5'b00100))||((eighttenclk>=5'b01001)&&(eighttenclk<=5'b01001)))begin
				correctD<=1;
				end
			else begin
				correctD<=0;
				end	
		end
		else begin
			correctD<=0;
			end
		end
	always@(posedge clk10)
		begin
			if(buttonA==1)
				A<=1;
			else if(buttonB==1)
				B<=1;
			else if(buttonC==1)
				C<=1;
			else if(buttonD==1)
				D<=1;
			else begin
				A<=0;B<=0;C<=0;D<=0;
				end
		end
endmodule
module freq4(input clk, output reg clk4);//clock 4hz
	reg [24:0] Count=25'b0;
	always @(posedge clk)
	begin
		if(Count > 6250000)
		begin
			Count <= 25'b0;
			clk4 <= ~clk4;
		end
		else
			Count <= Count + 1'b1;
	end
endmodule
module freq10(input clk, output reg clk10);//clock 10hz
	reg [24:0] Count=25'b0;
	always @(posedge clk)
	begin
		if(Count > 2500000)
		begin
			Count <= 25'b0;
			clk10 <= ~clk10;
		end
		else
			Count <= Count + 1'b1;
	end
endmodule
module freq1000(input clk, output reg clk1000);//clock 1000hz
	reg [24:0] Count=25'b0;
	always @(posedge clk)
	begin
		if(Count > 25000)
		begin
			Count <= 25'b0;
			clk1000 <= ~clk1000;
		end
		else
			Count <= Count + 1'b1;
	end
endmodule
module freq440(input clk, output reg clk440);//clock 440hz//now is 440*4
	reg [24:0] Count=25'b0;
	always @(posedge clk)
	begin
		if(Count > 113636)
		begin
			Count <= 25'b0;
			clk440 <= ~clk440;
		end
		else
			Count <= Count + 1'b1;
	end
endmodule