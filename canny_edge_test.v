module canny_test;


reg clk;
reg reset;
reg start;

  reg [15:0]im11;
reg [15:0]im12;
reg [15:0]im13;

reg [15:0]im21;
reg [15:0]im22;
reg [15:0]im23;

reg [15:0]im31;
reg [15:0]im32;
reg [15:0]im33;

wire data_occur;
wire  [15:0]dx_out;

wire dx_out_sign;

wire  [15:0]dy_out;
wire dy_out_sign;

wire [15:0]dxy;


reg [15:0]mem[0:589823];

integer file_id,k;


canny canny_inst(clk,
                    reset,
                    start,
                    im11,
                    im21,
                    im31,
                    im12,
                    im22,
                    im32,
                    im13,
                    im23,
                    im33,
                    dx_out,
                    dx_out_sign,
                    dy_out,
                    dy_out_sign,
                    dxy,
                    data_occur);
                    
                    
                    
initial 
begin 
clk=0;
reset=0;
start=0;
end


always 
#20 clk=~clk;


initial
begin 
$readmemh("image_textfile_canny.txt",mem);
file_id=$fopen("edgefile_canny.txt");
end






initial 
begin 

#200; 


    for (k=0;k<589824;k=k+9)
    begin    
       
    @(negedge clk)  
    begin 
                        reset=1; start=1; 
                        im11=mem[k];
                        im21=mem[k+1];
                        im31=mem[k+2];
                        im12=mem[k+3];
                        im22=mem[k+4];
                        im32=mem[k+5];
                        im13=mem[k+6];
                        im23=mem[k+7];
                        im33=mem[k+8];
   end
   end
   
   
       

       
@(negedge clk) start=0; $fclose(file_id);
  $finish;            
end
 
       

always @(negedge clk)
begin 

if(data_occur)
begin 
$fdisplay(file_id,"%d",dxy);
$display("%d",dxy);
end


end
 








endmodule 
                    
