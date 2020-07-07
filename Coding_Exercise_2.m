%%The function sieveOfEratosthenes used in this is derived from: rosettacode.org/wiki/Sieve_of_Eratosthenes#A_more_efficient_Sieve

N = 99; %Insert desired integer (N < 10,000) here.
Sieve_Value_N = sieveOfEratosthenes(N);
Array_N = N * ones(size(Sieve_Value_N)); 

Remainder = mod(Array_N, Sieve_Value_N);

for i = 1:length(Sieve_Value_N) 
    if Remainder(i) == 0
        disp(Sieve_Value_N(i))
    end
end