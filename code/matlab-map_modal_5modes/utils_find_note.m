function [note_name, nearest_frq] = utils_find_note(frq, FRQ_REF, NOTES)    
%UTILS_FIND_NOTE Cherche la note de la gamme tempérée la plus proche d'une fréquence donnée
% Inputs :
%   frq : Fréquence à approcher
%   FRQ_REF : Fréquences de la gamme tempérée
%   NOTES : Nom des notes
% Outputs :
%   note_name : Nom de la note la plus proche
%   nearest_frq : Fréquence de la gamme la plus proche

possible = zeros(12,10);

for i = 1:10
    for j = 1:12
        possible(j,i) = abs(frq - FRQ_REF(j,i));
    end
end


min_matrix = min(possible(:));
[j_final, i_final] = find(possible == min_matrix);

note_name = NOTES(j_final);
nearest_frq = FRQ_REF(j_final, i_final);
    
%     fprintf("Note : %s | Nearest frq : %f \n", note_name, nearest_frq);  
end

