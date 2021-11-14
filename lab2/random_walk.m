clear all
close all

N=200;                          % Количество отсчетов
K=400;                          % Количество реализаций
mu=0;                           % Среднее по ансамблю
sigma=1;                        % 
scatter_pos1=[10,9 ;50,49;100,99;200,199]
scatter_pos2=[50,40;100,90;200,190]

rm_walk = zeros(N,K);   % Генерация матрицы с NxK


%{
---------Генерация случайного блуждания------
%}
for i=1:K;
    for j=2:N;
        rm_walk(j,i)= rm_walk(j-1,i) + normrnd(mu, sigma);
    end
end 

%{
----Построение всех реализаций на одном полотне------
%}
figure
for i=1:K;
    plot(rm_walk(:,i))
    hold on
end

%{
--------Построение диаграмм рассеяния---------
%}
figure
scatter_rm_walk(rm_walk, scatter_pos1,1)
scatter_rm_walk(rm_walk, scatter_pos2,2)

ar = autocorr(

function scatter_rm_walk(rm_walk, scatter_pos,plot_number)
k=length(scatter_pos(:,1))
for i=1:k;
    subplot(2,1,plot_number)
    scatter(rm_walk(scatter_pos(i,1),:),rm_walk(scatter_pos(i,2),:)); 
    hold on
end
hold off
end
