class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.authenticate(params[:session][:email], params[:session][:password])
  	if user.nil?
  		flash[:notice] = 'User not found!'
  		redirect_to root_path
  	else 
  		log_in user
  		redirect_to professional_profile_index_path
  	end
  end

  def destroy
  	log_out
  	flash[:notice] = "You have sucessfully logged out"
  	redirect_to root_path
  end
end
