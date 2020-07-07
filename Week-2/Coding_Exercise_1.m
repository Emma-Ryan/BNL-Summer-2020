n = 10000; %%I selected 10,000 on with the assumption that if primes occur with an incidence of 10%, the first 1,000 primes would be found by examining the first 10,000 numbers; I'm not sure if this is an erroneous assumption or not.
S = [1:1:n];

Primes = isprime(S);
Primes_Index = find(Primes == 1);

for i = 1:1000
disp(Primes_Index(i))
end
