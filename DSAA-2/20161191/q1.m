fft1([1 2 3 4;1 2 3 4;1 2 3 4;1 2 3 4])
function res = fft1(X)
    [m, n] = size(X);
    
    res = zeros(m,n); 
    %call each row
    for j=1:m
        res(j,:) = recursion(X(j,:)); %all elements in jth row corresponding fft(jth row) = jth row in res
    end
   
    res = res'; %transponse 
    
    for j=1:n
        res(j,:) = recursion(res(j,:)); % out of row fft => cols wise fft 
    end       
    res = (res)'; %interchange
end

function out = recursion(arr)
len = length(arr);
if(len ~= 1)
    even_terms = arr(1:2:len);
    odd_terms  = arr(2:2:len);
    F_even = recursion(even_terms);
    F_odd  = recursion(odd_terms);
    for i = 1:len/2
        out(i) = F_even(i) + exp(-2*pi*j*(i-1)/len)*F_odd(i); %first half
        out(i+len/2) = F_even(i) - exp(-2*pi*j*(i-1)/len)*F_odd(i); %sec half
    end
    return
else
    out(1) = arr(1);
    return
    
end
end

        
