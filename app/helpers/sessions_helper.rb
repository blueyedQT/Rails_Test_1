module SessionsHelper
	def log_in(user)
		session[:user_id] = user.id 
		self.current_user=(user)
	end

	def current_user=(user)
	 	@current_user = user
	end

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!current_user.nil?
	end

	def log_out
		session[:user_id] = nil
		self.current_user = nil
	end

	def current_user?(user)
		user == self.current_user
	end

	def require_logged_in
		if !logged_in?
			deny_access
		end
	end

	def deny_access
		flash[:notice] = "Please sign in to access this page"
		redirect_to '/'
	end
end

