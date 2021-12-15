close all
clear all

%задаем матрицу вероятностей переходов
p=[2,5,3,4; 8,5,4,2; 5,4,3,2; 1,5,4,4];

%генерируем цепь маркова
mc = dtmc(p);
mc.StateNames = ["Healthy", "Unwell", "Sick", "Very Sick"];

%проверяем что сумма всех вероятностей = 1
for i=1:length(mc.P(:,1))
    s(i)=sum(mc.P(i,:))
end

figure
graphplot(mc, "ColorEdges", true)

%{
----Строим кумулятивную матрицу переходов----
%}

P_cum=cumsum(mc.P, 2)

%{
----Генерируем поведение цепи Маркова----
%}

K=200
z_t_200=markov_chain_bh(mc, P_cum, 200)
z_t_1000=markov_chain_bh(mc, P_cum, 1000)
z_t_10000=markov_chain_bh(mc, P_cum, 10000)

figure
subplot(3,1,1)
plot(z_t_200)
subplot(3,1,2)
plot(z_t_1000)
subplot(3,1,3)
plot(z_t_10000)

P_obs_200=markov_obs(z_t_200)
P_obs_1000=markov_obs(z_t_1000)
P_obs_10000=markov_obs(z_t_10000)

mc_obs_200=dtmc(P_obs_200)
mc_obs_1000=dtmc(P_obs_1000)
mc_obs_10000=dtmc(P_obs_10000)

figure
subplot(3,1,1)
graphplot(mc_obs_200, "ColorEdges", true)

subplot(3,1,2)
graphplot(mc_obs_1000, "ColorEdges", true)

subplot(3,1,3)
graphplot(mc_obs_10000, "ColorEdges", true)


function P_obs=markov_obs(z_t)
P_obs=zeros(4,4);
for i=1:length(z_t)-1;
    P_obs(z_t(i),z_t(i+1))=P_obs(z_t(i),z_t(i+1))+1;
    P_obs(z_t(i), :) = P_obs(z_t(i), :)./sum(P_obs(z_t(i), :));  %нормируем
end

end

function z_t=markov_chain_bh(mc, P_cum, K)
z_t=zeros(1,K);
z_t(1,1)=1;
for i=1:K-1;
    r=randi(100)/100;
    for j=1:mc.NumStates;
        if r>=P_cum(z_t(1,i),j);
            z_t(1,i+1)=j;
        elseif z_t(1,i+1)==0;
            z_t(1,i+1)=z_t(1,i);
        end
    end
end
end


