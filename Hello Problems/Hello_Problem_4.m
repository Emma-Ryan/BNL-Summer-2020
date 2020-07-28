n = 1:4000;
multiples_of_7 = 7 * n;

for i = 1:4000
    if mod(multiples_of_7(i),2) ~= 0
        odd_multiples_of_7(i) = multiples_of_7(i);
    end
end

sum(odd_multiples_of_7)