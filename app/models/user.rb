class User < ActiveRecord::Base
	has_many :invites
	has_many :invitees, class_name: "User", foreign_key: "invitee_id", :through => :invites

	attr_accessor :password, :password_confirmation
	email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

	validates :name, presence: true, length: { minimum: 2, maximum: 20 }
	validates :email, presence: true, format: { with: email_regex }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, confirmation: true

	before_save :encrypt_password
	before_save do 
		self.email.downcase!
	end

	def has_password?(submitted_password)
		self.encrypted_password == encrypt(submitted_password)
		puts 'This is the enctryped password: '
		puts self.encrypted_password
		puts 'This is the password: '
		puts encrypt(submitted_password)
	end

	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end

	private
		def encrypt_password
			self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{self.password}") if self.new_record?
			self.encrypted_password = encrypt(self.encrypted_password)
		end

		def encrypt(password)
			Digest::SHA2.hexdigest("#{self.salt}--#{password}")
		end
end
