%% STUDIO DEGLI ESPONENTI DI LYAPUNOV DELLA MAPPA LOGISTICA
% questo codice studia l'evoluzione di due condizioni iniziali molto vicine della mappa logistica 
% si stima poi l'esponente di lyapunov attraverso regressione lineare dei dati ottenuti.
%G.Puleo - autunno 2020


%NOTA : PER AVERE UNA MAGGIOR PRECISIONE SUI NUMERI 
%A VIRGOLA MOBILE VIENE UTILIZZATO IL PACCHETTO HPF  DISPONIBILE AL SEGUENTE LINK
%https://it.mathworks.com/matlabcentral/fileexchange/36534-hpf-a-big-decimal-class
% PSEUDOCODICE
% -IMPOSTO MAPPA LOGISTICA E SCELGO r > 3.6... (dove la mappa logistica è
% caotica)
% -SCELTO R PRENDO DUE CONDIZIONI INIZIALI VICINE 
% -ITERO MAPPA UN TOT DI VOLTE E MONITORO X1-X2
% -PLOTTO log( X1n - X2n ) in funzione di n
% vediamo se fitta un esponenziale


r = 3.7232;  % parametro
x_a = hpf(0.5); %cond iniziale 1
delta_0 = hpf(exp(-30)); %differenza tra condizioni iniziali
x_b = x_a + delta_0; % condizione iniziale 2
L = @(x) r*x*(1-x); % creo funzione con mappa logistica

volte = 400; %scelgo quante iterazioni fare
risultati = hpf.zeros( volte, 3 ) ; % creo un array dove stampare i risultati

for i = 1 : volte
    %nelle prime due colonne segno le orbite al tempo tn
    risultati( i, 1 ) = L(x_a);
    risultati( i ,2 ) = L(x_b);
    %nella terza colonna segno la distanza che è quello che mi interessa
    risultati( i ,3 ) = abs(risultati(i, 1) - risultati( i, 2));
    %aggiorno condizioni "iniziali" ( che non sono più iniziali) 
    x_a = risultati( i, 1 );
    x_b = risultati( i ,2 );
    
end
figure();
hold on;
%orbit_1 = plot( 1:volte , risultati(:, 1));
%orbit_2 = plot( 1:volte, risultati(:,2 )) ;
difference = plot( 1:volte, log(risultati(:, 3)));
fine = 150;
dati = log( risultati (1:fine, 3));
x = transpose(1:fine) ;
dx = ones ( size( x ) ) ; 
[A, B , ~, ~, ~ ] = fit_lin_2( x, dati, dx ,dx ) ; %questa funzione è disponibile nella 
%stessa repository in cui si trova questo script. È una comune regressione lineare a due parametri.
modello_lyap = @(xx) A + B*xx;
exp_plot = fplot( modello_lyap, [0, fine+1] ) ;
legend([difference, exp_plot], 'simulazione',...
    'ln(\Delta(n)) = A +  \lambda n' )  ;
xlabel('n', 'fontsize', 14);
ylabel('ln(\Delta(n))', 'fontsize' , 14);









