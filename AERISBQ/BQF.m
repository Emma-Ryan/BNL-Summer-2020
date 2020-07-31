classdef BQF
    properties
        int64 N;
        
        int64 a; int64 r; int64 s; int64 n;
        int64 a2; int64 b2; int64 c2; int64 n2;
        int64 a3; int64 b3; int64 c3; int64 d3; int64 n3;
        int64 a4; int64 b4; int64 c4; int64 d4; int64 n4;
        
        int64 v; int64 v1; int64 v2; int64 v3; int64 v4; int64 v5; int64 g; 
        
        int64 num;
    end
    methods(Static)
        function BQF_gcd = gcd(a, b)
            if b == 0
                BQF_gcd = a;
            else
                BQF_gcd = gcd(b, mod(a, b));
            end
        end
        function BQF_reduce(v1, v2, v3, v4)
            g = gcd(abs(v1), gcd(abs(v2), gcd(abs(v3), abs(v4))));
            v1 = v1/g;
            v2 = v2/g;
            v3 = v3/g;
            v4 = v4/g;
        end
        function BQF_reduce_2(v1, v2, v3, v4, v5)
            g = gcd(abs(v1), gcd(abs(v2), gcd(abs(v3), gcd(abs(v4), abs(v5)))));
            v1 = v1/g;
            v2 = v2/g;
            v3 = v3/g;
            v4 = v4/g;
            v5 = v5/g;
        end
        function BQF_construction(a, r, s, n)
            a(a); r(r); s(s); n(n);
            a2 = []; b2 = []; c2 = []; n2 = []; 
            a3 = []; b3 = []; c3 = []; d3 = []; n3 = [];
            a4 = []; b4 = []; c4 = []; d4 = []; n4 = [];
        end
        function BQF_child = BQF_create_child(BQF_child)
            %%Step 1: Skip each trivial rejection.
            num = n - r * s - b * c - b * s - c * r;
            if mod(num, a) ~= 0
                ~BQF_child;
            end
            n1 = num/a;
            BQF.thisBQF = BQF_construction(a, (r + b), (s + c), n);