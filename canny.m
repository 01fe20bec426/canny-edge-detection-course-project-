NOISE = input(" Apply gaussin filter Enter 2 to continue-:--");

if(NOISE==1)
disp('-------------------------')
disp('Executing the code by applying with gaussian noise');
NOISE_LEVEL=input('Enter the gaussian noise value,0.1 to 0.9:--');
elseif(NOISE==2)
        disp('Executing the code wihout noise');
end
[file path]=uigetfile('*.*','select image');
filename=strcat(path,file);
img=(imread(filename));
dim=ndims(img);
if(dim==3)
    img=rgb2gray(img);
end
wresize=256;
wsize=3;
img_in_data=(imresize(img,[wresize wresize]));
if(NOISE==1)
    i=imnoise(img_in_data,'gaussian',NOISE_LEVEL);
elseif(NOISE==2)
        i=img_in_data;
end
figure,imshow(uint8(i));
title('Input Image');
img1=zeros(wresize+ceil(wsize/2),wresize+ceil(wsize/2));
img1(ceil(wsize/2):wresize+floor(wsize/2),ceil(wsize/2):wresize+floor(wsize/2))=i;
f1=1;f2=1;
for k=2:wresize+floor(wsize/2)
    for k1=2:wresize+floor(wsize/2)
        cell{f1,f2}=img1(k-1:k+1,k1-1:k1+1);
        f2=f2+1;
    end
    f2=1;
    f1=f1+1;
end
ss=[];
ff=fopen('image_textfile_canny.txt','w');
for n1=1:wresize
    for n2=1:wresize
        ig=cell{n1,n2};
        i1=ig(1:wsize*wsize);
        for j=1:wsize*wsize
            dd=i1(j);
            s1=dec2hex(dd,2);
            fprintf(ff,'%s',s1);
            fprintf(ff,'\t');
        end
    end
end
fclose(ff);
disp('conversion pf image pixel values and saving in image_text_file_canny.txt');
pause(5);
%%
disp('Executing canny edge detection');
pause(5);
disp('calling Modelsim software using keyword hdldaemon(socket,4999)');
pause(2)

ff={'vlib work','vlog canny.v','vlog canny_test.v',...
    'vsim canny_test','view wave','add wave -r /*','run -all','exit'};
vsim('socketsimulink','4449','tclstart',ff);
hdldaemon('kill');
pause;
disp('displaying canny edge output');
pause(5);
data=textread('edgefile_canny.txt');
data1=reshape(data,[256,256]);
figure,imshow(data1');
title('canny edge detected output image');




