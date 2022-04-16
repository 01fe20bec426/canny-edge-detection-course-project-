module canny(clk,
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
    
    
    
input clk;
input reset;
input start;

input [15:0]im11;
input [15:0]im12;
input [15:0]im13;

input [15:0]im21;
input [15:0]im22;
input [15:0]im23;

input [15:0]im31;
input [15:0]im32;
input [15:0]im33;

output [15:0]dx_out;
output dx_out_sign;

output [15:0]dy_out;
output dy_out_sign;
output [15:0]dxy;

output data_occur;

wire [15:0]dxy;
wire  [15:0]dx_out;
wire dx_out_sign;

wire  [15:0]dy_out;
wire dy_out_sign;



reg [15:0]im11t;
reg [15:0]im12t;
reg [15:0]im13t;

reg [15:0]im21t;
reg [15:0]im22t;
reg [15:0]im23t;

reg [15:0]im31t;
reg [15:0]im32t;
reg [15:0]im33t;



wire temp3x_sign;
wire [15:0]temp1x,temp2x,temp3x;

wire temp3y_sign;
wire [15:0]temp1y,temp2y,temp3y;



reg data_occur;
wire [15:0]reg_add;


              
              
assign dy_out=temp3y;
assign dy_out_sign=temp3y_sign;
assign temp1y=(im31t+(im32t << 1)+ im33t);
assign temp2y=(im11t+(im12t << 1)+ im13t);
assign temp3y=(temp1y > temp2y)?{temp1y-temp2y}:
              (temp1y < temp2y)?{temp2y-temp1y}:{16'd0};
     
assign temp3y_sign=(temp1y > temp2y)?1'b1:1'b0;
              
assign reg_add=(data_occur)?(dx_out+dy_out):16'd0;
assign dxy=(data_occur && reg_add >= 16'd255)?16'd255:16'd0;

assign dx_out=temp3x;
assign dx_out_sign=temp3x_sign;

assign temp1x=(im11t+(im21t << 1)+ im31t);
assign temp2x=(im13t+(im23t << 1)+ im33t);

assign temp3x=(temp1x > temp2x)?{temp1x-temp2x}:
              (temp1x < temp2x)?{temp2x-temp1x}:{16'd0};
           
assign temp3x_sign=(temp1x > temp2x)?1'b1:1'b0;

              
              




always @(posedge clk)
begin 

if(~reset)
 
begin 
    im11t<=16'd0;
    im21t<=16'd0;
    im31t<=16'd0;
    im12t<=16'd0;
    im22t<=16'd0;
    im32t<=16'd0;
    im13t<=16'd0;
    im23t<=16'd0;
    im33t<=16'd0;
    data_occur<=1'b0;
end

else if(start )
begin 

    im11t<=im11;
    im21t<=im21;
    im31t<=im31;
    im12t<=im12;
    im22t<=im22;
    im32t<=im32;
    im13t<=im13;
    im23t<=im23;
    im33t<=im33;
    data_occur<=1'b1;    
end

else
begin
    im11t<=16'd0;
    im21t<=16'd0;
    im31t<=16'd0;
    im12t<=16'd0;
    im22t<=16'd0;
    im32t<=16'd0;
    im13t<=16'd0;
    im23t<=16'd0;
    im33t<=16'd0;
    data_occur<=1'b0;
    
end

end

endmodule     
