%clear all;
y = randn(100000,1);
y = sort(y);
n = 4; % codebook length = 2^n

l = 100000; % # of samples
%bl = -2*pi; %left border
%br = 2*pi;  %right border
bl = 0; br = 10;
t = zeros(1,l);
for i=1:l
    t(i) = bl + i*(br - bl)/l;
end

x = cos(t);   %x is input signal
x = y;

xQ = x; % declare quantization of signal

[partition,codebook] = lloyds(y,2^n); %compute partition and codebook according to Lloyd-Max-Quantizer
%[partition,codebook] = lloyd_max(x,2^n); %compute partition and codebook according to Lloyd-Max-Quantizer


% assign quantization values
for i=1:length(x)
    if(x(i)<partition(1))
        xQ(i) = codebook(1);
    elseif(x(i)>partition(length(partition)))
        xQ(i) = codebook(length(codebook));
    else
        for j=2:length(partition)
            if(x(i)>partition(j-1) && x(i)<partition(j))
                xQ(i) = codebook(j);
            end
        end
    end
end

p = plot(t,x);
hold all;
%pQ = plot(t,xQ);
%set(pQ,'Color','green');
for i=1:length(codebook)
    l = line([bl;br],[codebook(i);codebook(i)]);
    set(l,'Color','green');
end
% for i=1:length(partition)
%     l = line([bl;br],[partition(i);partition(i)]);
%     set(l,'Color','yellow');
% end