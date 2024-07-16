function similarity = cosine_similarity(A, B)
  # the cosine similarity between two column vectors.
  A = A / max(abs(A));
  B = B / max(abs(B));
  similarity = dot(A, B) / (norm(A, 2) * norm(B, 2));
end
