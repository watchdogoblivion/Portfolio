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
		elsif portfolio_item.id == 7
			image_tag "f2f.png", width: "100%", alt: "Portfolio image"
		elsif portfolio_item.id == 8
			image_tag "estate.png", width: "100%", alt: "Portfolio image"
		else
			image_tag portfolio_img(portfolio_item.main_image.url, "main"), width: '100%'
	    end
	end

	def mark_color (subtitle)

		weight = "font-weight: bold;"

		if subtitle == "Java"
			return "color: green; #{weight}"
		elsif subtitle == "Ruby"
			return "color: red; #{weight}"
		elsif subtitle == "Python"
			return "color: blue; #{weight}"
		else
			return "color: #CCCC00; #{weight}"
		end

		return "";			
	end

    def user_buttons (portfolio_item, show = "index")

    	buttons = ""

        if (show == "index")
        	buttons << get_buttons(portfolio_item)[:user_index_page]
        end

		if (portfolio_item.id == 7 && show == "index") 
			buttons << get_buttons(portfolio_item)[:user_index_launch]
		elsif (portfolio_item.id == 7)
			buttons << get_buttons(portfolio_item)[:user_show_launch]
		end

		return buttons.html_safe
	end

	def admin_buttons (portfolio_item, show = "")
		if logged_in?(:site_admin) 
			if show == "show"
				get_buttons(portfolio_item)[:admin_show_page].html_safe
			else
			 	get_buttons(portfolio_item)[:admin_index_page].html_safe
			end
		end
	end

	def get_buttons (portfolio_item)

		buttons_hash = {

			admin_show_page:
			"<p>
				#{ link_to 'Edit Item', edit_portfolio_path(portfolio_item), class: 'btn btn-warning' }
				#{ link_to 'Delete', portfolio_item, method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-warning' }
		    </p>",

		    admin_index_page:
		    "<button type='button' class='btn btn-sm btn-outline-secondary'>
		 		#{ link_to 'Edit', edit_portfolio_path(portfolio_item.id) }
		 	</button>
		 	<button type='button' class='btn btn-sm btn-outline-secondary'>
		 		#{ link_to 'Delete',portfolio_item, method: :delete, data: { confirm: 'Are you sure?' } }
		 	</button>",

		 	user_index_page:
		 	" <button type='button' class='btn btn-sm btn-outline-secondary'>
		 		#{ link_to 'View', portfolio_show_path(portfolio_item.id) } 
		 	</button> ",

		 	user_index_launch:
		 	"<button type='button' class='btn btn-sm btn-outline-secondary'>
		 		#{ link_to 'Launch', '/doc/index.html', target: :_blank }
		 	</button>",

		 	user_show_launch:
		 	"#{ link_to 'Launch', '/doc/index.html', class: 'btn btn-warning',target: :_blank }"
		}

	end
				
end

#html safe seems to render html not html.erb, so in ruby file like this (.rb) use string
#interpolation for any ruby code
#when dealing with ruby methods, "" should surround '' in order for render to work