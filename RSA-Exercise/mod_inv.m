%%This code is adapted from the Python implementation for  
%%calculating the modulo inverse by application of the extended
%%Euclidean algorithm (available from: brilliant.org/wiki/modular-
%%arithmetic/#modular-arithmetic-multiplicative-inverses).

%%It requires the extended_gcd.m file to run, which may be found in the
%%Week-2 folder.

function l = mod_inv(a, m)  
    l_array = extended_gcd(a, m);
    if l_array(1) ~= 1
        disp('No modular inverse')
    else
        k = l_array(2);
        l = mod(k, m);
    end
    