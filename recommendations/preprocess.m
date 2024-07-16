function reduced_mat = preprocess(mat, min_reviews)
  # Removes all user rows from `mat` that
  # have strictly less then `min_reviews` reviews.
  % array that holds the number of reviews per row
  cnt = sum(mat ~= 0, 2);
  % array of 0s and 1s
  row_mask = cnt >= min_reviews;
  reduced_mat = mat(row_mask, :);
end
