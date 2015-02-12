class ProfessionalProfileController < ApplicationController
  def index
  	@user = User.find(9) # need to fix this
  end
end
