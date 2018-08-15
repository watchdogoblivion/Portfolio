module ApplicationHelper

	def login_helper(class_style = "", style = "")
		if current_user.is_a?(GuestUser)
			(link_to "Register", new_user_registration_path, class: class_style, style: style) + " ".html_safe +
	        (link_to "Login", new_user_session_path, class: class_style, style: style) 
	    else 
	        link_to "Logout", destroy_user_session_path, method: :delete, class: class_style, style: style 
        end
	end

	def source_helper(styles)
	    if session[:source] 
	    	greeting = "Thanks for visiting me from #{session[:source]}, 
	    	please feel free to #{ link_to 'contact me', contact_path} if you would like to work together."
		    content_tag(:div, greeting.html_safe, class: styles)
	    end 
	end

	def copyright_generator
		DorilasViewTool::Renderer.copyright "Samuel Dorilas", "All rights reserved"
	end

	def nav_items

		nav_items = 
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
				url: portfolios_path,
				title: "Portfolios"
			},
			{
				url: blogs_path,
				title: "Blogs"
			}
			
		]

	end


	def nav_helper (class_style, style = "")
    	nav_links = ""

    	nav_items.each do | item |
			nav_links << " <li><a href='#{item[:url]}' class='#{class_style} #{active? item[:url]}'
			style='#{style}'>#{item[:title]}</a></li>"
		end

  		nav_links.html_safe
	end

	def active? root_path
		"active" if this_page(root_path)
	end

	def this_page root_path
		if current_page? root_path
			true
		else 
			false
		end
	end

	def break_space (image = nil, counts = 0)
		br = ""

		unless image.nil?
			image[:iterate].times do 	
		  		br << "<br>"
		    end 
		else
			counts.times do
				br << "<br>"
			end
		end

		 br.html_safe
	end

	def about_me_items
		[
			{
				style1: "col-md-12",
				iterate: 1,
				image: "umb.jpg",
				width: "100%",
				style2: "",
				alt: "Umb image"
			},
			{
				style1: "col-md-12",
				iterate: 1,
				image: "acsm.jpg",
				width: "100%",
				style2: "",
				alt: "Acsm image"
			},
			{
				style1: "col-md-12",
				iterate: 1,
				image: "record.png",
				width: "100%",
				style2: "",
				alt: "Record image"
			},
			{
				style1: "col-md-6",
				iterate: 1,
				image: "posing2.jpg",
				width: "100%",
				style2: "",
				alt: "Posing image"
			},
			{
				style1: "col-md-6 ",
				iterate: 1,
				image: "awards.png",
				width: "100%",
				style2: "",
				alt: "Awards image"
			},
			{
				style1: "col-md-6",
				iterate: 1,
				image: "lifting1.png",
				width: "100%",
				style2: "",
				alt: "Lifting image"
			}
		]
	end

	def certification_items
		[
			{
				style1: "col-md-12",
				iterate: 2,
				image: "wgu.jpg",
				width: "100%",
				style2: "",
				alt: "Certification"
			},
			{
				style1: "col-md-12",
				iterate: 2,
				image: "network.png",
				width: "100%",
				style2: "",
				alt: "Certification"
			},
			{
				style1: "col-md-12",
				iterate: 2,
				image: "a_plus.png",
				width: "100%",
				style2: "",
				alt: "Certification"
			},
			{
				style1: "col-md-12",
				iterate: 2,
				image: "project.png",
				width: "100%",
				style2: "",
				alt: "Certification"
			},
			{
				style1: "col-md-12",
				iterate: 2,
				image: "site.png",
				width: "100%",
				style2: "",
				alt: "Certification"
			},
			{
				style1: "col-md-12",
				iterate: 2,
				image: "designer.png",
				width: "100%",
				style2: "",
				alt: "Certification"
			},
			{
				style1: "col-md-12",
				iterate: 2,
				image: "specialist.png",
				width: "100%",
				style2: "",
				alt: "Certification"
			},
			{
				style1: "col-md-12",
				iterate: 2,
				image: "associate.png",
				width: "100%",
				style2: "",
				alt: "Certification"
			},
			{
				style1: "col-md-12",
				iterate: 2,
				image: "professional.png",
				width: "100%",
				style2: "",
				alt: "Certification"
			}
		]
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
		js add_gritter(msg, title: "#{current_user.first_name}", sticky: false, time: 1700, :position => :bottom_left)
		
	end

	def alert_position
		js extend_gritter :position => :top_left 
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