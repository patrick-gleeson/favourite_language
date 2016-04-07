class RepoAnalyzer
  def favourite_language(repo_array)
    raise NoReposError unless repo_array.count > 0

    frequencies = repo_array.each_with_object({}) do |repo, freqs|
      freqs[repo['language']] = (freqs[repo['language']] || 0) + 1
      freqs
    end

    frequencies.max_by { |_k, v| v }[0]
  end
end
