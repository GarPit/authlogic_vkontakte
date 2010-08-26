namespace :vkontakte do
    desc "Copy javascript to current rails application"
    task :javascripts do
      puts "Copying javascript files..."
      project_dir = RAILS_ROOT + '/public/javascripts/'
      scripts = Dir[File.join(File.dirname(__FILE__), '..', '..', '/js/', '*.js')]     
      FileUtils.cp(scripts, project_dir)
      puts "Files copied successfully!"
    end  
end
