require "rubygems"
require "rake"
require "echoe"

Echoe.new("authlogic_vkontakte", "0.1.0") do |p|
  p.description= "Bind vkontakte authentication to your authlogic project"
  p.url= "http://github.com/GarPit/authlogic_vkontakte"
  p.author= "Igor Petrov"
  p.email= "garik.piton@gmail.com"
  p.ignore_pattern= ["tmp/*", "script/*", ".idea/*"]
  p.development_dependencies= []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext}