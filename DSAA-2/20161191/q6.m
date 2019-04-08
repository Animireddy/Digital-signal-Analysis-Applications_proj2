q6prob('q6/message1.wav')
function [] = q6prob(fileName)
[Y,Fs] = audioread(fileName);
Y = Y-mean(Y);
X = fft(Y);
half_X = X(1: size(Y, 1)/2);
arr = zeros(4,size(half_X,1)/4);
[r,c] = size(half_X);

arr(1,:) = half_X(1:r/4);
arr(2,:) = half_X((r/4)+1:2*(r/4));
arr(3,:) = half_X(2*(r/4)+1:3*(r/4));
arr(4,:) = half_X(3*(r/4)+1:4*r/4);


min_val = 10000000;
final = zeros(4,1);
out_arr = zeros(size(Y));
check = zeros(4,1);

for i=1:4
	check(1) = i; 
    for j=1:4
        if j~=i
        	check(2) = j;
        else
            continue;
        end
        for k=1:4
            if i~=k && j~=k
            	check(3) = k;
            else
                continue;
            end
            for l=1:4
                if i~=l && j~=l && k~=l
                	check(4) = l
                else
                    continue;
                end
                
                % START
                
                for x=1:4
                    out_arr((x-1)*(size(half_X,1)/4)+1:((x*(size(half_X,1)/4)))) = (arr(check(x),:));
                end
                out_arr(size(half_X)+1:size(half_X)*2) = flipud(out_arr(1:size(half_X)))';
                final_sound = ifft(out_arr);
                xl = diff(final_sound);
                xl1 = abs(xl);
                differ = sum(xl1); 
                if (differ >= min_val)
                	continue;
                else
                    min_val = differ;
                    final = [i,j,k,l];
                end
                
                % END
                
            end
        end
    end
end
out_arr(1:r/4) = arr(final(1),:);
out_arr((r/4)+1:2*(r/4)) = arr(final(2),:);
out_arr(2*(r/4)+1:3*(r/4)) = arr(final(3),:);
half_X(3*(r/4)+1:4*r/4) = arr(final(4),:);
out_arr(size(half_X)+1:size(half_X)*2) = flipud(out_arr(1:size(half_X)))';
final_sound = ifft(out_arr);
sound(real(final_sound),Fs);
end