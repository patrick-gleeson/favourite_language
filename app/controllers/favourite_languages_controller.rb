class FavouriteLanguagesController < ApplicationController
  def show
    result = FavouriteLanguageFinder.new.find_favourite_language(@username)

    result.if_successful do |favourite_language|
      @favourite_language = favourite_language
    end

    result.if_failed do |error_message|
      @error_message = error_message
      render :error
    end
  end
end
