class NoReposError < UserFriendlyError
  def message
    'the given user has no repos with identifiable languages'
  end
end
