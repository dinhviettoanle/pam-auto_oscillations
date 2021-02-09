function [f_tampered, n_cents] = descriptor_nearest_pitch(gamma, zeta, res, t_end, Fs, FRQ_REF, NOTES)

[note_name, f_tampered, main_frq, n_cents] = simul_retrieve_pitch_feature(gamma, zeta, res, t_end, Fs, FRQ_REF, NOTES);

fprintf("Main frq : %f | Nearest : %s | Delta cents : %f \n", main_frq, note_name, n_cents);
end

