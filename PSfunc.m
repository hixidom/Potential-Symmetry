function [I]=PSfunc(atoms,source,detector)

for i=1:size(atoms,1)
    sourcedist(i)=sqrt(sum((atoms(i,:)-source).^2));
    detectordist(i)=sqrt(sum((atoms(i,:)-detector).^2));
    %invert(i,i)=1;
    for j=(i+1):size(atoms,1)
        dist(i,j)=sqrt(sum((atoms(j,:)-atoms(i,:)).^2));
        dist(j,i)=dist(i,j);
        %invert(i,j)=exp(1i*pi);
        %invert(j,i)=exp(1i*pi);
    end
end

wlrange=linspace(0,2*max(max(dist)),100); %Range of wavelengths to test
wlrange=wlrange(2:end); %Omit wlrange=0

atten=1;%exp(-dist); %Attenuation of signal over distance
phase=exp(1i*dist); %Phase evolution of signal over distance

I=[];
for wl=wlrange
    T=(atten.*(phase.^(2*pi/wl)))^(size(atoms,1)); %Transition matrix
    I(end+1)=sum(sum(real(T)))^2;
end

% %Diagnostic plots
% atoms
% figure(2);
% clf();
% plot(wlrange,I);
% pause();

I=sum(I);%Integrate over intensity