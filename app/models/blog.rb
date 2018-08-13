class Blog < ApplicationRecord

	enum status: {draft: 0, published: 1}
    enum featured: {not_featured: 0, featured: 1}

	 extend FriendlyId
     friendly_id :title, use: :slugged

     validates_presence_of :title, :body, :topic_id

     belongs_to :topic

     has_many :comments, dependent: :destroy

     def self.recent
     	order("created_at DESC")
     end

     scope :published_blogs, -> {where(status: 'published')}
     scope :drafted_blogs, -> {where(status: 'draft')}
end
