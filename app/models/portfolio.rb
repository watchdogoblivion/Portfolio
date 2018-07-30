class Portfolio < ApplicationRecord
	validates_presence_of :title, :body, :main_image, :thumb_image

	#both of the following do the same thing for different subtitles
	def self.angular
		where(subtitle: 'Angular')
	end

	scope :ruby_on_Rails, -> {where(subtitle: 'Ruby on Rails')}

	after_initialize :set_defaults

	def set_defaults
		self.main_image ||= "http://via.placeholder.com/600x400"
		self.thumb_image ||= "http://via.placeholder.com/350x200"
	end
	#you set defaults in migration or model like above
	#||= is like if a.nil? a ="" else do nothing


end
