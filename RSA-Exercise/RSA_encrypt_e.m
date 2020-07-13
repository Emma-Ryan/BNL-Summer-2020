function RSA_encryption_e = RSA_encrypt_e(p, q, e, m)
    n = p * q; %%Where p and q are both prime integers.
    phi_n = (p - 1) * (q - 1);

    if gcd(e, phi_n) ~= 1 %%Where e is a prime value >= 3.   
        error('Please select a different value for e that shares no factors with ?(n).')
    end
    
    d_array = extended_gcd(e, phi_n);
    d = d_array(2);
    
    if d_array(2) < 0
        d = phi_n + d_array(2);
    end
    
    %%Generating the cyphertext output.
    c = powermod(m, e, n);
    
    RSA_encryption_e = [n, e, d, c];
    