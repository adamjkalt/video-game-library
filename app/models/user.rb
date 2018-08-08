class User < ActiveRecord::Base
	has_secure_password

  has_many :games
  has_many :consoles

	def slug
		username.downcase.gsub(" ","-")
	end

	def self.find_by_slug(slug)
	  User.all.find { |user| user.slug == slug}
	end

end
