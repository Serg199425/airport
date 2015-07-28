class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_urls
  before_action :set_datetime
  layout :layout

  def set_urls
    gon.flights_index_path = flights_index_path
    gon.flights_history_path = flights_history_path
  end

  def set_datetime
    gon.datetime = Time.now.utc
  end

  private

  def layout
    is_a?(Devise::SessionsController) ? false : "application"
  end
end
