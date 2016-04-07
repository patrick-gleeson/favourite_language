class NoReposError < UserFriendlyError
  def message
    'the given user has no repos'
  end
end
