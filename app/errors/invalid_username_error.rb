class InvalidUsernameError < UserFriendlyError
  def message
    "that's not a valid username"
  end
end
