class Portfolio < ApplicationRecord
	has_many :technologies
	accepts_nested_attributes_for :technologies, reject_if: lambda { |attrs| attrs['name'].blank?}

	include Placeholder
	validates_presence_of :title, :body, :main_image, :thumb_image

	#both of the following do the same thing for different subtitles
	def self.angular
		where(subtitle: 'Angular')
	end

	scope :ruby_on_Rails, -> {where(subtitle: 'Ruby on Rails')}

	after_initialize :set_defaults

	def set_defaults
		self.main_image ||= Placeholder.image_generator(height: '600', width: '400')
		self.thumb_image ||= Placeholder.image_generator(height: '350', width: '200')
	end
	#you set defaults in migration or model like above
	#||= is like if a.nil? a ="" else do nothing


end
