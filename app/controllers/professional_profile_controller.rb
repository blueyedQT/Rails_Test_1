class ProfessionalProfileController < ApplicationController
  before_action :require_logged_in

  def index
  	@user = User.find(current_user)
  end
end
