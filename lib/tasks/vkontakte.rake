namespace :vkontakte do
    desc "Init resources for plugin"
    task :init => [:yml, :resources]

    desc "Copy vkontakte.yml to current rails application"
    task :yml do
      puts "Copying YAML file..."
      project_dir = RAILS_ROOT
      yml = File.join(File.dirname(__FILE__), '..', '..', 'vkontakte.yml')    
      FileUtils.cp(yml, project_dir)
      puts "vkontakte.yml copied successfully!"
    end 

    desc "Copy resources to current rails application"
    task :resources do
      puts "Copying resources files..."
      project_dir = RAILS_ROOT + '/public/javascripts/'
      scripts = Dir[File.join(File.dirname(__FILE__), '..', '..', '/resources/', '*.js')]     
      htmls = Dir[File.join(File.dirname(__FILE__), '..', '..', '/resources/', '*.html')]
      FileUtils.cp(scripts, project_dir)
      FileUtils.cp(htmls, RAILS_ROOT + '/public/')
      puts "Files copied successfully!"
    end  
end
