class InviteController < ApplicationController
  def create
  	puts params
  	@invite = Invite.create(user:current_user, invitee:User.find(params[:format]))
    if @invite.save
      flash[:notice] = "Your invite has been sent"
    else
      flash[:notice] = "There was an error, please try again"
    end
    redirect_to users_path
  end
end
