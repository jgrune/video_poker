class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user

  def set_current_user
   if User.exists?(session[:user_id])    # If there is a user_id currently stored in the session hash...
     @current_user = User.find(session[:user_id])  # ...find and save that user in @current_user
   else
     @current_user = nil   # ...otherwise, set @current_user to nil
   end
 end
 
end
