load q2/q2.mat
input_fft = fft(X);
[m,n] = size(input_fft);
[val, ind] = sort(input_fft);
changed_input_fft = zeros(m, 1);
changed_input_fft(ind(m)) = input_fft(ind(m));
changed_input_fft(ind(m-1)) = input_fft(ind(m-1));
changed_signal = ifft(changed_input_fft);
audiowrite('q2/changedtered.wav',changed_signal ,Fs);
sound(changed_signal, Fs);


