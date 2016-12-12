

%%

close all;
clc;
clear all;

%Acquire Image. Make sure you've started your webcam manually.

%vid=imaq.VideoDevice('winvideo',1,'RGB24_640x480');
%vid=imaq.VideoDevice('winvideo',1,'YUY2_640x480');
vid=imaq.VideoDevice('winvideo',1,'MJPG_640x480');

%no=10;
s=serial('COM11');
fopen(s);


while 1
dntshw=false;
pause(.001);

%acquireimage from webcam
%capture frame
frame = step(vid);
%frame = imread('uouo.JPG');
%Read the image, and capture the dimensions
img=uint8(255*frame);
out=skinDetect2Func(img);

stats=regionprops(out,'Centroid');

if length(stats)

    cx=stats.Centroid(1);
    cy=stats.Centroid(2);
   % display('centroid=');
   % display(cx);
   % display(cy);

    %find the nearest countour point
    boundary=bwboundaries(out);
    minDist=2*640*640;
    mx=cx;
    my=cy;
    bImg=uint8(zeros(480,640));

    for i=1:length(boundary)
        cell=boundary{i,1};
        for j=1:length(cell)
            y=cell(j,1);
            x=cell(j,2);

            sqrDist=(cx-x)*(cx-x)+(cy-y)*(cy-y);
            bImg(x,y)=255;

            if(sqrDist<minDist)
                minDist=sqrDist;
                mx=x;
                my=y;
            end
        end
    end
    
    sed=strel('disk',round(sqrt(minDist)/2));
    final=imerode(out,sed);
    final=imdilate(final,sed);
    final=out-final;
    
    final=bwareaopen(final,200);
	final=imerode(final,strel('disk',10));
    final=bwareaopen(final,400);
    
    [L,num]=bwlabel(final,8);
    final=imclearborder(final,8);
    display(num);
    if(num==1)
       % display('MOVE FORWARD');
       disp('ON')
       fprintf(s,'h')
    end
    if(num==2)
       % display('move forward');
        L=bwlabel(final,8);
       %/ Call regionprops and concatenate centroid coordinates
         S = regionprops(bwlabel(final,8),'Centroid')

         Centroids = vertcat(S.Centroid)

        %// Measure pairwise distance
        D = pdist(Centroids,'euclidean')
        
        if(D < 130)
            %display('MOVE BACKWARD');
            disp('ON')
        fprintf(s,'h')
            command_robot=21;
        end
        if(D>=130 & D<250)
            %display('TURN RIGHT');
            disp('Off')
            fprintf(s,'l')
            command_robot=22;
        end
        if(D>=250)
            %display('TURN LEFT');
            disp('Off')
            fprintf(s,'l')
            command_robot=23;
         
        end
        
        
        % [r, c] = find(L==2);
       % rc = [r c];
       % display(rc);
       % stats1=regionprops(rc,'Centroid');
       % if length(stats1)
       % display(stats1);
           %  dx=stats1.Centroid(1);
           %  dy=stats1.Centroid(2);
            % display(dx);
            % display(dy);
    else
        command_robot=num;
        % end
    end 
    %display('Commanding Robot : ');
    %display(command_robot);
    
    imshow(final);
    display('DISPLAY AFTER imshow(final)');
else
    imshow(out)
    %display('DIS ELSE');
end
%if(command_robot==21)
 %   fprintf(s,'h');
end
%display('JUST b4 End');
%display(no);
%no=no-1;
%function command_robot=attemptGesture();

