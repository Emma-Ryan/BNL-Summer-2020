%%The below code, submitted for Coding Exercise 4, is the totient function
%%(release 1.0) written by John D'Errico (contact:
%%woodchips@rochester.rr.com) using MATLAB

function phi = totient(N)

if (nargin~=1) || (isnumeric(N) && any(N(:)~=round(N(:))))
  error('Totient requires exactly one integer argument.')
end

%In case of an array or vector
nn = numel(N);
phi = N;
for i = 1:nn
  Ni = N(i);
  
  %Catch Ni == 1, or less than that
  if Ni <= 1
    if Ni == 1
      phi(i) = 1;
    else
      phi(i) = 0;
    end
    continue
  end
  
  %Get the factors of Ni
  F = factor(Ni);
  
  %If there was only one factor, but Ni is predicted to be composite
  if (length(F) == 1) && ~isprime(Ni)
    error('factor failed to find the factors of a composite number Ni')
  end
  
  %Only one factor?
  if length(F) == 1
    %Only one factor: N was prime
    phi(i) = F - 1;
  else
    %At least two factors in the list
    if isnumeric(F)
      %All of the factors were small numbers
      %Count the multiplicities
      [uF,I,J] = unique(F);
      countF = accumarray(J(:),1);
    else
      %"Brute force way"
      nf = length(F);
      uF = repmat(vpi(0),nf,1);
      countF = zeros(nf,1);
      
      %K is the number of distinct factors found
      k = 0;
      while ~isempty(F)
        %Grab the k'th distinct factor
        k = k + 1;
        %It is just the first element in F
        uF(k) = F(1);
        h = (uF(k) == F);
        %Count how many times it appeared
        countF(k) = sum(h);
        %Drop all the replicates of that factor
        F(h) = [];
      end
      
      %Clean up the pre-allocants
      countF = countF(1:k);
      uF = uF(1:k);
    end %If isnumeric(F)
    
    %Build the totient function from the distinct factors and their multiplicities
 
    phi(i) = 1;
    for j = 1:length(uF)
      fac = uF(j);
      
      if countF(j) == 1
        phi(i) = phi(i)*(fac - 1);
      else
        phi(i) = phi(i)*(fac - 1)*fac^(countF(j)-1);
      end
    end
  end %If length(F) == 1
end %For i = 1:nn