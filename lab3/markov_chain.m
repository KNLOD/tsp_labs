close all
clear all

%задаем матрицу вероятностей переходов
p=[2,5,3,4; 8,5,4,2; 5,4,3,2; 1,5,4,4];

%генерируем цепь маркова
mc = dtmc(p);
mc.StateNames = ["Healthy", "Unwell", "Sick", "Very Sick"];
mc.P

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


z_t=zeros(1,200)
z_t(1,1)=1
for i=1:200;
    r=rand
    for j=1:mc.NumStates
        if r>P_cum(z_t(1,i),j)
            z_t(1,i+1)=j
        else
            z_t(1,i+1)=z_t(1,i)
        end
    end


end

figure
plot(z_t)
