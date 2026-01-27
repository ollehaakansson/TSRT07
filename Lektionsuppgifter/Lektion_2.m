% Uppgift 3.1 a)
% Simulera stegsvaret för G och anpassa 3-para model &
% Zeigler-N-Model
% Rita stegsvaren för modellerna i samma
% figur som stegsvaret för systemet
G = tf(2,[1 7 16 10]);
%step(G)
%grid on

% Läser av kurvan och ser:

% För treparametersmodellen:
% Dötid (Tidsfördröjning)
% Avläser det där brantaste vinkeln på stegsvarets tangent korsar x-axeln
L = 0.3;
% Den proportionella förstärningen (vad y(t) -> när t -> inf)
K_p = 0.2;
% Tidskonstant (t när y(t) = 0.63 * K_p)
T = 1.68;

% För Zeigler-Nichols-Modellen
% Max lutning hos stegsvar
b = 0.1;

% Dötid (Tidsfördröjning)
% Samma som ovan

G_3 = tf(K_p, [T 1], 'InputDelay', L);
G_ZN = tf(b, [1 0], 'InputDelay', L);

step(G, G_3, G_ZN, 10)
axis([0 4 0 .25])
grid on

% ------------------------------------------------------------------------

% Uppgift 3.1 a)
% Simulera ett självsvängningsexperiment med systemet och beräkna den kri-
% tiska förstärkningen och periodtiden.

% Vi ska hitta K_u & mäta T_u

