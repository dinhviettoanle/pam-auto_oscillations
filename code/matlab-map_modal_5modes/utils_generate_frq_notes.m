function [FRQ_REF, NOTES] = utils_generate_frq_notes()
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

