class FavouriteLanguageFinder
  def find_favourite_language(username)
    repo_array = git_hub_client.repo_array(username)
    favourite = repo_analyzer.favourite_language(repo_array)
    LanguageCheckAttempt.new successful: true, favourite_language: favourite

  rescue StandardError => error
    LanguageCheckAttempt.new successful: false, error: error
  end

  private

  def repo_analyzer
    @repo_analyzer ||= RepoAnalyzer.new
  end

  def git_hub_client
    @git_hub_client ||= GitHubClient.new
  end
end
