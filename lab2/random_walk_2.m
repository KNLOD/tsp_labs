clear all
close all

N=200;                          % Количество отсчетов
K=400;                          % Количество реализаций
mu=0;                           % Среднее по ансамблю
sigma=1;                        % 
l1=2;
l2=20;

scatter_pos1=[10,9 ;50,49;100,99;200,199]
scatter_pos2=[50,40;100,90;200,190]

rm_walk = zeros(N,K);   % Генерация матрицы с NxK


%{
----Генерация случайного блуждания c затуханием------
%}
for i=1:K;
    for j=2:N;
        rm_walk(j,i)= 0.9*rm_walk(j-1,i) + normrnd(mu, sigma);
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

%{
-----Расчет автокорр функции----
%}
rm_walk_shifted=circshift(rm_walk,1);
rm_walk_times=rm_walk_shifted.*rm_walk;

for i=1:N;
    autocorr_rm_walk(i)=mean(rm_walk_times(i,:));
end

figure
plot(autocorr_rm_walk)
hold on
%{
-----Теоретический расчет sigma и АКФ----
%}

n=0:N-1;
a_corr_theoretical=0.05*(1-0.9.^n)./(1-0.9).^2;
plot(a_corr_theoretical);

function scatter_rm_walk(rm_walk, scatter_pos,plot_number)
k=length(scatter_pos(:,1))
for i=1:k;
    subplot(2,1,plot_number)
    scatter(rm_walk(scatter_pos(i,1),:),rm_walk(scatter_pos(i,2),:)); 
    hold on
end
hold off
end
