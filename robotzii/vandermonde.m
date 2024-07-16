function coef = vandermonde(x, y)
    % x = [x0, x1, ..., xn]'
    % y = [y0, y1, ..., yn]'
    % coef = [a0, a1, a2, ..., an]'
    n = length(x);
    A = ones(n, n);
    for i = 1 : n
        for j = 2 : n
            A(i, j) = x(i) ^ (j - 1);
        endfor
    endfor
    coef = A \ y';
endfunction
