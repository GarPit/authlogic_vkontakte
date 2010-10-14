namespace :vkontakte do
    desc "Init resources for plugin"
    task :init => [:yml, :javascripts]

    desc "Copy vkontakte.yml to current rails application"
    task :yml do
      puts "Copying YAML file..."
      project_dir = RAILS_ROOT
      yml = File.join(File.dirname(__FILE__), '..', '..', 'vkontakte.yml')    
      FileUtils.cp(yml, project_dir)
      puts "vkontakte.yml copied successfully!"
    end 

    desc "Copy javascript to current rails application"
    task :javascripts do
      puts "Copying javascript files..."
      project_dir = RAILS_ROOT + '/public/javascripts/'
      scripts = Dir[File.join(File.dirname(__FILE__), '..', '..', '/js/', '*.js')]     
      FileUtils.cp(scripts, project_dir)
      puts "Files copied successfully!"
    end  
end
