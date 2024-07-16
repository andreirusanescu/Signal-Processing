function coef = spline_c2(x, y)
	% si(x)   = ai + bi(x - xi) + ci(x - xi)^2 + di(x - xi)^3
	% si'(x)  =      bi         + 2ci(x - xi)  + 3di(x - xi)^2
	% si''(x) =                   2ci          + 6di(x - xi)
	n = length(x);
	A = zeros(4 * (n - 1), 4 * (n - 1));
	b = zeros(4 * (n - 1), 1);
	b(1 : n) = y(1 : n);
	s = zeros(n - 1, 2, 4);
	% s(i, 1, :) = value of the spline in the first x
	% s(i, 2, :) = value of the spline in the second x
	for i = 1 : n - 1
		s(i, 1, 1) = 1;
		s(i, 2, 1) = 1;
		s(i, 2, 2) = x(i + 1) - x(i);
		s(i, 2, 3) = (x(i + 1) - x(i)) ^ 2;
		s(i, 2, 4) = (x(i + 1) - x(i)) ^ 3;
		A(i, (i - 1) * 4 + 1) = 1;
	endfor
	% Loaded the first n + 1 equations.
	% s_n-1(xn) = y_n
	A(n, (n - 2) * 4 + (1 : 4)) = s(n - 1, 2, 1 : 4);

	% load 3 * (n - 1):
	% n = 3 => 3 * 1 = 3
	for i = 1 : n - 2
		% aux is used for first derivative
		aux = zeros(1, 4);
		aux(2) = 1;
		aux(3) = 2 * (x(i + 1) - x(i));
		aux(4) = 3 * (x(i + 1) - x(i)) ^ 2;

		% tmp is used for second derivative
		tmp = zeros(1, 4);
		tmp(3) = 2;
		tmp(4) = 6 * (x(i + 1) - x(i));

		% si(xi+1) - si+1(xi+1);
		A(n + (i - 1) * 3 + 1, (i - 1) * 4 + (1 : 4)) = s(i, 2, 1 : 4);
		A(n + (i - 1) * 3 + 1, (i - 1) * 4 + 4 + (1 : 4)) = -s(i + 1, 1, 1 : 4);

		% load the derivative of si(xi+1);
		A(n + (i - 1) * 3 + 1 + 1, (i - 1) * 4 + (1 : 4)) = aux(1 : 4);

		% load the 2nd derivative of si(xi+1);
		A(n + (i - 1) * 3 + 1 + 2, (i - 1) * 4 + (1 : 4)) = tmp(1 : 4);

		% 1st derivative of si+1(xi+1) is always 1 * smth
		A(n + (i - 1) * 3 + 1 + 1, (i - 1) * 4 + 6) = -1;

		% 2nd derivative of si+1(xi+1) is always 2 * smth
		A(n + (i - 1) * 3 + 1 + 2, (i - 1) * 4 + 7) = -2;
	endfor

	% last two rows
	A(4 * (n - 1) - 1, 3) = 2;
	A(4 * (n - 1), 4 * (n - 1) - 1) = 2;
	A(4 * (n - 1), 4 * (n - 1)) = 6 * (x(n) - x(n - 1));
	coef = A \ b;
end
