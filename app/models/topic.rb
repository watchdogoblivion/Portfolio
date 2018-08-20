class Topic < ApplicationRecord

	 validates_presence_of :title

	 has_many :blogs

	 def self.with_blogs
	 	includes(:blogs).where.not(blogs: {status: :draft})
	 end

	def self.recent
     	order("topics.title ASC")
    end

end
