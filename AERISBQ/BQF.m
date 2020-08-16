classdef BQF
    methods(Static)
        function BQF_reduce_output = BQF_reduce(val1, val2, val3, val4)
            g = gcd(abs(val1), gcd(abs(val2), gcd(abs(val3), abs(val4))));
            val1 = val1/g;
            val2 = val2/g;
            val3 = val3/g;
            val4 = val4/g;
            BQF_reduce_output = [val1, val2, val3, val4];
        end
        
        function BQF_reduce_2_output = BQF_reduce_2(val1, val2, val3, val4, val5)
            g = gcd(abs(val1), gcd(abs(val2), gcd(abs(val3), gcd(abs(val4), abs(val5)))));
            val1 = val1/g;
            val2 = val2/g;
            val3 = val3/g;
            val4 = val4/g;
            val5 = val5/g;
            BQF_reduce_2_output = [val1, val2, val3, val4, val5]; 
        end
        
        function BQF_output = BQF_construction(a, r, s, n)
            a = int64(a); r = int64(r); s = int64(s); n = int64(n);
            
            BQF_output = [a, r, s, n];
        end
        
        function out_thisBQF = BQF_create_child(a, r, s, b, c, n)
            thisBQF = BQF.BQF_construction(a, (r + b), (s + c), n);
            
            %%Step 1: Skip each trivial rejection
            num = n - r * s - b * c - b * s - c * r;
            if mod(num, thisBQF(1)) ~= 0
                out_thisBQF = [];
            else
                n1 = num/thisBQF(1);
            
                %%Step 2: U-V substitution
                a2 = thisBQF(1);
                b2 = thisBQF(3);
                c2 = thisBQF(2);
                n2 = n1;
                thisBQF = BQF.BQF_reduce(a2, b2, c2, n2);
            
                %%Step 3: L substitutions
                a3 = -thisBQF(1);
                b3 = thisBQF(1);
                c3 = -2 * (thisBQF(2) - thisBQF(3));
                d3 = 2 * (thisBQF(2) + thisBQF(3));
                n3 = 4 * thisBQF(4);
                thisBQF = BQF.BQF_reduce_2(a3, b3, c3, d3, n3); 
            
                %%Step 4: Reduction
                a4 = 4 * thisBQF(1);
                b4 = -4 * thisBQF(1);
                c4 = -2 * thisBQF(3);
                d4 = thisBQF(3) + thisBQF(4);
                n4 = thisBQF(5);
                thisBQF = BQF.BQF_reduce_2(a4, b4, c4, d4, n4);
            
                g = gcd(n4, gcd(abs(thisBQF(1)), abs(thisBQF(3))));
                a4 = thisBQF(1)/g;
                c4 = thisBQF(3)/g;
                n4 = thisBQF(5)/g;
                thisBQF = [a4, b4, c4, d4, n4];
            
                if thisBQF(5) < 0
                    error('n is a negative value.')
                end
            
                out_thisBQF = [a, (r + b), (s + c), n];
            end
            
            %%Change the index of vector list- do this in the AERISBQ code
            %%itself.
        end
        
        function out_theseBQFs = BQF_create_children(a, r, s, n)
            out_theseBQFs_1 = BQF.BQF_create_child(a, r, s, 0, 0, n);
                if isempty(out_theseBQFs_1) == 1
                    ~out_theseBQFs_1;
                else
                    out_theseBQFs_1(1, 1:4) = BQF.BQF_create_child(a, r, s, 0, 0, n);
                end
            out_theseBQFs_2 = BQF.BQF_create_child(a, r, s, a, a, n);
                if isempty(out_theseBQFs_2) == 1
                    ~out_theseBQFs_2;
                else
                    out_theseBQFs_2(1, 1:4) = BQF.BQF_create_child(a, r, s, a, a, n);
                end
            out_theseBQFs_3 = BQF.BQF_create_child(a, r, s, a, 0, n);
                if isempty(out_theseBQFs_3) == 1
                    ~out_theseBQFs_3;
                else
                    out_theseBQFs_3(1, 1:4) = BQF.BQF_create_child(a, r, s, a, 0, n);
                end
            out_theseBQFs_4 = BQF.BQF_create_child(a, r, s, 0, a, n);
                if isempty(out_theseBQFs_4) == 1
                    ~out_theseBQFs_4;
                else
                    out_theseBQFs_4(1, 1:4) = BQF.BQF_create_child(a, r, s, 0, a, n);
                end
           
           out_theseBQFs = [out_theseBQFs_1, out_theseBQFs_2, out_theseBQFs_3, out_theseBQFs_4];
           size_out_theseBQFs = length(out_theseBQFs)/4;
           out_theseBQFs = reshape(out_theseBQFs, [4, size_out_theseBQFs]);
        end
        
        function fixed_BQFs_final = BQF_remove_permutations(v2, w)
            dups = v2(1:w, 1:3);
            
            for w = 1:dups(end) 
                r = dups(w, 2);
                s = dups(w, 3);
                if r > s
                    r = dups(w, 2);
                    s = dups(w, 3);
                end
                
                if r == dups(:, 2) && s == dups(:, 3)
                    dups(w, :) = [];
                end
            end
            
            fixed_BQFs_final(1:dups(end), 1:3) = dups(1:dups(end), 1:3);
        end
    end
end