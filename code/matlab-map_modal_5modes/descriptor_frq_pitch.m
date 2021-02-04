function [main_frq] = descriptor_frq_pitch(gamma, zeta, res, t_end, Fs, FRQ_REF, NOTES)

[note_name, f_tampered, main_frq, n_cents] = simul_retrieve_pitch_feature(gamma, zeta, res, t_end, Fs, FRQ_REF, NOTES);

fprintf("Frq : %f \n", main_frq);
end

