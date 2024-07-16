function y_interp = P_spline (coef, x, x_interp)
	% si(x)   = ai + bi(x - xi) + ci(x - xi)^2 + di(x - xi)^3, i = 0 : n - 1
	% coef = [a0, b0, c0, d0, a1, b1, c1, d1, ..., an-1, bn-1, cn-1, dn-1]
	% x = [x0, x1, ..., xn]
	% y_interp(i) = P_spline(x_interp(i)), i = 0 : length(x_interp) - 1

	% Calculates y_interp using the Spline coefficients
	n = length(x);
	y_interp = zeros(size(x_interp));
	j = 1;
	for i = 1 : n - 1
		a = coef((i - 1) * 4 + 1);
		b = coef((i - 1) * 4 + 2);
		c = coef((i - 1) * 4 + 3);
		d = coef((i - 1) * 4 + 4);
		while (j <= length(x_interp)) && (x(i) <= x_interp(j)) && (x_interp(j) <= x(i + 1))
			dif = (x_interp(j) - x(i));
			y_interp(j) = a + b * dif + c * dif ^ 2 + d * dif ^ 3;
			++j;
		endwhile
	endfor
end
