class Portfolio < ApplicationRecord
	validates_presence_of :title, :body, :main_image, :thumb_image

	#both of the following do the same thing for different subtitles
	def self.angular
		where(subtitle: 'Angular')
	end

	scope :ruby_on_Rails, -> {where(subtitle: 'Ruby on Rails')}
end
