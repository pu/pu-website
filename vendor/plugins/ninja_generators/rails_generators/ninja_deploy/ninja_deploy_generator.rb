class NinjaDeployGenerator < Rails::Generator::NamedBase

  def manifest
    record do |m|
      m.file 'deploy.rb', 'config/deploy.rb'
      
      m.directory 'config/deploy'
      m.file 'deploy/config.rb.example', 'config/deploy/config.rb.example'
      
      m.template 'deploy/production.rb', 'config/deploy/production.rb'
      m.template 'deploy/staging.rb', 'config/deploy/staging.rb'
    end
  end
  
end