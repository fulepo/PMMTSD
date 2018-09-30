
Domanda: se ho una matrice dati D1 che nel passare dal tempo t1 al
tempo t2 subisce una trasformazione in D2 e calcolo l'svd di D1 e D2,
cosa ottengo se trovo la matrice di rotazione degli autovettori di D2
per esprimerli in termini degli autovettori (base) di D1?
I due scores plots S1 ed S2 mostreranno la 'traiettoria' degli oggetti 
seguita nella medesima base passando dal tempo t1 al tempo t2?

Se la risposta a questa domanda dovesse essere affermativa

x0 = rand(10,20)
x1 = [-x0(1:5,:); x0(6:10, :)]
x2 = [ x0(1:5,:); -x0(6:10, :)]

pca_x1 = nipals(x1)
figure
pca_x2 = nipals(x2)

Per trovare l'angolo in radianti
angolo2 = acos(corr(pca_x1.Scores(1,:)' ,pca_x2.Scores(1,:)'))

Scores2Rot = [(rotateVector(pca_x2.Scores(:,1:2), -angolo2))]

%% funziona, era una rotazione di 180 gradi sia su x che su y, in totale,
era una riflessione di 18 gradi attorno alla bisettrice.

figure
plot(pca_x1.Scores(:,1), pca_x1.Scores(:,2), '*')
text(pca_x1.Scores(:,1), pca_x1.Scores(:,2), ...
    pca_x1.OriginalData.Properties.RowNames)
hold on
plot(Scores2Rot(:,1), Scores2Rot(:,2), 'o')
text(Scores2Rot(:,1), Scores2Rot(:,2), ...
    pca_x2.OriginalData.Properties.RowNames)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% cASO CORRETTO

alpha = 0.6;
x0 = randn(10,10)
x1 = [exp(alpha.*x0(:,1:5)./5), exp(-alpha.*x0(:,6:10))]%, alpha.*x0(:,11:20)]
x2 = [exp(alpha.*x1(:,1:5)./5), exp(-alpha.*x1(:,6:10))]%, alpha.*x1(:,11:20)]
x3 = [exp(alpha.*x2(:,1:5)./5), exp(-alpha.*x2(:,6:10))]%, alpha.*x2(:,11:20)]
x4 = [exp(alpha.*x3(:,1:5)./5), exp(-alpha.*x3(:,6:10))]%, alpha.*x3(:,11:20)]
x5 = [exp(alpha.*x4(:,1:5)./5), exp(-alpha.*x4(:,6:10))]%, alpha.*x4(:,11:20)]
x6 = [exp(alpha.*x5(:,1:5)./5), exp(-alpha.*x5(:,6:10))]%, alpha.*x5(:,11:20)]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% se si impongono le seguenti uguaglianze si ottengono tutti punti
% coincidenti
%  x2=x1;
%  x3=x1;
%  x4=x1;
%  x5=x1;
%  x6=x1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pca_x1 = nipals(x1,2)
pca_x2 = nipals(x2,2)
pca_x3 = nipals(x3,2)
pca_x4 = nipals(x4,2)
pca_x5 = nipals(x5,2)
pca_x6 = nipals(x6,2)




%% COME CAMBIAMENTO DI BASE, QUINDI PROIEZIONE DI PC2,3,4,5 SU PC1

