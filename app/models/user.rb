class User < ActiveRecord::Base
	attr_accessor :password, :password_confirmation
	email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

	# validates :name, presence: true, length: { in: 2..15 }
	# validates :email, presence: true, format: { with: email_regex }, uniqueness: { case_sensitive: false }
	# validates :password, presence: true, length: { in: 6..10 }, confirmation: true

	before_save :encrypt_password
	before_save do
		self.email.downcase!	
	end

	### For Login ###

	private 
	def encrypt_password
		self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{self.password}") if self.new_record?
		self.encrypted_password = encrypt(self.encrypted_password)
	end

	def encrypt(password)
		Digest::SHA2.hexdigest("#{self.salt}--#{password}")
	end
end
