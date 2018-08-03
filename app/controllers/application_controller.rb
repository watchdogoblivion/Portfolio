class ApplicationController < ActionController::Base
	include DeviseWhitelist
	include SetSource
	include CurrentUserConcern
	include DefaultPageContent

	before_action :set_copyright

	def set_copyright
		@copyright = DorilasViewTool::Renderer.copyright "Samuel Dorilas", "All rights reserved"
	end
	
end

