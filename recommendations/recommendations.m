function recoms = recommendations(path, liked_theme, num_recoms, min_reviews, num_features)
  # TODO: Get the best `num_recoms` recommandations similar with 'liked_theme'.
  mat = read_mat(path);
  mat = preprocess(mat, min_reviews);
  [U, S, V] = svds(mat, num_features);

  [m n] = size(V);
  sim = []; % similarity array
  index_ = []; % index_of_column array
  for i = 1 : m
    sim = [sim; cosine_similarity(V(i, :), V(liked_theme, :))];
    index_ = [index_; i];
  endfor

  [max, max_index] = max(sim);
  % overwrite the value of the liked_theme index with -1
  sim(max_index) = -1;
  data = [sim, index_];
  data = sortrows(data, -1);
  recoms = data(1 : num_recoms, 2)';

end
