class PagesController < ApplicationController
  def home
  	@posts = Blog.all
  	@skills = Skill.all
  end

  def about
  end

  def contact
  end

  def more_about_me
  end

  def certifications
  end
end
