s=serial('COM11');
fopen(s);

while(1)
    a=input('Gesture input\n');
    
    if a==1
        disp('ON')
        fprintf(s,'h')
    else
        disp('OFF')
        fprintf(s,'l')
    end
end

