clear all
close all
N=200;
K=400;
mu=4; %среднее по ансамблю
sigma=8;
xi = normrnd(mu,sigma,[N,K]); % генерация матрицы с К реализациями случайного процесса

%Строим среднее по ансамблю
figure
xi_average=zeros(N,1);
for i=1:N;
    for j=1:K;
        xi_average(i) = xi_average(i) + xi(i,j)/K;
    end
end
plot([1:N],xi_average)

hold on

% Строим среднее по времени
xi_average_t=zeros(N,1);
for i=1:N;
    for j=1:N;
        xi_average_t(i) = xi_average_t(i) + xi(j,i)/N;
    end
end
plot([1:N],xi_average_t)


                       