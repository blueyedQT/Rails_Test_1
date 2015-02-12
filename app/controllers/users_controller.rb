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
  		redirect_to @user
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to root_path
  	end
  end

  def show 
  	@user = User.find(params[:id])
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
