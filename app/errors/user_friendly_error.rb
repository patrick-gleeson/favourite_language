class UserFriendlyError < StandardError
  def message
    raise NotImplementedError,
          'UserFriendlyErrors must define a user-friendly message string'
  end
end
