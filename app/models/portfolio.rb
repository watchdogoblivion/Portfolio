class Portfolio < ApplicationRecord
	has_many :technologies
	accepts_nested_attributes_for :technologies, 
	                              allow_destroy: true,
	                              reject_if: lambda { |attrs| attrs['name'].blank?}

	validates_presence_of :title, :body

	 mount_uploader :thumb_image, PortfolioUploader
	 mount_uploader :main_image, PortfolioUploader

	#both of the following do the same thing for different subtitles
	def self.angular
		where(subtitle: 'Angular')
	end

	scope :ruby_on_Rails, -> {where(subtitle: 'Ruby on Rails')}

	#you set defaults in migration or model like above
	#||= is like if a.nil? a ="" else do nothing

	def self.by_position
		order("position ASC")
	end


end
