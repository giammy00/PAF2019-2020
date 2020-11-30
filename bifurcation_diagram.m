%% script per costruire il diagramma delle biforcazioni della mappa logistica.
%noto anche come ALBERO DI FEIGENBAUM 
%G. Puleo - autunno 2020

%PSEUDOCODICE
%1) inizializza tutto il necessario r=1, x_0 a caso in [0, 1]
%2) itera 700 volte e butta via
%3) itera altre 1500 volte e salva il risultato
%4) plotta( x=[r r] y=[array_risultati]
%5) incrementa r di 0.001 e rifai tutto, fino a r=4
%x_0 = rand(); %cond iniziale

grbg = 10000; %stabilisco quante iterazioni da buttare : più sono e meglio è
volte = 1200; %stabilisco quante iterazioni da tenere, dopo aver buttato via le prime
ris = zeros( volte, 1); %array da stampare di volta in volta
%garbage = zeros ( grbg, 1 ) ; % array per spazzatura
r_coord = zeros( size(ris));
fig1 = figure('color', [1 1 1 ]);
hold on;
r_min = 0;
r_max = 4;
passo = 0.0005;
for r=r_min:passo:r_max
    L = @(x) r*x*(1-x); % creo funzione con mappa logistica
    x_0 = rand();
    r_coord(:) = r; %serve per il plot dei punti
for ii = 1 : grbg
    %questo ciclo butta via i primi 'volte' risultati
  %  garbage(ii)= x_0; %salvo il valore x_0
    x_0 = L(x_0);  %calcolo il valore della mappa in x_0
end


%qua calcolo i valori che mi servono e che andrò a plottare
for jj= 1:volte
    ris(jj)= x_0;
    x_0 = L(x_0);
end
% topl = []; %taglia i valori che mi interessano
% rtopl = [];
% for jj = 1:volte
%     if ris(jj)>0.86
%        topl = [ topl, ris(jj)];
%        rtopl =[ rtopl, r_coord(jj)];
%     end
% end
% rtopl = rtopl';
% topl = topl';
%p = plot(rtopl, topl);
p = plot( r_coord, ris ) ;
set ( p ,'color', 'r');
set ( p, 'marker', '.');
set ( p, 'markersize', 0.5);
set ( p, 'linestyle' , 'none');
end
xlabel('r', 'fontsize', 12);
ylabel('attrattore della mappa logistica', 'fontsize', 12);
%estremi del disegno
x_inf = 0;
x_sup = 4;
y_inf = 0;
y_sup = 1;

xlim( [x_inf x_sup] );
ylim( [y_inf y_sup] );












