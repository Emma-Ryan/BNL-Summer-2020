function output = RSA_decrypt(c, d, n)  
output = powermod(c, d, n);