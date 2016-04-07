class RepoAnalyzer
  def favourite_language(repo_array)
    languaged_repos = repo_array.select { |a| !a['language'].nil? }

    raise NoReposError unless languaged_repos.count > 0

    frequencies = languaged_repos.each_with_object({}) do |repo, freqs|
      freqs[repo['language']] = (freqs[repo['language']] || 0) + 1
      freqs
    end

    frequencies.max_by { |_k, v| v }[0]
  end
end
