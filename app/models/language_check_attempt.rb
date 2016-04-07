class LanguageCheckAttempt
  def initialize(successful: false, favourite_language: nil, error: nil)
    raise ArgumentError, 'No language provided' if successful &&
                                                   !favourite_language.present?

    raise ArgumentError, 'No error provided' if !successful &&
                                                !error.present?

    @successful = successful
    @favourite_language = favourite_language
    @error = error
  end

  def if_successful
    yield @favourite_language if @successful
  end

  def if_failed
    yield error_message unless @successful
  end

  private

  def error_message
    if @error.is_a? UserFriendlyError
      @error.message
    else
      'something went unexpectedly wrong'
    end
  end
end
