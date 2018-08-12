module BlogsHelper
	def gravatar_helper user
			image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}", width: 60
	end

	class CodeRayify < Redcarpet::Render::HTML
		def block_code(code, language)
			CodeRay.scan(code, language).div
		end
	end

	def markdown(text)
		coderayified = CodeRayify.new(filter_html: true, hard_wrap: true)

		options = {
			fenced_code_blocks: true,
			no_intra_emphasis: true, 
			autolinks: true,
			lax_html_blocks: true
		}

		markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
		markdown_to_html.render(text).html_safe
	end

    def blog_head_links
    	if logged_in?(:site_admin)
    		'<nav class="breadcrumb">'.html_safe + 
	    	(link_to 'Write a new Blog', new_blog_path, class:"breadcrumb-item") +
            ' '.html_safe +
	    	(link_to 'Published Blogs', published_path, class:"breadcrumb-item") + 
	    	' '.html_safe +
	    	(link_to 'Drafted Blogs', draft_path, class:"breadcrumb-item") + 
	    	' '.html_safe +
	    	(link_to 'All Blogs', blogs_path, class:"breadcrumb-item") + 
	    	'</nav>'.html_safe
	    end 
    end

    def line_limiter(object, lines)
    	count = 0
    	string = ""
    	object.each_line do |s|
    		string << s
    		count = count + 1
    		return string if count == lines
    	end
    	string
    end

    def icons_helper(object, css_class="")
    	if logged_in?(:site_admin)
			   (link_to fa_icon("file-text"), toggle_status_blog_path(object), class: css_class, style: icon_color(object, "file")) + " ".html_safe +
			   (link_to fa_icon("star"), toggle_featured_blog_path(object), class: css_class, style: icon_color(object,"star")) + " ".html_safe +
			   (link_to fa_icon("pencil-square-o"), edit_blog_path(object), class: css_class ) + " ".html_safe +
	           (link_to fa_icon("trash"), object, method: :delete, data: { confirm: 'Are you sure?' }, class: css_class)
		end
    end

    def icon_color(object, icon = "")
       case icon
		when "file"
		  if object.draft?
		  	'color: red;'
		  else
		  	'color: green;'
		  end
		when "star"
		  if object.featured?
		  	'color: yellow;'
		  else
		  	'color: grey;'
		  end
		else
		  ""
		end
    end

end
