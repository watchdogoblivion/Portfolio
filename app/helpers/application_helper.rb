module ApplicationHelper

	def login_helper(style = "")
		if current_user.is_a?(GuestUser)
			(link_to "Register", new_user_registration_path, class: style) + " ".html_safe +
	        (link_to "Login", new_user_session_path, class: style) 
	    else 
	        link_to "Logout", destroy_user_session_path, method: :delete, class: style 
        end
	end

	def source_helper
	    if session[:source] 
	    	greeting = "Thanks for visiting me from #{session[:source]}"
		    content_tag(:p, greeting, class: "source-greeting")
	    end 
	end

	def copyright_generator
		DorilasViewTool::Renderer.copyright "Samuel Dorilas", "All rights reserved"
	end

	def nav_items
		[
			{
				url: root_path,
				title: "Home"
			},
			{
				url: about_me_path,
				title: "About"
			},
			{
				url: contact_path,
				title: "Contact"
			},
			{
				url: blogs_path,
				title: "Blogs"
			},
			{
				url: portfolios_path,
				title: "Portfolios"
			}
		]
	end



	def nav_helper (style)
    	nav_links = ""

    	nav_items.each do | item |
			nav_links << " <a href='#{item[:url]}' class='#{style} #{active? item[:url]}'>#{item[:title]}</a>"
		end

  		nav_links.html_safe
	end

	def active? root_path
		"active" if current_page? root_path
	end

	def video_helper(video, poster)
		 video_tag(
                          video, 
                          id:  "background",
                          autoplay: true,
                          loop: true,
                          muted: true,
                          poster: poster)
	end


	def alerts
		alert = (flash[:alert] || flash[:error] || flash[:notice])

		if alert
			alert_generator alert
		end
	end

	def alert_generator msg
		js add_gritter(msg, title: "#{current_user.first_name}", sticky: false)
	end
end

		# (link_to "Home", root_path, class: "nav-link") + " " +
  #              (link_to "About Me", about_me_path, class: "nav-link") + " " +
  #              (link_to "Contact", contact_path, class: "nav-link") + " " +
  #              (link_to "Blog", blogs_path, class: "nav-link") + " " +
  #              (link_to "Portfolio", portfolios_path, class: "nav-link") + " " +
  #              (login_helper("nav-link"))
  # ruby can return this as a string and it parses it correctly, adding the embedded ruby tags between
  # each link to