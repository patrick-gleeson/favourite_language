class GitHubClient
  include HTTParty
  base_uri 'https://api.github.com'

  def repo_array(username)
    raise InvalidUsernameError unless valid_username?(username)

    begin
      response = self.class.get "/users/#{username}/repos"
    rescue HTTParty::Error
      raise ConnectionError
    end

    process_response response
  end

  private

  ILLEGAL_CHARACTER_REGEX = /[^a-zA-Z0-9\-]/

  def valid_username?(username)
    (ILLEGAL_CHARACTER_REGEX =~ username).nil?
  end

  def process_response(response)
    raise UnrecognisedUsernameError if response.code == 404
    raise StatusError unless response.code == 200
    JSON.parse response.body
  end
end
