classdef BQF
    properties
        value
    end
    methods(Static)
        function [val1, val2, val3, val4] = BQF_reduce(val1, val2, val3, val4)
            g = gcd(abs(val1), gcd(abs(val2), gcd(abs(val3), abs(val4))));
            val1 = val1/g;
            val2 = val2/g;
            val3 = val3/g;
            val4 = val4/g;
        end
        function [val1, val2, val3, val4, val5] = BQF_reduce_2(val1, val2, val3, val4, val5)
            g = gcd(abs(val1), gcd(abs(val2), gcd(abs(val3), gcd(abs(val4), abs(val5)))));
            val1 = val1/g;
            val2 = val2/g;
            val3 = val3/g;
            val4 = val4/g;
            val5 = val5/g;
        end
        function BQF_output = BQF_construction(a, r, s, n)
            int64 a; int64 r; int64 s; int64 n;
            
            BQF_output = [a, r, s, n];
        end
        function out_thisBQF = BQF_create_child(a, r, s, b, c, n)
            int64 a; int64 r; int64 s; int64 n;
            
            %%Step 1: Skip each trivial rejection
            num = n - r * s - b * c - b * s - c * r;
            thisBQF = BQF_construction(a, (r + b), (s + c), n);
            if mod(num, thisbQF(1)) ~= 0
                ~thisBQF;
            end
            n1 = num/thisBQF(1);
            
            %%Step 2: U-V substitution
            a2 = thisBQF(1);
            b2 = thisBQF(3);
            c2 = thisBQF(2);
            n2 = n1;
            [a2, b2, c2, n2] = BQF_reduce(a2, b2, c2, n2);
            thisBQF = [a2, b2, c2, n2];
            
            %%Step 3: L substitutions
            a3 = -thisBQF(1);
            b3 = thisBQF(1);
            c3 = -2 * (thisBQF(2) - thisBQF(3));
            d3 = 2 * (thisBQF(2) + thisBQF(3));
            n3 = 4 * thisBQF(4);
            [a3, b3, c3, d3, n3] = BQF_reduce_2(a3, b3, c3, d3, n3);
            thisBQF = [a3, b3, c3, d3, n3];
            
            %%Step 4: Reduction
            a4 = 4 * thisBQF(1);
            b4 = -4 * thisBQF(1);
            c4 = -2 * thisBQF(3);
            d4 = thisBQF(3) + thisBQF(4);
            n4 = thisBQF(5);
            [a4, b4, c4, d4, n4] = BQF_reduce_2(a4, b4, c4, d4, n4);
            thisBQF = [a4, b4, c4, d4, n4];
            
            g = GCD(n4, GCD(abs(thisBQF(1)), abs(thisBQF(3))));
            a4 = thisBQF(1)/g;
            c4 = thisBQF(3)/g;
            n4 = thisBQF(5)/g;
            thisBQF = [a4, b4, c4, d4, n4];
            
            if thisBQF(5) < 0
                error('n is a negative value.')
            end
            
            out_thisBQF = [a, (r + b), (s + c), n];
            
            %%Change the index of vector list- do this in the AERISBQ code
            %%itself.
        end
        function BQF_create_children(a, r, s, n)
            BQF_create_child(a, r, s, 0, 0, n);
            BQF_create_child(a, r, s, a, a, n);
            BQF_create_child(a, r, s, a, 0, n);
            BQF_create_child(a, r, s, 0, a, n);
        end
        function BQF_remove_permutations(BQF_v)
            dups = py.tuple(int, int);
            i = [];
            while size(i) < size(v1) 
                r = v1(2);
                s = v1(3);
                if r > s
                    swap(v1, v2);
                    v1(2) = r;
                    v1(3) = s;
                    %%If we change this to a matrix, fix this so matrix
                    %%index increases.
                end
                found = false;
                while size(j) ~= found && j < dups
                    if dups(j,1) == r && dups(j,2) && s %%Make matrix of dups.
                        found = true;
                    end
                    if found
                        clear(v1)
                        i = i - 1;
                        v1(i) = [];
                    else
                        dups(end + 1) = py.tuple(r,s);
                    end
                end
            end
        end
    end
end
