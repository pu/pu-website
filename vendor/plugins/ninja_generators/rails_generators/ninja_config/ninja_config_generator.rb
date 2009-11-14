class NinjaConfigGenerator < Rails::Generator::NamedBase

  def manifest
    record do |m|
      m.file 'gitignore', '.gitignore'
      m.file 'application_controller.rb', 'app/controllers/application_controller.rb'
      m.file 'hoptoad.rb', 'config/initializers/hoptoad.rb'
      m.file 'field_with_errors.rb', 'config/initializers/field_with_errors.rb'
      m.file 'mailer.yml', 'config/mailer.yml'
      m.file 'mailer.rb', 'config/initializers/mailer.rb'
      m.file 'asset_packages.yml', 'config/asset_packages.yml'
      
      m.template 'newrelic.yml', 'config/newrelic.yml'
      m.template 'settings.yml', 'config/settings.yml'
    end
  end
  
end