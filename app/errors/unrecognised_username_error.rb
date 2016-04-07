class UnrecognisedUsernameError < UserFriendlyError
  def message
    "GitHub doesn't know any user with that username"
  end
end
