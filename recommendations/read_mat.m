function mat = read_mat(path)
  # Parses the .csv file and returns the matrix of
  # values (without row and column headers).
  in = fopen(path, 'r');
  if in == -1
    disp('Could not open file');
    return;
  endif
  mat = [];
  % read starting from line and column 1 of the file
  mat = csvread(path, 1, 1);
  fclose(in);
end
