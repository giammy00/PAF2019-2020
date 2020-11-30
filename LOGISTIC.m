% QUESTO SCRIPT MATLAB CALCOLA L'EVOLUZIONE DEL SISTEMA DINAMICO DISCRETO ASSOCIATO ALLA MAPPA LOGISTICA
% VENGONO PLOTTATI I CARATTERISTICI DIAGRAMMI A RAGNATELA E IL GRAFICO X_N(N). 
% G.Puleo -autunno 2020
r = 3.7232; % parametro
L = @(x) r*x*(1-x); % creo funzione con mappa logistica
volte = 70; %stabilisco quante iterazioni
X_0_VALUES = rand(3,1); %genera tre condizioni iniziali a caso in [0, 1]

ris = zeros ( volte, numel(X_0_VALUES) ); % array per risultati

fig_cobweb = figure();
set(fig_cobweb, 'color', [1,1,1]); %colora figura di bianco
hold on;

%disegno retta e parabola per diagramma a ragnatela
retta= fplot( @(x) x, [0 1]);
set(retta, 'color' , 'k', 'linewidth', 1);
logistic = fplot( L, [0 1]);
set(logistic, 'color', 'r', 'linewidth', 1);
colori_iterazioni = 'myg'; %serve a colorare in modo diverso i diagrammi ragnatela di cond iniziali diverse

p = gobjects(numel(X_0_VALUES), 2); %array per i plot handle
for jj=1:numel(X_0_VALUES)
    x_0 = X_0_VALUES(jj); %cond iniziale
    x_INIZIALE= x_0; %serve solo per salvare x_0 
    for ii = 1 : volte
        %questo ciclo è il cuore dello script
        ris(ii,jj) = x_0; %salvo il valore x_0
        x_0 = L(x_0);  %calcolo il valore della mappa in x_0
        
        %disegno i due pezzi del diagramma a ragnatela 
        %relativi alla ii-esima iterazione del ciclo
        if ii==1
          p(jj,1)=plot([ris(ii,jj), ris(ii,jj)], [0 x_0]);
        else
          p(jj,1)=plot([ris(ii,jj), ris(ii,jj)], [ris(ii,jj) x_0]);
        end
        %ne imposto i colori
        set(p(jj,1), 'color', colori_iterazioni(jj), 'linewidth', 1);
        p(jj,2)=plot([ris(ii,jj), x_0], [x_0, x_0]);
        set(p(jj,2), 'color', colori_iterazioni(jj), 'linewidth', 1);
    end
end
%imposta legenda dei diagr a ragnatela
ll=legend([retta, logistic, transpose(p(:,1))], {'y=x',['y=rx(1-x) con r=' num2str(r,4)],...
   ['iterazioni con x_0=' num2str(X_0_VALUES(1),2)], ...
   ['iterazioni con x_0=' num2str(X_0_VALUES(2),2)],...
   ['iterazioni con x_0=' num2str(X_0_VALUES(3),2)] } );

set(ll, 'fontsize', 10);
xl1 = xlabel('x','fontsize',14);
yl1 = ylabel('y','fontsize',14);
hold off


%mostra anche grafico di x_n in funzione di n per le tre iterazioni eseguite
fig_1 = figure();
set(fig_1, 'color', [1,1,1]);
hold on
pl = gobjects(1, numel(X_0_VALUES));
for kk=1:numel(X_0_VALUES) 
pl(kk) = plot( [0:volte-1], ris(:,kk) );
%set( pl(kk), 'linestyle','none');
set( pl(kk), 'marker', '.');
set( pl(kk), 'markersize', 10);
set( pl(kk), 'color' , colori_iterazioni(kk));
%set( pl, 'markerfacecolor');


%imposto legenda e etichette assi

xl = xlabel('n');
yl = ylabel('x_n');
%li ingrandisco
set( xl,'fontsize', 14);
set( yl,'fontsize', 14);

hold on
end
%imposta anche qui una legenda
l2 = legend( pl(1,:), ...
    ['x_0='  num2str(X_0_VALUES(1),2)],...
    ['x_0='  num2str(X_0_VALUES(2),2)],...
    ['x_0='  num2str(X_0_VALUES(3),2)]);
hold off
set(l2, 'fontsize', 16);
