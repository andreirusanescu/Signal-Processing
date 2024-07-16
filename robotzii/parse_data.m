function [x, y] = parse_data(filename)
    % file input format:
    % n
    % x0 x1 ... xn
    % y0 y1 ... yn

    % Open the file for reading
    in = fopen(filename, 'r');
    if in == -1
        disp('File could not be opened');
        return;
    endif
    n = fscanf(in, '%d ', 1);
    x = zeros(1, n + 1);
    for i = 1 : n + 1
        x(i) = fscanf(in, '%d ', 1);
    endfor
    y = zeros(1, n + 1);
    for i = 1 : n + 1
        y(i) = fscanf(in, '%d ', 1);
    endfor
    fclose(in);
end