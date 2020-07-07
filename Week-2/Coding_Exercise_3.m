%%I based my coding for this question on Alpha's code (PellsEquation.py) 

for n = 2:70
    if mod(sqrt(n),1) == 0
        y = 0;
    else
        for x = 1:70000
            y = sqrt((1./(n * (x.^2 - 1))));
        end
    end
    disp(y)
end

