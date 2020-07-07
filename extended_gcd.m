%%This code returns the GCD, x, and y Bezout's coefficients. To achieve this, I modified the Python code for the extended Euclidean algorithm (available from: brilliant.org/wiki/extended-euclidean-algorithm/) to run on MATLAB.   

function extended_gcd(a, b)
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
    disp(gcd(a,b))
    disp(x)
    disp(y)