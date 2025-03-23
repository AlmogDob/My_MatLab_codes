function [mat] = complex_to_mag_and_angle(vec_mat)

for j = 1:length(vec_mat(1, :))
    for i = 1:length(vec_mat(:, 1))
        mat(i,j*2-1) = abs(vec_mat(i,j));
        mat(i,j*2) = rad2deg(atan2(imag(vec_mat(i, j)), real(vec_mat(i, j))));
    end
end

end

