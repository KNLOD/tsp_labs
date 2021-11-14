clear all
close all
N=200;                          % Количество отсчетов
K=400;                          % Количество реализаций
mu=4;                           % Среднее по ансамблю
sigma=8;                        % 
xi = normrnd(mu,sigma,[N,K]);   % Генерация матрицы с К реализациями случайного процесса

%{
--------Построение среднегно по ансамблю---------
%}
figure
xi_average=zeros(N,1);
for i=1:N;
    for j=1:K;
        xi_average(i) = xi_average(i) + xi(i,j)/K;
    end
end
plot([1:N],xi_average)

hold on
%{
--------Построение среднегно по времени---------
%}
xi_average_t=zeros(N,1);
for i=1:N;
    for j=1:N;
        xi_average_t(i) = xi_average_t(i) + xi(j,i)/N;
    end
end
plot([1:N],xi_average_t)

%{
--------Построение диаграмм рассеяния---------
%}
figure
k=3;              % Количество диаграмм рассеяния
for i=1:k;
    subplot(k,1,i)
    scatter(xi(randi(N),:),xi(randi(N),:)); 
end

%{
-------Расчет выборочной коррелляции----------
%}
r_1=xcorr(xi(randi(N),:),xi(randi(N),:))




                       