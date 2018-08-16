module PortfoliosHelper

	def image_generator(height:, width:)
		"http://via.placeholder.com/#{height}x#{width}"
	end

	def portfolio_img img, type
		# if img.model.main_image? || img.model.thumb_image?
		if img
			img 
		elsif type == "thumb"
			image_generator(height: "350", width: "200")
		elsif type == "main"
			image_generator(height: "400", width: "400")
		end
	end

	def place_images (portfolio_item)
	    if portfolio_item.id == 1
	    	image_tag "student_scheduler.png", width: "100%", alt: "Portfolio image"
	    elsif portfolio_item.id == 2
		    image_tag "sprint.png", width: "100%", alt: "Portfolio image"
		else
			image_tag portfolio_img(portfolio_item.main_image.url, "main"), width: '100%'
	    end
	end
				
end
