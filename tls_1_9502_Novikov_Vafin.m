close all
clear all
n1 = 50;
n2 = 200;
n3 = 1000;
alpha_1 = 0.1;
alpha_2 = 0.05;
alpha_3 = 0.01;

%{
Получаем выборку значений функции распределения 
случайной величины F(x), заранее проинтегрировав её 
плотность распределения f(x)
%}
F1 = ((rand(n1,1)).^(1/2)).*3; 
F2 = ((rand(n2,1)).^(1/2)).*3; 
F3 = ((rand(n3,1)).^(1/2)).*3; 
%{
F2 = (1/9)*((3*rand(n2,1)).^2);
F3 = (1/9)*((3*rand(n3,1)).^2);
%}
%{
Проводим точечную оценку среднего,
дисперсии и СКО
%}
M1 = mean(F1) %Находим мат ожидание%
V1 = var(F1) %Находим дисперсию%
S1 = std(F1) %Находим СКО %

M2 = mean(F2)
V2 = var(F2)
S2 = std(F2)

M3 = mean(F3)
V3 = var(F3)
S3 = std(F3)

%{
Интервальная оценка среднего
%}
[M11_1, M11_2] = interval_Average(alpha_1, n1, S1, M1)
[M12_1, M12_2] = interval_Average(alpha_2, n1, S1, M1)
[M13_1, M13_2] = interval_Average(alpha_3, n1, S1, M1)

[M21_1, M21_2] = interval_Average(alpha_1, n2, S2, M2)
[M22_1, M22_2] = interval_Average(alpha_2, n2, S2, M2)
[M23_1, M23_2] = interval_Average(alpha_3, n2, S2, M2)

[M31_1, M31_2] = interval_Average(alpha_1, n3, S3, M3)
[M32_1, M32_2] = interval_Average(alpha_2, n3, S3, M3)
[M33_1, M33_2] = interval_Average(alpha_3, n3, S3, M3)


%{
Интервальная оценка
дисперсии
%}


[D11_1, D11_2] = interval_Dispersion(alpha_1, n1, M1, F1)
[D12_1, D12_2] = interval_Dispersion(alpha_2, n1, M1, F1)
[D13_1, D13_2] = interval_Dispersion(alpha_3, n1, M1, F1)    

[D21_1, D21_2] = interval_Dispersion(alpha_1, n2, M2, F2)
[D22_1, D22_2] = interval_Dispersion(alpha_2, n2, M2, F2)
[D23_1, D23_2] = interval_Dispersion(alpha_3, n2, M2, F2)

[D31_1, D31_2] = interval_Dispersion(alpha_1, n3, M3, F3)
[D32_1, D32_2] = interval_Dispersion(alpha_2, n3, M3, F3)
[D33_1, D33_2] = interval_Dispersion(alpha_3, n3, M3, F3)



%{
Построение гистограмм и
теоретически полученная плотность вщероятности 
для непрерывной случайной величины
%}
hist_of_x(n1, F1);
hist_of_x(n2, F2);
hist_of_x(n3, F3);

%Дискретная случайная величина



for k=1:5;
p(k) = (factorial(4)/(factorial((k-1))*(factorial(4-(k-1)))))*0.2^(k-1)*0.8^(4-(k-1))
end

N = 50
k = [0:4]
for i = 1:N
   S = rand; 
   j = 1;
   while S>0 & j <= length(p)
       S = S - p(j);
       j = j + 1;
   end
   x(i) = k(j - 1)
end

Mx = mean(x)
Dx = var(x)


figure
syms x
F_pw = piecewise(x<0, 0, 0<x<3, (1/9)*x.^2, x>3, 1);
fplot(F_pw)
hold on
f_pw = piecewise(x<0, 0, 0<x<3, x/4.5, x>3, 0);
fplot(f_pw)

function hist_of_x(n, F) 
figure;

k = 1+3.322*log(n);
t1 = [0:3/(fix(k)-1):3];
counts = hist(F, k)/length(F)/(t1(2)-t1(1)); %нормализация 
bar(t1, counts)

hold on

f = @(x) x/4.5
fplot(f, [0, 3])
hold off
end

function [D1, D2] = interval_Dispersion(alpha, n, M, F)
    S_2 = (1/(n-1))*(sum((F - M).^2))
    chinvup = chi2inv(alpha/2, n-1); %критерий хи квадрат
    chinvdown = chi2inv(1-(alpha/2), n-1);
    D1 = (S_2)*(n-1)/chinvup
    D2 = (S_2)*(n-1)/chinvdown
end

function [M1, M2] = interval_Average(alpha, n, S, M)
    
    alphaup = 1-alpha/2; %верхняя граница уровня значимости%
    t_1 = tinv(alphaup, n-1); %критерий стьюдента для верхней границы%
    M1 = M - t_1*S/sqrt(n)
    M2 = M + t_1*S/sqrt(n)

end



