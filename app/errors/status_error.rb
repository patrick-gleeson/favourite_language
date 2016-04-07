class StatusError < UserFriendlyError
  def message
    'I got an unexpected response back from GitHub'
  end
end
