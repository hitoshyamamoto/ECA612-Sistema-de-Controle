Tabela = [10^4,2*10^4,3.5*10^4,10^5,2*10^5;
          120,80,110,200,350];
Corrente = ones (1,5);
for i = 1:rows(Corrente)
  Corrente(i) = Tabela(i,1)*Tabela(i,2)
end

Potencia = ones (1,5);
for i = 1:rows(Potencia)
  Potencia(i) = Corrente(i)*Tabela(i,2)
end
