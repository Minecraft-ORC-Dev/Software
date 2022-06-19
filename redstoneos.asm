BITS 8; //btw there can be only up to 255 instructions in program rom
start:;  
	rdc;
	ric;
	jmp .rendergui;
	jmp .gpiocls;
	jmp .idleloop;
.idleloop;
	boi: .repeat; //branch on interupt flag
.repeat;
	IOR (4, r1);
	IMM(1,r2); //loads program number headers into the registers
    IMM(2,r3);
	IMM(3,r4);
	imm 4,r5;
	CMP:(r1,r2,);         //checks to see if the program numbers are the same as the IO device
	BoZ (.helloworld); //type 1 to see a hello message
	CMP(r1,r3);
	BoZ(.rendersimple); //type 2 to see a simple rendering program
	CMP(r1,r4);
	BoZ(.gpiodemo); //type 3 to see a app menu eg: pong or hex/text file viewer
	CMP(r1,r5);
	BoZ(.shutdown); //type 4 to shutdown the cpu *note press any key while shutdown and it will shutdown in safemode
	jmp .repeat;
.rendergui; //i credit orphan obliterator for the gui idea i modded it to work with the latest hardware and to meet the new minimum programing requirements of ORISA 1.1
	IMM(49,r0); //ascii code for 1 btw if u want i can use binary codes if it works better 4 u
	IMM(0,r1);
	imm 7,r2;
	IOW(1,r0);
	IOW(2,r1);
	IOW(2,r2);
	IMM(50,r0); //ascii code for 2
	IMM(6,r1);
	imm 7,r2;
	IOW(1,r0);
	IOW(2,r1);
	IOW(2,r2);
	IMM(51,r0); //ascii code for 3
	IMM(12,r1);
	imm 7,r2;
	IOW(1,r0);
	IOW(2,r1);
	IOW(2,r2);
	IMM(52,r0); //ascii code for 4
	IMM(18,r1);
	imm 7,r2;
	IOW(1,r0);
	IOW(2,r1);
	IOW(2,r2);
	ret;
.helloworld;
	jmp .cls;
	IMM(104,r0); //char h
	IMM(0,r1);
	imm 7,r2;
	IOW(1,r0);
	IOW(2,r1);
	IOW(2,r2);
	IMM(101,r0); //char e
	IMM(6,r1);
	imm 7,r2;
	IOW(1,r0);
	IOW(2,r1);
	IOW(2,r2);
	IMM(108,r0); //char l
	IMM(12,r1);
	imm 7,r2;
	IOW(1,r0);
	IOW(2,r1);
	IOW(2,r2);
	IMM(108,r0); //char l
	IMM(18,r1);
	imm 7,r2;
	IOW(1,r0);
	IOW(2,r1);
	IOW(2,r2);
	IMM(111,r0); //char o
	IMM(24,r1);
	imm 7,r2;
	IOW(1,r0);
	IOW(2,r1);
	IOW(2,r2);
	noop; //the noop adds delay because the"o" will not be desplayed at all because the screen would be cleared before ascii could be rendered
	noop; //the noop adds delay because the"o" will not be desplayed at all because the screen would be cleared before ascii could be rendered
	jmp .cls; //clears screen before it jumps to termnal so it does not mess-up desplay by overlapping ascii
	jmp .waitLoop;
.rendersimple; //put simple render demo here like sprite movement
	jmp .cls;
.gpiodemo; //this demo outputs a one to pin15 if pin 16 is high
	jmp .cls;
	jmp .gpiocls;
	rio 3, r1; //pin 16 is being read without data pins!!!
	imm r2, 1;
	cmp r1, r2;
	boz .gpiodemotrue;
	jmp .cls;
.gpiodemotrue;
	wio 5, 1; //writes pin 15 high
	wio 6, 1;
	wio 7, 1;
	wio 8, 1;
	wio 3, 1;  //pulse1
	wio 3, 1; //pulse2
	jmp .gpiocls;
	ret;
.shutdown;
	jmp .cls; //clear screen
	boi .smarthalt; //if there is a interrupt while shutdown if one is present jmp to smarthalt else normaly halt the cpu
	hlt; //stop the cpu
.cls
	IMM(01000101,r7); //erases the whole screen: ascii char #69 btw ascii code #69 is: E as well
	IMM(0,r1);
	imm 0,r2;
	IOW(1,r7);
	IOW(2,r1);
	IOW(2,r2);
	ret;
.smarthalt;
	jmp .gpiocls; //put any shutdown functions here
	rdc; //reloads dcache
	ric; //reloads icache
	ret;
.gpiocls; //clears gpio so all automatic farms/security/misc redstone can turn off so it can't break your base while shutdown
	iow 3, 1; //io 5, 6, 7, 8, 3 are not taken so the gpio will be useing them 5-8 are data (4 bit binary) 3 is the wipe/aux line
	iow 3, 0; //if io auto turns off this line is not needed
	ret;
.networkingSCULKNET;
	ret; //returns to sender
	imm 00000001, r1; //writes address to register 1
	