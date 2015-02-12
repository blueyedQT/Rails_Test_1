class UsersController < ApplicationController
  def new
  	@user = User.new
  	@errors = flash[:errors]
  end

  def create
  	@user = User.create(user_params)
  	if @user.save
  		## login 
  		render :text => "Congratulatons!"
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to root_path
  	end
  end

  def update
  end

  def edit
  end

  private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
