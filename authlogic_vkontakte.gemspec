# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{authlogic_vkontakte}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Igor Petrov"]
  s.date = %q{2010-10-11}
  s.description = %q{Bind vkontakte authentication to your authlogic project}
  s.email = %q{garik.piton@gmail.com}
  s.extra_rdoc_files = ["README.rdoc", "lib/profile_loader.rb", "lib/settings.rb", "lib/tasks/vkontakte.rake", "lib/vkontakte_authentication.rb", "lib/vkontakte_helper.rb"]
  s.files = ["README.rdoc", "Rakefile", "authlogic_vkontakte.gemspec", "init.rb", "js/vkontakte.js", "lib/profile_loader.rb", "lib/settings.rb", "lib/tasks/vkontakte.rake", "lib/vkontakte_authentication.rb", "lib/vkontakte_helper.rb", "Manifest"]
  s.homepage = %q{http://github.com/GarPit/authlogic_vkontakte}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Authlogic_vkontakte", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{authlogic_vkontakte}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Bind vkontakte authentication to your authlogic project}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