Scores2SCAL = pinv(pca_x1.Scores')*pca_x2.Scores'*pca_x1.Scores
Scores3SCAL = pinv(pca_x1.Scores')*pca_x3.Scores'*pca_x1.Scores
Scores4SCAL = pinv(pca_x1.Scores')*pca_x4.Scores'*pca_x1.Scores
Scores5SCAL = pinv(pca_x1.Scores')*pca_x5.Scores'*pca_x1.Scores
Scores6SCAL = pinv(pca_x1.Scores')*pca_x6.Scores'*pca_x1.Scores

for i=1:size(Scores2SCAL, 1)
a = dot(Scores2SCAL(i,:)', pca_x1.Scores(i,:)');
    if a<0
        Scores2SCAL(:,i) = -Scores2SCAL(:,i);
    end
end

for i=1:size(Scores3SCAL, 1)
a = dot(Scores3SCAL(i,:)', pca_x1.Scores(i,:)');
    if a<0
        Scores3SCAL(:,i) = -Scores3SCAL(:,i);
    end
end

for i=1:size(Scores4SCAL, 1)
a = dot(Scores4SCAL(i,:)', pca_x1.Scores(i,:)');
    if a<0
        Scores4SCAL(:,i) = -Scores4SCAL(:,i);
    end
end

for i=1:size(Scores5SCAL, 1)
a = dot(Scores5SCAL(i,:)', pca_x1.Scores(i,:)');
    if a<0
        Scores5SCAL(:,i) = -Scores5SCAL(:,i);
    end
end

for i=1:size(Scores6SCAL, 1)
a = dot(Scores6SCAL(i,:)', pca_x1.Scores(i,:)');
    if a<0
        Scores6SCAL(:,i) = -Scores6SCAL(:,i);
    end
end


figure
plot(pca_x1.Scores(:,1), pca_x1.Scores(:,2), '*')
text(pca_x1.Scores(:,1), pca_x1.Scores(:,2), ...
    pca_x1.OriginalData.Properties.RowNames)
hold on
plot(Scores2SCAL(:,1), Scores2SCAL(:,2), 'o')
text(Scores2SCAL(:,1), Scores2SCAL(:,2), ...
    pca_x2.OriginalData.Properties.RowNames)
hold on
plot(Scores3SCAL(:,1), Scores3SCAL(:,2), 'v')
text(Scores3SCAL(:,1), Scores3SCAL(:,2), ...
    pca_x3.OriginalData.Properties.RowNames)
hold on
plot(Scores4SCAL(:,1), Scores4SCAL(:,2), 's')
text(Scores4SCAL(:,1), Scores4SCAL(:,2), ...
    pca_x4.OriginalData.Properties.RowNames)
hold on
plot(Scores5SCAL(:,1), Scores5SCAL(:,2), 'x')
text(Scores5SCAL(:,1), Scores5SCAL(:,2), ...
    pca_x5.OriginalData.Properties.RowNames)
hold on
plot(Scores6SCAL(:,1), Scores6SCAL(:,2), 'x')
text(Scores6SCAL(:,1), Scores6SCAL(:,2), ...
    pca_x6.OriginalData.Properties.RowNames)


%%  CAMBIAMENTO DI BASE sui loadings su pc1
% 
% Load2SCAL = pinv(pca_x1.Loadings')*pca_x2.Loadings'*pca_x1.Loadings
% Load3SCAL = pinv(pca_x1.Loadings')*pca_x3.Loadings'*pca_x1.Loadings
% Load4SCAL = pinv(pca_x1.Loadings')*pca_x4.Loadings'*pca_x1.Loadings
% Load5SCAL = pinv(pca_x1.Loadings')*pca_x5.Loadings'*pca_x1.Loadings
% Load6SCAL = pinv(pca_x1.Loadings')*pca_x6.Loadings'*pca_x1.Loadings
% 
% figure
% plot(pca_x1.Loadings(:,1), pca_x1.Loadings(:,2), '*')
% text(pca_x1.Loadings(:,1), pca_x1.Loadings(:,2), ...
%     pca_x1.OriginalData.Properties.VariableNames)
% hold on
% plot(Load2SCAL(:,1), Load2SCAL(:,2), 'o')
% text(Load2SCAL(:,1), Load2SCAL(:,2), ...
%     pca_x2.OriginalData.Properties.VariableNames)
% hold on
% plot(Load3SCAL(:,1), Load3SCAL(:,2), 'v')
% text(Load3SCAL(:,1), Load3SCAL(:,2), ...
%     pca_x3.OriginalData.Properties.VariableNames)
% hold on
% plot(Load4SCAL(:,1), Load4SCAL(:,2), 's')
% text(Load4SCAL(:,1), Load4SCAL(:,2), ...
%     pca_x4.OriginalData.Properties.VariableNames)
% hold on
% plot(Load5SCAL(:,1), Load5SCAL(:,2), 'x')
% text(Load5SCAL(:,1), Load5SCAL(:,2), ...
%     pca_x5.OriginalData.Properties.VariableNames)
% hold on
% plot(Load6SCAL(:,1), Load6SCAL(:,2), 'x')
% text(Load6SCAL(:,1), Load6SCAL(:,2), ...
%     pca_x6.OriginalData.Properties.VariableNames)
% 
% 
