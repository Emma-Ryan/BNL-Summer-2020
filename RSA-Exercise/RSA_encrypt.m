%%This function requires the extended_gcd.m file, which may be found in the 
%%Week-2 folder.

function RSA_encryption = RSA_encrypt(p, q, m)
    
    %%The first two values correspond to the public key (n and e, 
    %%respectively), the third to the private key (d), and the final one
    %%to the generated cyphertext (c) value for an ASCII input (m). 

    n = p * q; %%Where p and q are both prime integers.
    phi_n = (p - 1) * (q - 1);
    
    %%e must be an odd integer that does not share a factor with phi_n.
    %%To achieve this, I'm going to generate a string of random prime 
    %%numbers (> 2) based off my code from Coding Exercise 1. 
    
    primes = isprime(1:(phi_n - 1));
    primes_index = find(primes == 1); 
    e_index = randi(length(primes_index));
    e = primes_index(e_index);
    
    if e ~= 2
        e = primes_index(e_index);
    else
        error('The prime integer 2 was randomly selected for e. Please run again.')
    end
        
    %%This completes the generation of the public key.
    
    %%Generating the private key.
    d_array = extended_gcd(e, phi_n);
    d = d_array(2);
    
    if d_array(2) < 0
        d = phi_n + d_array(2);
    end
    
    %%Generating the cyphertext output.
    c = powermod(m, e, n);
    
    RSA_encryption = [n, e, d, c];
    
    
    