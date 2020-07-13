%%This code returns the GCD and the Bezout's coefficients x and y. To 
%%achieve this, I modified the Python code for the extended Euclidean 
%%algorithm (available from: brilliant.org/wiki/extended-euclidean-
%%algorithm/) to run on MATLAB.   

function gcd_results = extended_gcd(a, b)
    x = 0;
    y = 1;
    u = 1;
    v = 0;
    while a > 0
        q = floor(b/a);
        r = mod(b,a);
        m = x-u*q;
        n = y-v*q;
        b = a;
        a = r;
        x = u;
        y = v;
        u = m;
        v = n;
    end
    gcd_results = [gcd(a,b), x, y];
    