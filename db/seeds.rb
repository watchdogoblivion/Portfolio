3.times do |topic|
	Topic.create!(
		title: "Topic #{topic}"
		)
end

puts "3 Topics created"

10.times do |blog| 
	Blog.create!(
		title: "My Blog Post #{blog}", 
		body: "OK",
		topic_id: Topic.last.id
		)
end

puts "10 posts created"

5.times do |skill|
	Skill.create!(
		title: "Rails #{skill}",
		percent_utilized: 15
		)
end

puts "5 created"

8.times do |portfolio_items|
	Portfolio.create!(
		title: "Portfolio title: #{portfolio_items}",
		subtitle: "Ruby on Rails",
		body: "magna",
		main_image:"http://via.placeholder.com/600x400",
		thumb_image: "http://via.placeholder.com/350x200"
		)
end

1.times do |portfolio_items|
	Portfolio.create!(
		title: "Portfolio title: #{portfolio_items}",
		subtitle: "Angular",
		body: "magna",
		main_image:"http://via.placeholder.com/600x400",
		thumb_image: "http://via.placeholder.com/350x200"
		)
end

puts "9 portfolio items created"

3.times do |technology|
	Portfolio.last.technologies.create!(
		name: "Technology #{technology}"
		)
end

puts "3 technologies created"

