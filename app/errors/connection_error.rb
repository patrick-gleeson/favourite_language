class ConnectionError < UserFriendlyError
  def message
    "I couldn't make contact with GitHub"
  end
end
