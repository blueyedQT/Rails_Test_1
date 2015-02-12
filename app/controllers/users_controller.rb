class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  	@errors = flash[:errors]
  end

  def create
  	@user = User.create(user_params)
  	if @user.save
  		## login 
  		redirect_to professional_profile_index_path
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to root_path
  	end
  end

  def show 
  	@user = User.find(params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to professional_profile_index_path
  	else
  		flash[:errors] = @user.errors.full_messages
  		puts @user.errors.full_messages
  		redirect_to edit_user_path @user
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation, :description)
  end
end
