clear all, close all

file="FIR.wav";

[s, fe] = audioread(file);
n=0:length(s);

figure()
plot(s)
xlabel('n'), ylabel("p_+(n)")
set(gcf,'units','points','position',[100,10,400,150])