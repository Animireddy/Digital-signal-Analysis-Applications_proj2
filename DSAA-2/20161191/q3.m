	load laughter;
	spec(y,100,1)
	function [result] = spec(file,window,stride_len)
	initial = 1;
	rows = size(file,1);
    file=file';
	strip_rows = ceil(rows/(window-stride_len)); %nearest integer greater than that %no.of small windows within large window
	out_arr = [window,strip_rows]; 
	i = 1;
	lastind = initial + window - 1;
	while lastind <= rows
	    a = file(initial:lastind).*(gausswin(window))'; %filter
	    a = abs(fft(a));
	    out_arr(1:window,i) = a;
	    i = i + 1;
	    initial = initial + window - stride_len; %window last stride_len
	    lastind = initial + window - 1; %consider first window with updated initial and end index
    end
    out_arr = out_arr';
	figure, imagesc(flipud(log(out_arr(:,1:window/2))));
	colorbar;
	result = out_arr;
	end