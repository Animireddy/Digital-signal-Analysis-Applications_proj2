Eavesdrop('q5/Police.ogg')
function [output] = Eavesdrop(audiodata)
    output = uint16(0);
    data = audioinfo(audiodata);
    
    for i = 1:data.Duration 
        flg = 1; %test flag 
        val2 = i*(data.SampleRate);
        val1 = (i-1)*(data.SampleRate);
        val1 = val1+1;
        sampledata = audioread(audiodata, [val1,val2]); 
        calc1 = fft(sampledata);
        max = 0;
        num = -100000;
        data_set = [fft(audioread('q5/0.ogg')), fft(audioread('q5/1.ogg')),fft(audioread('q5/2.ogg')),fft(audioread('q5/3.ogg')), fft(audioread('q5/4.ogg')), fft(audioread('q5/5.ogg')), fft(audioread('q5/6.ogg')), fft(audioread('q5/7.ogg')), fft(audioread('q5/8.ogg')), fft(audioread('q5/9.ogg'))];
        for k=1:10
            val = dot((data_set(:,k))',calc1');
            flg = flg+1;%test flag
            if val <= max
                %print
                continue
            else
                num = k-1;
                max = val;
            end
        end
        mul = output*10;
        output = mul + num;
    end
end
