function [FRQ_REF, NOTES] = utils_generate_frq_notes()
%UTILS_GENERATE_FRQ_NOTES Génère les fréquence et noms des notes de la gamme tempérée
% Outputs :
%   FRQ_REF : Matrice des fréquences de la gamme tempérée
%   NOTES : Nom des notes
NOTES = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"];

FRQ_REF = ones(12,10);

r = 2^(1/12);
n = -45;

for i = 1:10
    for j = 1:12
        FRQ_REF(j,i) = 440 * r^n;
        n = n + 1;
    end
end   
end

