function y_interp = P_vandermonde (coef, x_interp)
	% P_vandermonde(x) = a0 + a1 * x + a2 * x^2 + ... + an * x^n
	% coef = [a0, a1, a2, ..., an]'
	% y_interp(i) = P_vandermonde(x_interp(i)), i = 0 : length(x_interp) - 1
	
	% Computes y_interp using the Vandermonde coefficients
	n = length(x_interp);
	m = length(coef);
	y_interp = zeros(size(x_interp));
	for i = 1 : n
		y_interp(i) = coef(1);
		for k = 2 : m
			y_interp(i) = y_interp(i) + coef(k) * (x_interp(i) ^ (k - 1));
		endfor
	endfor
end
