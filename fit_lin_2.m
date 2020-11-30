function [A,B, dA, dB, dY_prop] = fit_lin_2(x,y, dx, dy)
% Funzione che realizza fit lineare a due parametri y=  A+Bx
% Inserire in input vettore x, vettore y, incertezze dx , vettore dy incertezza
% restituisce vettore [A, B, dA, dB, dY_prop]
% lo script propaga anche le incertezze delle x

counter = 0; %conto le volte che entro nel while
%Calcolo pesi statistici
B = 0;
B_vecchio = 0; 
dB = 0; 
while (counter<=1 || B - B_vecchio > dB )
    counter = counter + 1 ;
    w = 1./ (( dy).^2);
    %Calcolo il Delta
    Delta = (sum(w))*(sum(w.*(x.^2)))-((sum(w.*x))^2);
    %Num A
    Num_A = (sum(w.*(x.^2)))*(sum(w.*y))-(sum(w.*x))*(sum(w.*x.*y));
    %Num B
    Num_B =(sum(w))*(sum(w.*x.*y))-(sum(w.*y))*(sum(w.*x));
    %Calcolo A e B
    A = Num_A / Delta;
    B_vecchio = B; 
    B = Num_B / Delta;
    dA = sqrt(sum( w.*(x.^2))/Delta);
    dB = sqrt(sum(w) / Delta);
    dy = sqrt(dy.^2 + B^2* dx.^2); %propago incertezze su y
end 
   dY_prop = dy;
end

