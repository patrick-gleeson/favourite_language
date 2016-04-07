class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_username

  private

  def set_username
    # So this variable is always accessible to the main layout
    @username = params[:username]
  end
end
